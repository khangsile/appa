object @review
attributes :id, :content, :rating
node(:user) { |r| r.request.user.full_name }
