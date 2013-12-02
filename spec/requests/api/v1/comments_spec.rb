require 'spec_helper'

describe "Comments API" do
	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 'X-AUTH-TOKEN' => 'fill_in' } }
	let(:t_post) { FactoryGirl.create :post }

	describe "#create" do
		let(:params) { {content: 'Lorem ipsum'} }
		context "when user is authenticated and authorized" do
			before do
				user = FactoryGirl.create :user
				FactoryGirl.create :request, accepted: true, user: user, trip: t_post.trip
				headers['X-AUTH-TOKEN'] = user.authentication_token
			end

			it "should create a comment" do
				expect{create_comment(t_post,params)}.to change(Comment, :count).by(1)
				expect(response).to be_success
				expect(json['content']).to eq(params[:content])
			end
		end

		context "when user is not authorized" do
			before do
				user = FactoryGirl.create :user
				FactoryGirl.create :request, accepted: false, user: user, trip: t_post.trip
				headers[:authentication_token] = user.authentication_token
			end

			it "should not create a comment" do
				expect{create_comment(t_post,params)}.to_not change(Comment, :count)
				expect(response.response_code).to eq(401)
			end
		end
	end

	describe "#update" do
		let(:params) { {content: 'Lorem not ipsum'} }
		let(:comment) { comment = FactoryGirl.create :comment }
		context "when user owns comment" do
			before { headers['X-AUTH-TOKEN'] = comment.user.authentication_token }

			it "should update the comment" do
				update_comment(comment,params)
				expect{comment.reload}.to change(comment,:content)				
				expect(response).to be_success
				expect(json['content']).to eq(params[:content])
			end
		end

		context "when user does not own comment" do
			before do
				bad_user = FactoryGirl.create :user
				FactoryGirl.create :request, accepted: true, trip: comment.post.trip, user: bad_user
				headers['X-AUTH-TOKEN'] = bad_user.authentication_token
			end

			it "should not update the comment" do
				update_comment(comment,params)
				expect{comment.reload}.to_not change(comment,:content)
				expect(response.response_code).to eq(401)
			end
		end
	end

	describe "#delete" do
		let(:comment) { comment = FactoryGirl.create :comment }
		context "when user owns trip" do
			before { headers['X-AUTH-TOKEN'] = comment.post.trip.owner.authentication_token }
			it "should delete the comment" do
				expect{delete_comment(comment)}.to change(Comment, :count).by(-1)
				expect(response).to be_success
			end
		end

		context "when user owns comment" do
			before { headers['X-AUTH-TOKEN'] = comment.user.authentication_token }
			it "should delete the comment" do
				expect{delete_comment(comment)}.to change(Comment, :count).by(-1)
				expect(response).to be_success
			end
		end

		context "when user does not own comment or is trip owner" do
			before do
			  bad_user = FactoryGirl.create :user
			  FactoryGirl.create :request, accepted: true, trip: comment.post.trip, user: bad_user
			  headers['X-AUTH-TOKEN'] = bad_user.authentication_token
			end
			it "should not delete the comment" do
				expect{delete_comment(comment)}.to_not change(Comment, :count)
				expect(response.response_code).to eq(401)
			end
		end

	end

end

def delete_comment(comment)
	delete api_v1_comment_path(comment), {}, headers
end

def update_comment(comment, params)
	patch api_v1_comment_path(comment), params, headers
end

def create_comment(t_post,params)
	post api_v1_post_comments_path(t_post), params, headers
end