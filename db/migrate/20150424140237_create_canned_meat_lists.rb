class CreateCannedMeatLists < ActiveRecord::Migration
  def change
    create_table :canned_meat_lists do |t|
      t.string :name, null: false, index: {unique: true}

      t.timestamps null: false
    end
  end
end
