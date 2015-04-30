module CannedMeat
  class SendCampaignJob < ActiveJob::Base
    queue_as :default

    def perform(campaign)
      template_renderer = TemplateRenderer.new(campaign.template)
      html_template = template_renderer.render_html(campaign.body)
      text_template = template_renderer.render_text(campaign.body)

      campaign.list.subscribers.each do |subscriber|
        html = VariableReplacer.new(html_template).replace(
          {},
          subscriber: subscriber
        )
        text = VariableReplacer.new(text_template).replace(
          {},
          subscriber: subscriber
        )
        CampaignMailer.send_campaign(
          subscriber.send(CannedMeat.email_method),
          campaign.subject,
          html,
          text
        ).deliver_now
      end

      campaign.update_attributes!(status: 'sent')
    end
  end
end
