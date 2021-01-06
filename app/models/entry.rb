class Entry < ActiveRecord::Base
   belongs_to :vehicle

   def date_of_creation
      date_str = self.created_at.to_s
      date_array = date_str.split(" ")
      isolated_array = date_array[0].split("-")
      "Created #{isolated_array[1]}/#{isolated_array[2]}/#{isolated_array[0]}"
   end
end
