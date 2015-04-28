class CreateCannedMeatTemplates < ActiveRecord::Migration
  def change
    create_table :canned_meat_templates do |t|
      t.string :name, index: {unique: true}
      t.text :html
      t.text :text

      t.timestamps null: false
    end
  end
end
