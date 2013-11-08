object @review
attributes :id, :content, :rating
node(:user) { |r| r.user.full_name }
