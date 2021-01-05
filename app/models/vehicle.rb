class Vehicle < ActiveRecord::Base
   belongs_to :user
   has_many :entries

   def slug
      (self.model_year + self.make + self.model).parameterize
   end
end
