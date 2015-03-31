ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
class Item < ActiveRecord::Base
  belongs_to :category
end

class Category < ActiveRecord::Base
 has_many :items
end

class User < ActiveRecord::Base
	has_secure_password
end
