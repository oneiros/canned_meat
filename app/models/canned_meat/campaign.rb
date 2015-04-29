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

    def draft?
      status == 'draft'
    end

    def send!
      raise "Campaign already sent" unless draft?
      SendCampaignJob.perform_later(self)
      update_attributes!(status: 'sending')
    end
  end
end
