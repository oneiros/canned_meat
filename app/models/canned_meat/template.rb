module CannedMeat
  class Template < ActiveRecord::Base

    has_many :campaigns

    validates :name,
      presence: true

    validates :html,
      format: {
        with: /{{content}}/
      }

    validates :text,
      format: {
        with: /{{content}}/
      }

  end
end
