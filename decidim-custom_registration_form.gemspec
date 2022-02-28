# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/custom_registration_form/version"

Gem::Specification.new do |s|
  s.version = Decidim::CustomRegistrationForm.version
  s.authors = ["quentinchampenois"]
  s.email = ["26109239+Quentinchampenois@users.noreply.github.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/opensourcepolitics/decidim-module-custom_registration_form"
  s.required_ruby_version = ">= 2.7"

  s.name = "decidim-custom_registration_form"
  s.summary = "A Decidim module to customize the registration form"
  s.description = "Customize the user registration form of your Decidim platform directly from the backoffice."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::CustomRegistrationForm.decidim_compatibility_version
  s.add_dependency "decidim-admin", Decidim::CustomRegistrationForm.decidim_compatibility_version
end
