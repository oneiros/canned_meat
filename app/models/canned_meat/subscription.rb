module CannedMeat
  class Subscription < ActiveRecord::Base
    belongs_to :subscriber, polymorphic: true
    belongs_to :list

    def unsubscribe!
      update_attributes!(unsubscribed_at: Time.now)
    end
  end
end
