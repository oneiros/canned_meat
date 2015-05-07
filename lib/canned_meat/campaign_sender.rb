module CannedMeat
  class CampaignSender
    include Engine.routes.url_helpers

    def initialize(campaign)
      @campaign = campaign
      template_renderer = TemplateRenderer.new(
        campaign.template,
        campaign.body
      )
      @html_template = template_renderer.render_html
      @text_template = template_renderer.render_text
    end

    def send_to(subscription)
      replacer = VariableReplacer.new(
        variables_for_replacement(subscription),
        subscriber: subscription.subscriber
      )
      html = replacer.replace(@html_template)
      text = replacer.replace(@text_template)
      CampaignMailer.send_campaign(
        subscription.subscriber_email,
        @campaign.subject,
        html,
        text
      ).deliver_now
    end

    def send_to_all_subscribers!
      @campaign.list.subscriptions.subscribed.each do |subscription|
        send_to(subscription)
      end
      @campaign.update_attributes!(status: 'sent')
    end

    private

    def variables_for_replacement(subscription)
      {
        unsubscribe_url: unsubscribe_url(
          subscription.unsubscribe_token,
          ActionMailer::Base.default_url_options
        )
      }
    end

  end
end
