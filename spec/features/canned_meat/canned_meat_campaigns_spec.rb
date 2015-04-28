require 'rails_helper'

module CannedMeat
  RSpec.feature "Campaigns", type: :feature do

    describe "#index" do
      let!(:campaign1) { create(:canned_meat_campaign) }
      let!(:campaign2) { create(:canned_meat_campaign) }

      it "should display all campaigns" do
        visit "/canned_meat/campaigns"

        expect(page).to have_text(campaign1.name)
        expect(page).to have_text(campaign2.name)
      end
    end

    describe "#show" do
      let(:campaign) { create(:canned_meat_campaign) }

      it "should show the campaign" do
        visit "/canned_meat/campaigns/#{campaign.to_param}"

        expect(page).to have_text(campaign.name)
      end
    end

    describe "#new" do
      let!(:list) { create(:canned_meat_list) }
      let!(:template) { create(:canned_meat_template) }

      before(:example) { visit "/canned_meat/campaigns/new" }

      it "should display a form" do
        expect(page).to have_css('form')
      end

      it "should create a campaign when submitting valid values" do
        fill_in "Name", with: "Test Campaign"
        select template.name, from: "Template"
        select list.name, from: "List"
        fill_in "Subject", with: "Test Subject"
        fill_in "Body", with: "Test"

        expect{
          click_button "Create Campaign"
        }.to change(CannedMeat::Campaign, :count).by(1)
      end

      describe "when submitting invalid values" do
        it "should not create a campaign" do
          expect{
            click_button "Create Campaign"
          }.to_not change(CannedMeat::Campaign, :count)
        end

        it "should redisplay the form" do
          click_button "Create Campaign"

          expect(page).to have_css('form')
        end
      end
    end

    describe "#edit" do
      let(:campaign) { create(:canned_meat_campaign) }

      before(:example) { visit "/canned_meat/campaigns/#{campaign.to_param}/edit" }

      it "should display a form" do
        expect(page).to have_css('form')
      end

      it "should save changes when submitting valid values" do
        fill_in "Name", with: "New Campaign Name"
        click_button "Update Campaign"

        expect(page).to have_text "New Campaign Name"
      end

      it "should redisplay the form when submitting invalid values" do
        fill_in "Name", with: ""
        click_button "Update Campaign"

        expect(page).to have_css('form')
      end
    end

    describe "#destroy" do
      let!(:campaign) { create(:canned_meat_campaign) }

      it "should destroy the campaign" do
        visit "/canned_meat/campaigns"
        expect{
          click_link I18n.t('canned_meat.views.defaults.buttons.destroy')
        }.to change(CannedMeat::Campaign, :count).by(-1)
      end
    end
  end
end
