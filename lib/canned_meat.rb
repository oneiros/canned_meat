require "canned_meat/engine"
require "canned_meat/version"

module CannedMeat
  mattr_accessor :authenticator, :subscriber_model, :email_method, :label_method, :return_path

  def self.configure(&block)
    yield self
  end
end
