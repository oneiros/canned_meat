module CannedMeat
  class List < ActiveRecord::Base

    has_many :campaigns
    has_many :subscriptions
    has_many :subscribers,
      -> { where(canned_meat_subscriptions: {unsubscribed_at: nil}) },
      {through: :subscriptions, source_type: CannedMeat.subscriber_model}

    validates :name,
      presence: true,
      uniqueness: true

    def subscribe!(subscriber)
      subscriptions.create!(subscriber: subscriber)
    end

    def unsubscribe!(subscriber)
      subscription = subscriptions.where(subscriber: subscriber, list: self).last
      raise ArgumentError.new("Given subscriber is not subscribed to this list") if subscription.nil?
      subscription.unsubscribe!
    end
  end
end
