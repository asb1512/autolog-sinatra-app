class Vehicle < ActiveRecord::Base
   belongs_to :user
   has_many :entries

   def slug
      self.name.parameterize
   end
end
