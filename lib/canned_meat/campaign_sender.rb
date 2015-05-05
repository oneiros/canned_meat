module CannedMeat
  class CampaignSender

    def initialize(campaign)
      @campaign = campaign
      template_renderer = TemplateRenderer.new(
        campaign.template,
        campaign.body
      )
      @html_template = template_renderer.render_html
      @text_template = template_renderer.render_text
    end

    def send_to(subscriber)
      html = VariableReplacer.new(@html_template).replace(
        {},
        subscriber: subscriber
      )
      text = VariableReplacer.new(@text_template).replace(
        {},
        subscriber: subscriber
      )
      CampaignMailer.send_campaign(
        subscriber.send(CannedMeat.email_method),
        @campaign.subject,
        html,
        text
      ).deliver_now
    end

    def send_to_all_subscribers!
      @campaign.list.subscribers.each do |subscriber|
        send_to(subscriber)
      end
      @campaign.update_attributes!(status: 'sent')
    end
  end
end
