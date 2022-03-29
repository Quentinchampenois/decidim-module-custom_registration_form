# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  # Add engine factories here
end

FactoryBot.modify do
  factory :organization do
    custom_registration_form_enabled { false }

    trait :custom_registration_form_enabled do
      custom_registration_form_enabled { true }
    end

    trait :custom_registration_form_disabled do
      custom_registration_form_enabled { false }
    end
  end
end
