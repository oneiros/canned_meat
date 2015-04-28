class CreateCannedMeatCampaigns < ActiveRecord::Migration
  def change
    create_table :canned_meat_campaigns do |t|
      t.string :name, index: {unique: true}
      t.references :list, index: true, foreign_key: true
      t.references :template, index: true, foreign_key: true
      t.string :status, null: false, default: 'draft'
      t.string :subject, null: false
      t.text :body

      t.timestamps null: false
    end
  end
end
