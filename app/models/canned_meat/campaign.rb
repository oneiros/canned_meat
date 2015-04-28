module CannedMeat
  class Campaign < ActiveRecord::Base

    STATUS = %w(draft sending sent).freeze

    belongs_to :list
    belongs_to :template

    validates :name,
      presence: true,
      uniqueness: true

    validates :status,
      inclusion: STATUS

    validates :subject,
      presence: true

    validates :body,
      presence: true
  end
end
