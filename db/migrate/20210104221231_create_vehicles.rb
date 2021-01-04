class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :model_year
      t.string :make
      t.string :model
      t.integer :mileage
      t.integer :user_id
      t.timestamps
    end
  end
end
