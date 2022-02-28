# frozen_string_literal: true

base_path = File.expand_path("..", __dir__)

Decidim::Webpacker.register_path("#{base_path}/app/packs")
Decidim::Webpacker.register_entrypoints(
  decidim_custom_registration_form: "#{base_path}/app/packs/entrypoints/decidim_custom_registration_form.js"
)
Decidim::Webpacker.register_stylesheet_import("stylesheets/decidim/custom_registration_form/custom_registration_form")
