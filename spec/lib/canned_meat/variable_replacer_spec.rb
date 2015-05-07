require "rails_helper"

module CannedMeat
  RSpec.describe "VariableReplacer" do

    describe "replace" do
      let(:replacer) { VariableReplacer.new(variables, subscriber: subscriber) }

      context "without subscriber" do
        let(:variables) { {name: "John", site: "example.com"} }
        let(:string) { "Hello {{name}}, welcome to {{site}}" }
        let(:subscriber) { nil }

        it "does not change the string if it includes no variables" do
          expect(replacer.replace("test string")).to eq "test string"
        end

        it "does not change the string if no value for the variable is given" do
          replacer = VariableReplacer.new({})

          expect(replacer.replace(string)).to eq string
        end

        it "replaces variables with given values" do
          result = replacer.replace(string)

          expect(result).to eq "Hello John, welcome to example.com"
        end

        it "ignores superfluous variables" do
          replacer = VariableReplacer.new(name: "John", site: "example.com", test: "test")
          result = replacer.replace(string)

          expect(result).to eq "Hello John, welcome to example.com"
        end
      end

      context "with subscriber" do
        let(:variables) { {link: "example.com"} }
        let(:string) { "Hello {{subscriber_name}}, click here {{link}}" }
        let(:subscriber) { double(:subscriber, name: "John", id: 23) }

        it "should replace name variable with value from subscriber" do
          replacer = VariableReplacer.new({}, subscriber: subscriber)
          result = replacer.replace(string)

          expect(result).to eq "Hello John, click here {{link}}"
        end

        it "should be possible to combine static replacements and replacements from subscriber" do
          result = replacer.replace(string)

          expect(result).to eq "Hello John, click here example.com"
        end
      end
    end
  end
end
