class Vehicle < ActiveRecord::Base
   belongs_to :user
   has_many :entries

   def slug
      (self.model_year.to_s.parameterize + "-" + self.make.parameterize + "-" + self.model.parameterize)
   end

   def self.find_by_slug(slug)
      split_slug = slug.split("-")
         model_year = split_slug[0].to_i
         make = split_slug[1]
         model = split_slug[2]
      Vehicle.find_by(model_year: model_year, make: make, model: model)
   end
end
