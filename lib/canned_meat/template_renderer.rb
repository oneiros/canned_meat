module CannedMeat
  class TemplateRenderer

    def initialize(template)
      @template = template
    end

    def render_html(content)
      VariableReplacer.new(@template.html)
        .replace content: content
    end

    def render_text(content)
      VariableReplacer.new(@template.text)
        .replace content: content
    end
  end
end
