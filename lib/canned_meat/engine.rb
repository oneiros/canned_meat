require "haml"

module CannedMeat
  class Engine < ::Rails::Engine
    isolate_namespace CannedMeat

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
