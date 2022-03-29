# frozen_string_literal: true

class AddCustomRegistrationFormEnabledToDecidimOrganization < ActiveRecord::Migration[6.0]
  def up
    add_column :decidim_organizations, :custom_registration_form_enabled, :boolean, default: false
  end

  def down
    remove_column :decidim_organizations, :custom_registration_form_enabled, :boolean, default: false
  end
end
