# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module Admin
      class Permissions < Decidim::DefaultPermissions
        def permissions
          return permission_action if permission_action.scope != :admin
          return permission_action unless user&.admin?

          allow! if access_custom_registration_form?

          permission_action
        end

        def access_custom_registration_form?
          permission_action.subject == :custom_registration_form &&
            permission_action.action == :read
        end
      end
    end
  end
end
