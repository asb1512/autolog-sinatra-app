class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :entry_type
      t.string :entry_content
      t.date :due_date
      t.integer :vehicle_id
      t.timestamps
    end
  end
end
