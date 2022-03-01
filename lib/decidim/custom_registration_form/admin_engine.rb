# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    # This is the engine that runs on the public interface of `CustomRegistrationForm`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::CustomRegistrationForm::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        root to: "custom_registration_form#index"
      end

      def load_seed
        nil
      end

      initializer "decidim_custom_registration_form.admin_mount_routes" do
        Decidim::Core::Engine.routes do
          # TODO: Ensure route naming is correct
          mount Decidim::CustomRegistrationForm::AdminEngine, at: "/admin/custom_registration_form", as: "decidim_admin_custom_registration_form"
        end
      end

      initializer "decidim_custom_registration_form.admin_settings_menu" do
        Decidim.menu :admin_settings_menu do |menu|
          menu.add_item :custom_registration_form,
                        I18n.t("menu.custom_registration_form", scope: "decidim.admin"),
                        decidim_admin_custom_registration_form.root_path,
                        position: 10.0,
                        active: is_active_link?(decidim_admin_custom_registration_form.root_path)
        end
      end
    end
  end
end
