require "redcarpet"

module CannedMeat
  module Redcarpet
    class TextRenderer < ::Redcarpet::Render::Base
      include ActionView::Helpers::TextHelper

      def block_code(code)
        code.gsub(/^/, "    ")
      end

      def block_quote(quote)
        wrapped_quote = word_wrap(quote, line_width: 70)
        wrapped_quote.gsub(/^/, "| ")
      end

      def block_html(html)
        html
      end

      def footnotes(content)
        content
      end

      def footnote_def(note, number)
        wrapped_note = word_wrap(note, line_width: 68)
        lines = wrapped_note.lines
        lines.first.sub!(/^/, "[#{number}] ")
        lines[1..-1].each {|l| l.sub!(/^/, "    ") }
        lines.join
      end

      def header(text, level)
        character = case level
                    when 1
                      '='
                    when 2
                      '-'
                    else
                      '~'
                    end
        text << "\n#{character * text.size}\n"
        text
      end

      def hrule
        "#{'-' * 72}\n"
      end

      def list(content, type)
        @list_item_count = 0 if type == :ordered
        content
      end

      def list_item(text, type)
        prefix = case type
                 when :unordered
                   "* "
                 when :ordered
                   @list_item_count ||= 0
                   @list_item_count += 1
                   "#{sprintf('%2d', @list_item_count)}. "
                 end
        wrapped_text = word_wrap(text, line_width: 72 - prefix.size)
        lines = wrapped_text.lines
        lines.first.sub!(/^/, prefix)
        lines[1..-1].each {|l| l.sub!(/^/, ' ' * prefix.size) }
        "#{lines.join}\n"
      end

      def paragraph(text)
        word_wrap(text, line_width: 72)
      end

      def table(header, body)
        "#{header}\n#{body}"
      end

      def table_row(content)
        content
      end

      def table_cell(content, alignment)
        content
      end

      def autolink(link, type)
        link
      end

      def codespan(code)
        code
      end

      def double_emphasis(text)
        "**#{text}**"
      end

      def emphasis(text)
        "*#{text}*"
      end

      def image(link, title, alt_text)
        link
      end

      def linebreak
        "\n"
      end

      def link(link, title, content)
        "#{content} [#{link}]"
      end

      def raw_html(html)
        html
      end

      def triple_emphasis(text)
        "***#{text}***"
      end

      def strikethrough(text)
        "#{text.chars.join("\u0336")}\u0336"
      end

      def superscript(text)
        text
      end

      def underline(text)
        "_#{text}_"
      end

      def highlight(text)
        text
      end

      def quote(text)
        text
      end

      def footnote_ref(note, number)
        "#{note} [#{number}]"
      end
    end
  end
end
