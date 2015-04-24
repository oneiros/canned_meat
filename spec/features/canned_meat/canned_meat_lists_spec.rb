require 'rails_helper'

module CannedMeat
  RSpec.feature "Lists", type: :feature do

    describe "#index" do
      let!(:list1) { create(:canned_meat_list) }
      let!(:list2) { create(:canned_meat_list) }

      it "should display all lists" do
        visit "/canned_meat/lists"

        expect(page).to have_text(list1.name)
        expect(page).to have_text(list2.name)
      end
    end

    describe "#show" do
      let(:list) { create(:canned_meat_list) }

      it "should show the list" do
        visit "/canned_meat/lists/#{list.to_param}"

        expect(page).to have_text(list.name)
      end
    end

    describe "#new" do
      before(:example) { visit "/canned_meat/lists/new" }

      it "should display a form" do
        expect(page).to have_css('form')
      end

      it "should create a list when submitting valid values" do
        fill_in "Name", with: "Test List"

        expect{
          click_button "Create List"
        }.to change(CannedMeat::List, :count).by(1)
      end

      describe "when submitting invalid values" do
        it "should not create a list" do
          expect{
            click_button "Create List"
          }.to_not change(CannedMeat::List, :count)
        end

        it "should redisplay the form" do
          click_button "Create List"

          expect(page).to have_css('form')
        end
      end
    end

    describe "#edit" do
      let(:list) { create(:canned_meat_list) }

      before(:example) { visit "/canned_meat/lists/#{list.to_param}/edit" }

      it "should display a form" do
        expect(page).to have_css('form')
      end

      it "should save changes when submitting valid values" do
        fill_in "Name", with: "New List Name"
        click_button "Update List"

        expect(page).to have_text "New List Name"
      end

      it "should redisplay the form when submitting invalid values" do
        fill_in "Name", with: ""
        click_button "Update List"

        expect(page).to have_css('form')
      end
    end

    describe "#destroy" do
      let!(:list) { create(:canned_meat_list) }

      it "should destroy the list" do
        visit "/canned_meat/lists"
        expect{
          click_link I18n.t('canned_meat.views.defaults.buttons.destroy')
        }.to change(CannedMeat::List, :count).by(-1)
      end
    end
  end
end
