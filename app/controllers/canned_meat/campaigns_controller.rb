require_dependency "canned_meat/application_controller"

module CannedMeat
  class CampaignsController < ApplicationController

    def index
      @campaigns = Campaign.order(name: :asc)
    end

    def show
      @campaign = Campaign.find(params[:id])
    end

    def new
      @campaign = Campaign.new
    end

    def create
      @campaign = Campaign.new(campaign_params)

      if @campaign.save
        redirect_to @campaign, notice: t('canned_meat.controllers.campaigns.created')
      else
        render action: 'new'
      end
    end

    def edit
      @campaign = Campaign.find(params[:id])
    end

    def update
      @campaign = Campaign.find(params[:id])

      if @campaign.update_attributes(campaign_params)
        redirect_to @campaign, notice: t('canned_meat.controllers.campaigns.updated')
      else
        render action: 'edit'
      end
    end

    def destroy
      @campaign = Campaign.find(params[:id])
      @campaign.destroy

      redirect_to canned_meat.campaigns_path, notice: t('canned_meat.controllers.campaigns.destroyed')
    end

    def send_campaign
      @campaign = Campaign.find(params[:id])
      @campaign.send!

      redirect_to @campaign, notice: t('canned_meat.controllers.campaigns.sending')
    end

    def send_test_mail
      campaign = Campaign.find(params[:id])
      subscription = campaign.list.subscriptions.subscribed.find(params[:subscription_id])
      CampaignSender.new(campaign).send_to subscription

      redirect_to campaign,
        notice: t('canned_meat.controllers.campaigns.sent_test_mail', email: subscription.subscriber_email)
    end

    private

    def campaign_params
      params.require(:campaign).permit(:name, :subject, :body, :list_id, :template_id)
    end
  end
end
