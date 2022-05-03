# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module CustomRegistrationForm
    # This is the engine that runs on the public interface of custom registration form.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::CustomRegistrationForm

      routes do
        # Add engine routes here
        # resources :custom_registration_form
        # root to: "custom_registration_form#index"
      end

      initializer "CustomRegistrationForm.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      initializer "CustomRegistrationForm.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::CustomRegistrationForm::Engine.root}/app/cells")
      end

      initializer "CustomRegistrationForm.signup_content_blocks" do
        Decidim.content_blocks.register(:signup_form, :gender) do |content_block|
          content_block.cell = "decidim/custom_registration_form/content_blocks/signup_form/gender"
          content_block.public_name_key = "decidim.custom_registration_form.content_blocks.signup_form.gender.name"
          content_block.settings_form_cell = "decidim/custom_registration_form/content_blocks/signup_form/gender_settings_form"

          content_block.settings do |settings|
            settings.attribute :gender, type: :integer
          end

          content_block.default!
        end
      end

      config.to_prepare do
        Decidim::Organization.include(Decidim::CustomRegistrationForm::OrganizationExtend)
        Decidim::RegistrationForm.include(Decidim::CustomRegistrationForm::RegistrationFormExtend)
        Decidim::CreateRegistration.include(Decidim::CustomRegistrationForm::CreateRegistrationExtend)
      end
    end
  end
end
