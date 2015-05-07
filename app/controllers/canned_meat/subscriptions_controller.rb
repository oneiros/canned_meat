require_dependency "canned_meat/application_controller"

module CannedMeat
  class SubscriptionsController < ApplicationController

    skip_before_action :authenticate_user!

    def unsubscribe
      @subscription = Subscription.find_by_unsubscribe_token(
        params[:unsubscribe_token]
      )
      @subscription.unsubscribe!
    end
  end
end
