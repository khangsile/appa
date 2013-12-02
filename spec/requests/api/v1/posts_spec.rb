require 'spec_helper'

describe 'Posts API' do
	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 'X-AUTH-TOKEN' => 'fill_in' } }

	describe "#create" do
		let(:request) { FactoryGirl.create(:request, accepted: true) }
		context "when user belongs to trip" do
			before { headers['X-AUTH-TOKEN'] = request.user.authentication_token }
			it "should create a post" do
				expect{create_post(request.trip,{content: 'Lorem ipsum'})}.to change(Post, :count).by(1)
				expect(response).to be_success
				expect(json['content']).to eq('Lorem ipsum')
				expect(json['user']['first_name']).to eq(request.user.first_name)
			end
		end

		context "when user does belong to trip" do
			before { headers['X-AUTH-TOKEN'] = FactoryGirl.create(:user).authentication_token }
			it "should not create a post" do
				expect{create_post(request.trip,{content: 'Lorem ipsum'})}.to_not change(Post, :count)
				expect(response.response_code).to eq(401)
			end
		end		
	end

	describe "#update" do
		let(:post) { FactoryGirl.create :post }
		context "when user owns post" do
			before { headers['X-AUTH-TOKEN'] = post.user.authentication_token }
			it "should update post" do
				update_post(post,content: 'Ipsum lorem')
				expect(response).to be_success
				expect{post.reload}.to change(post, :content)
				expect(json['content']).to eq('Ipsum lorem')
			end
		end

		context "when user does not own post" do
			before { headers['X-AUTH-TOKEN'] = FactoryGirl.create(:user).authentication_token }
			it "should update post" do
				update_post(post,content: 'Ipsum lorem')
				expect(response.response_code).to eq(401)
				expect{post.reload}.to_not change(post, :content)
			end
		end
	end

	describe "#show" do
		let(:post) { FactoryGirl.create :post }
		let(:user) { FactoryGirl.create :user }

		context "when user belongs to trip" do
			before do
				Rails.logger.info 'prepend'
        FactoryGirl.create(:request, user: user, trip: post.trip, accepted: true)
			  headers['X-AUTH-TOKEN'] = user.authentication_token
  			show_post(post)
			end

			it "should show trip" do 
				expect(json['content']).to eq(post.content)
				expect(response).to be_success
			end
		end

		context "when user has requested trip but is not accepted" do
			before do
				FactoryGirl.create(:request, user: user, trip: post.trip, accepted: false)
				headers['X-AUTH-TOKEN'] = user.authentication_token
				show_post(post)
			end

			it { expect(response.response_code).to eq(401) } 
		end
	end
end

def show_post(post)
	get api_v1_post_path(post), {}, headers
end

def update_post(post,params)
	put api_v1_post_path(post), params, headers
end

def create_post(trip, params)
	post api_v1_trip_posts_path(trip), params, headers
end

