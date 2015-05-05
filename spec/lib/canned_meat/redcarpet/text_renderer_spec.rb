require "rails_helper"

module CannedMeat
  module Redcarpet
    RSpec.describe TextRenderer do

      shared_examples_for "returns input unchanged" do |method, postfix = nil|
        it "should return the input unchanged" do
          result = subject.send(method, "test")

          expect(result).to eq "test#{postfix}"
        end
      end

      describe "#block_code" do
        it "should indent the code with 4 spaces" do
          code = "def test\nend"
          result = subject.block_code(code)

          expect(result).to eq "    def test\n    end"
        end
      end

      describe "#block_quote" do

        it "should prefix each line with a pipe symbol" do
          quote = "test\nquote"
          result = subject.block_quote(quote)

          expect(result).to eq "| test\n| quote"
        end

        it "should wrap long lines" do
          quote = "I really should have googled for some profound quote of some important historical figure, but I am too lazy, sorry. -- Anonymous programmer"
          result = subject.block_quote(quote)

          expect(result).to eq "| I really should have googled for some profound quote of some important\n| historical figure, but I am too lazy, sorry. -- Anonymous programmer"
        end
      end

      describe "#block_html" do
        it_behaves_like "returns input unchanged", :block_html
      end

      describe "#footnotes" do
        it_behaves_like "returns input unchanged", :footnotes
      end

      describe "#footnote_def" do
        it "should prefix the text with  the number in square brackets" do
          result = subject.footnote_def("test", 2)

          expect(result).to eq "[2] test"
        end

        it "should wrap long lines" do
          result = subject.footnote_def(
            "This is a note contained in the footer. Actually, it is so long that one has to wonder if it should not have been placed in the main content.",
            4
          )

          expect(result).to eq "[4] This is a note contained in the footer. Actually, it is so long that\n    one has to wonder if it should not have been placed in the main\n    content."
        end
      end

      describe "#header" do
        shared_examples_for "underlines the heading" do |level, character|
          it "underlindes the heading with '#{character}' characters" do
            result = subject.header("this is a header", level)

            expect(result).to eq ("this is a header\n#{character * 16}\n")
          end
        end

        describe "level 1" do
          it_behaves_like "underlines the heading", 1, '='
        end

        describe "level 2" do
          it_behaves_like "underlines the heading", 2, '-'
        end

        (3..6).each do |level|
          describe "level #{level}" do
            it_behaves_like "underlines the heading", level, '~'
          end
        end
      end

      describe "#hrule" do
        it "outputs a 72 character wide line made of dashes" do
          expect(subject.hrule).to eq "#{'-' * 72}\n"
        end
      end

      describe "#list" do
        it "simply returns the list unchanged" do
          [:ordered, :unordered].each do |type|
            result = subject.list("test", type)

            expect(result).to eq "test"
          end
        end

        it "resets the list item counter" do
          subject.list_item("test", :ordered)
          subject.list("test", :ordered)
          item = subject.list_item("test", :ordered)

          expect(item).to match(/^ 1\./)
        end
      end

      describe "#list_item" do
        describe "unordered list" do
          it "prefixes each item with '*'" do
            result = subject.list_item("test", :unordered)

            expect(result).to eq "* test\n"
          end

          it "wraps long lines" do
            result = subject.list_item(
              "This is indeed a very long list item. But it has to be, otherwise there would be no point to this test.",
              :unordered
            )

            expect(result).to eq "* This is indeed a very long list item. But it has to be, otherwise\n  there would be no point to this test.\n"
          end
        end

        describe "ordered list" do
          it "prefixes every item with the proper number" do
            first_item = subject.list_item("test", :ordered)
            second_item = subject.list_item("test", :ordered)
            7.times { subject.list_item("test", :ordered) }
            tenth_item = subject.list_item("test", :ordered)

            expect(first_item).to eq " 1. test\n"
            expect(second_item).to eq " 2. test\n"
            expect(tenth_item).to eq "10. test\n"
          end
        end
      end

      describe "#paragraph" do
        it_behaves_like "returns input unchanged", :paragraph, "\n\n"

        it "wraps long lines" do
          result = subject.paragraph(
            "At first I thought not using lorem ipsum here would allow me to be a little more funny. Turns out I am not funny at all."
          )

          expect(result).to eq "At first I thought not using lorem ipsum here would allow me to be a\nlittle more funny. Turns out I am not funny at all.\n\n"
        end
      end

      describe "#table" do
        it "appends the body to the header" do
          result = subject.table("header", "body")

          expect(result).to eq "header\nbody"
        end
      end

      describe "#table_row" do
        it_behaves_like "returns input unchanged", :table_row
      end

      describe "#table_cell" do
        it "returns the input unchanged, ignoring the alignment" do
          [:left, :right, :center].each do |alignment|
            result = subject.table_cell("test", alignment)

            expect(result).to eq "test"
          end
        end
      end

      describe "#autolink" do
        it "returns the link ignoring the type" do
          result = subject.autolink("test", :foo)

          expect(result).to eq "test"
        end
      end

      describe "#codespan" do
        it_behaves_like "returns input unchanged", :codespan
      end

      describe "#double_emphasis" do
        it "wraps the text with two asterisks" do
          result = subject.double_emphasis("test")

          expect(result).to eq "**test**"
        end
      end

      describe "#emphasis" do
        it "wraps the text with asterisks" do
          result = subject.emphasis("test")

          expect(result).to eq "*test*"
        end
      end

      describe "#image" do
        it "returns link in parentheses" do
          result = subject.image("link", "title", "alt_text")

          expect(result).to eq "link"
        end
      end

      describe "#linebreak" do
        it "returns a newline" do
          expect(subject.linebreak).to eq "\n"
        end
      end

      describe "#link" do
        it "returns the content followed by the link in square brackets" do
          result = subject.link("link", "title", "content")

          expect(result).to eq "content [link]"
        end
      end

      describe "#raw_html" do
        it_behaves_like "returns input unchanged", :raw_html
      end

      describe "#triple_emphasis" do
        it "wraps the text with three asterisks" do
          result = subject.triple_emphasis("test")

          expect(result).to eq "***test***"
        end
      end

      describe "#strikethrough" do
        it "uses unicode combining characters to achieve strikethrough effect" do
          result = subject.strikethrough("test")

          expect(result).to eq "t\u0336e\u0336s\u0336t\u0336"
        end
      end

      describe "#superscript" do
        it_behaves_like "returns input unchanged", :superscript
      end

      describe "#underline" do
        it "wraps the text in underscores" do
          result = subject.underline("test")

          expect(result).to eq "_test_"
        end
      end

      describe "#highlight" do
        it_behaves_like "returns input unchanged", :highlight
      end

      describe "#quote" do
        it_behaves_like "returns input unchanged", :quote
      end

      describe "#footnote_ref" do
        it "should append the number in square brackets" do
          result = subject.footnote_ref("test", 23)

          expect(result).to eq "test [23]"
        end
      end
    end
  end
end
