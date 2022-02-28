# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :custom_registration_form_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :custom_registration_form).i18n_name }
    manifest_name :custom_registration_form
    participatory_space { create(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
