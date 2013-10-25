require 'spec_helper'

describe "UsersController" do

	let(:user) { FactoryGirl.create :user }
	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }

	subject { response }

	describe "#create" do
		let(:params) do
			{ email: "nubtub@gmail.com", first_name: "nub",
				last_name: "tub", password: "nubster1",
				password_confirmation: "nubster1"
			}
		end

		context "when info is valid" do
			it "creates user" do
				# create_user(params)
				expect{create_user(params)}.to change(User, :count).by(1)
				expect(response).to be_success
				expect(response.body).to include params[:email]
				expect(response.body).to include params[:first_name]
				expect(response.body).to include 'auth_token'
			end
		end

		context "when info is invalid" do
			it "does not have matching password/confirmation" do
				params[:password_confirmation] = 'nubster2'
				expect{create_user(params)}.to_not change(User, :count)
				expect(response).to_not be_success
			end

			it "does not have unique email" do
				params[:email] = user.email
				expect{create_user(params)}.to_not change(User, :count)
				expect(response).to_not be_success
			end
		end

	end

	describe "#show" do

		context "when user exists" do
			before { get_user(user) }

			it "gets user" do
				expect(response).to be_success
				expect(response.body).to include user.first_name
			end
		end

		context "when user does not exist" do
			before { get_user(10) }

			it "does not get user" do
				expect(response.response_code).to eq(404)
			end
		end
	end

	describe "#update" do
		let(:params) { { email: 'nutty@nut.com', } }

		context "when user owns profile" do
			before do
				headers['X-AUTH-TOKEN'] = user.authentication_token
				edit_user(user, params)
			end

			it "edits the email" do
				user.reload
				expect(response).to be_success
				expect(response.body).to include params[:email]
				expect(user.email).to eq(params[:email])

			end
		end

		context "when user does not own profile" do
			before do
				bad_user = FactoryGirl.create :user
				headers['X-AUTH-TOKEN'] = bad_user.authentication_token
				edit_user(user, params)
			end

			it "does not edit email" do
				user.reload
				expect(response.response_code).to eq(401)
				expect(user.email).to_not eq(params[:email])
			end
		end
	end

	def get_user(user)
		get api_v1_user_path(user), {}, headers
	end

	def edit_user(user, params)
		put api_v1_user_path(user), params, headers
	end

	def create_user(params)
		post api_v1_users_path, params, headers
	end
end
