class User < ApplicationRecord
    has_secure_password
    has_many :recipes 
    validates :username, presence: true 
    validates_uniqueness_of :username, :case_sensitive => true

end

