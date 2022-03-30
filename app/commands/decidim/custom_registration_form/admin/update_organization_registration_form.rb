# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module Admin
      class UpdateOrganizationRegistrationForm < Rectify::Command
        # Public: Initializes the command.
        #
        # form - BlockUserForm
        def initialize(form)
          @form = form
        end

        # Executes the command. Broadcasts these events:
        #
        # - :ok when everything is valid, together with the resource.
        # - :invalid if the resource is not reported
        #
        # Returns nothing.
        def call
          return broadcast(:invalid) unless form.valid?

          transaction do
            update_organization!
          end

          broadcast(:ok)
        end

        private

        attr_reader :form

        def update_organization!
          Decidim.traceability.perform_action!(
            "enable_custom_registration_form",
            current_organization,
            form.current_user,
            extra: {},
            resource: {}
          ) do
            current_organization.custom_registration_form_enabled = form.custom_registration_form_enabled
            current_organization.save!
          end
        end
      end
    end
  end
end
