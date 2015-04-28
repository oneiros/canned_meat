module CannedMeat
  class Template < ActiveRecord::Base

    has_many :campaigns

    validates :name,
      presence: true

  end
end
