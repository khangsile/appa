# remember to add "devise :token_authenticatable" to user.rb
# and uncomment "config.token_authentication_key = :auth_token" from devise.rb
class AddDeviseColumnsToUsers < ActiveRecord::Migration
	def change
		add_column :users, :authentication_token, :string
		add_index :users, :authentication_token, unique: true
	end
end