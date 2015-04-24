require 'rails_helper'

module CannedMeat
  RSpec.describe DashboardController, type: :controller do
    routes { CannedMeat::Engine.routes }

    describe "#index" do

      it "raises no errors" do
        expect{
          get :index
        }.to_not raise_error
      end
    end
  end
end
