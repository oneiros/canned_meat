require "rails_helper"

module CannedMeat
  RSpec.describe "VariableReplacer" do

    describe "replace" do
      let(:replacer) { VariableReplacer.new(string) }

      context "without subscriber" do
        let(:string) { "Hello {{name}}, welcome to {{site}}" }

        it "does not change the string if it includes no variables" do
          replacer = VariableReplacer.new("test string")

          expect(replacer.replace(test: "replacement")).to eq "test string"
        end

        it "does not change the string if no value for the variable is given" do
          expect(replacer.replace(test: "replacment")).to eq string
        end

        it "replaces variables with given values" do
          result = replacer.replace(name: "John", site: "example.com")

          expect(result).to eq "Hello John, welcome to example.com"
        end

        it "ignores superfluous variables" do
          result = replacer.replace(name: "John", site: "example.com", test: "test")

          expect(result).to eq "Hello John, welcome to example.com"
        end
      end

      context "with subscriber" do
        let(:string) { "Hello {{subscriber_name}}, click here {{link}}" }
        let(:subscriber) { double(:subscriber, name: "John", id: 23) }

        it "should replace name variable with value from subscriber" do
          result = replacer.replace({}, subscriber: subscriber)

          expect(result).to eq "Hello John, click here {{link}}"
        end

        it "should be possible to combine static replacements and replacements from subscriber" do
          result = replacer.replace({link: "example.com"}, subscriber: subscriber)

          expect(result).to eq "Hello John, click here example.com"
        end
      end
    end
  end
end
