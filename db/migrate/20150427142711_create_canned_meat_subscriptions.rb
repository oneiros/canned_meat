class CreateCannedMeatSubscriptions < ActiveRecord::Migration
  def change
    create_table :canned_meat_subscriptions do |t|
      t.references :subscriber, polymorphic: true, index: {name: "index_canned_meat_subscriptions_on_subscriber_type_and_id"}
      t.references :list, index: true
      t.datetime :unsubscribed_at

      t.timestamps null: false
    end
  end
end
