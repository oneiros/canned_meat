require 'rails_helper'

module CannedMeat
  RSpec.feature "Templates", type: :feature do

    describe "#index" do
      let!(:template1) { create(:canned_meat_template) }
      let!(:template2) { create(:canned_meat_template) }

      it "should display all templates" do
        visit "/canned_meat/templates"

        expect(page).to have_text(template1.name)
        expect(page).to have_text(template2.name)
      end
    end

    describe "#show" do
      let(:template) { create(:canned_meat_template) }

      it "should show the template" do
        visit "/canned_meat/templates/#{template.to_param}"

        expect(page).to have_text(template.name)
      end
    end

    describe "#new" do
      before(:example) { visit "/canned_meat/templates/new" }

      it "should display a form" do
        expect(page).to have_css('form')
      end

      it "should create a template when submitting valid values" do
        fill_in "Name", with: "Test Template"

        expect{
          click_button "Create Template"
        }.to change(CannedMeat::Template, :count).by(1)
      end

      describe "when submitting invalid values" do
        it "should not create a template" do
          expect{
            click_button "Create Template"
          }.to_not change(CannedMeat::Template, :count)
        end

        it "should redisplay the form" do
          click_button "Create Template"

          expect(page).to have_css('form')
        end
      end
    end

    describe "#edit" do
      let(:template) { create(:canned_meat_template) }

      before(:example) { visit "/canned_meat/templates/#{template.to_param}/edit" }

      it "should display a form" do
        expect(page).to have_css('form')
      end

      it "should save changes when submitting valid values" do
        fill_in "Name", with: "New Template Name"
        click_button "Update Template"

        expect(page).to have_text "New Template Name"
      end

      it "should redisplay the form when submitting invalid values" do
        fill_in "Name", with: ""
        click_button "Update Template"

        expect(page).to have_css('form')
      end
    end

    describe "#destroy" do
      let!(:template) { create(:canned_meat_template) }

      it "should destroy the template" do
        visit "/canned_meat/templates"
        expect{
          click_link I18n.t('canned_meat.views.defaults.buttons.destroy')
        }.to change(CannedMeat::Template, :count).by(-1)
      end
    end
  end
end
