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
    end
  end
end
