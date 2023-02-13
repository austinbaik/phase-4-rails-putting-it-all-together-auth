class Recipe < ApplicationRecord
    belongs_to :user 

    validates :instructions, length: { minimum: 50 }
    validates :title, presence: true 


    #:title cannot be empty/falsy=
    #:instructions is at least 50 =

    
end
