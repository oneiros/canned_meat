module CannedMeat
  class TemplateRenderer

    def initialize(template, markdown)
      @template = template
      @markdown = markdown
    end

    def render_html
      html = render_markdown(::Redcarpet::Render::HTML)
      VariableReplacer.new(content: html)
        .replace @template.html
    end

    def render_text
      text = render_markdown(Redcarpet::TextRenderer)
      VariableReplacer.new(content: text)
        .replace @template.text
    end

    private

    def render_markdown(renderer_class)
      ::Redcarpet::Markdown.new(
        renderer_class
      ).render(@markdown)
    end
  end
end
