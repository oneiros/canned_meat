module CannedMeat
  class Subscription < ActiveRecord::Base

    belongs_to :subscriber, polymorphic: true
    belongs_to :list

    scope :subscribed, -> { where(unsubscribed_at: nil) }

    def self.message_verifier
      @verifier ||= ActiveSupport::MessageVerifier.new(
        Rails.application.secrets.secret_key_base
      )
    end

    def self.find_by_unsubscribe_token(token)
      find(message_verifier.verify(token))
    end

    def subscriber_name
      subscriber.send(CannedMeat.label_method)
    end

    def subscriber_email
      subscriber.send(CannedMeat.email_method)
    end

    def unsubscribe!
      update_attributes!(unsubscribed_at: Time.now)
    end

    def unsubscribe_token
      self.class.message_verifier.generate id
    end
  end
end
