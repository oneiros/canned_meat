module CannedMeat
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    private

    def authenticate_user!
      if CannedMeat.authenticator and !instance_exec(nil, &CannedMeat.authenticator)
        render text: "access denied", status: 403
      end
    end
  end
end
