require "rails_helper"

module CannedMeat
  RSpec.describe TemplateRenderer do
    let(:html) { "<html>{{content}} {{other_var}}</html>" }
    let(:text) { "{{content}}\n--\n sig" }
    let(:template) do
      create(:canned_meat_template, html: html, text: text)
    end
    let(:renderer) do
      TemplateRenderer.new(template)
    end

    describe "#render_html" do

      it "places content in the html template" do
        result = renderer.render_html "<h1>Hi</h1>"
        expect(result).to eq "<html><h1>Hi</h1> {{other_var}}</html>"
      end
    end

    describe "#render_text" do

      it "places content in the text template" do
        result = renderer.render_text "Hi"
        expect(result).to eq "Hi\n--\n sig"
      end
    end
  end
end
