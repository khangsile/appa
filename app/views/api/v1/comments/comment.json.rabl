object @comment
attributes :content, :post_id
child(:user) { attributes :first_name, :last_name, :id }