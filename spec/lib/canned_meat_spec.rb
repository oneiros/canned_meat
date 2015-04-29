require "rails_helper"

RSpec.describe CannedMeat do

  describe "#configure" do

    describe "setting values" do
      after(:context) do
        CannedMeat.configure_defaults!
      end

      [:authenticator, :subscriber_model, :email_method, :label_method, :return_path, :email_from].each do |attribute|
        it "should be possible to set #{attribute}" do
          CannedMeat.configure do |config|
            config.send(:"#{attribute}=", "test value")
          end

          expect(CannedMeat.send(attribute)).to eq "test value"
        end
      end
    end
  end
end
