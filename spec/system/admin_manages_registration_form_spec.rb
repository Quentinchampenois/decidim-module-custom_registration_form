# frozen_string_literal: true

require "spec_helper"

describe "Admin manages registration form", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  describe "index" do
    before do
      visit decidim_admin_custom_registration_form.root_path
    end

    it "displays main content block" do
      expect(page).to have_content("Customize the registration form")
    end

    it "allow user to activate custom field" do
      within "#custom_registration_form" do
        expect(page).to have_content("Custom registration form enabled")
      end
      expect(page).to have_content("Save")
    end
  end
end
