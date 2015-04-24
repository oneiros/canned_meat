RSpec.shared_examples_for "authenticated controller" do |method, action, args|

  after(:example) { CannedMeat.configure_defaults! }

  describe "no authentication block given" do

    it "should be successful" do
      CannedMeat.authenticator = nil
      send(method, *[action, args])

      expect(response).to be_success
    end
  end

  describe "authentication block returns true" do

    it "should be successful" do
      CannedMeat.authenticator = proc { true }
      send(method, *[action, args])

      expect(response).to be_success
    end
  end

  describe "authentication block returns false" do

    it "should deny access" do
      CannedMeat.authenticator = proc { false }
      send(method, *[action, args])

      expect(response).to have_http_status(403)
    end
  end
end
