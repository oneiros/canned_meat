module CannedMeat
  class Template < ActiveRecord::Base

    validates :name,
      presence: true

  end
end
