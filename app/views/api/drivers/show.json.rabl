object @user
attributes :id, :first_name, :last_name, :email
child :driver do
	attributes :balance
end
