require "canned_meat/engine"
require "canned_meat/version"

module CannedMeat
  mattr_accessor :authenticator, :subscriber_model, :email_method, :label_method, :return_path

  def self.configure(&block)
    configure_defaults!
    yield self
  end

  def self.configure_defaults!
    self.authenticator = nil
    self.subscriber_model = "User"
    self.email_method = :email
    self.label_method = :name
    self.return_path = :root_path
  end
end
