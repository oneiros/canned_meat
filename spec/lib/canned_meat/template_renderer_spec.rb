require "rails_helper"

module CannedMeat
  RSpec.describe TemplateRenderer do
    let(:html) { "<html>{{content}} {{other_var}}</html>" }
    let(:text) { "{{content}}\n--\n sig" }
    let(:template) do
      create(:canned_meat_template, html: html, text: text)
    end
    let(:renderer_with_plain_text) do
      TemplateRenderer.new(template, "test")
    end
    let(:renderer_with_markdown) do
      TemplateRenderer.new(template, "# Heading\nparagraph")
    end

    describe "#render_html" do

      it "places content in the html template" do
        result = renderer_with_plain_text.render_html

        expect(result).to eq "<html><p>test</p>\n {{other_var}}</html>"
      end

      it "renders markdown to html" do
        html = renderer_with_markdown.render_html

        expect(html).to eq "<html><h1>Heading</h1>\n\n<p>paragraph</p>\n {{other_var}}</html>"
      end
    end

    describe "#render_text" do

      it "places content in the text template" do
        result = renderer_with_plain_text.render_text

        expect(result).to eq "test\n\n\n--\n sig"
      end

      it "renders markdown to text" do
        text = renderer_with_markdown.render_text

        expect(text).to eq "Heading\n=======\nparagraph\n\n\n--\n sig"
      end
    end
  end
end
