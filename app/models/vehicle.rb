class Vehicle < ActiveRecord::Base
   belongs_to :user
   has_many :entries

   def slug
      (self.model_year.to_s.parameterize + "-" + self.make.parameterize + "-" + self.model.parameterize)
   end

   def self.find_by_slug(slug)
      slug.gsub
   end
end
