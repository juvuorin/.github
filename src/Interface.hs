-- src/MyBlog/Interface.hs
module Interface where
 
data User = User {name :: String} 
type UserId = Int
class Database m where
--    newUser :: NewUserFormData -> m UserId
    getUser :: UserId -> m (Maybe User)
--    getUsers :: m [User]
--    newBlogPost :: User -> NewBlogPostFormData -> m BlogPostId
--    searchPosts :: Text -> m [(User, Post)]

 