# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module Admin
      class CustomRegistrationFormController < CustomRegistrationForm::Admin::ApplicationController
        before_action :authorized?

        def edit
          enforce_permission_to :read, :custom_registration_form

          @registration_form = form(RegistrationForm).from_model(current_organization)
        end

        def update
          enforce_permission_to :read, :custom_registration_form

          @registration_form = form(RegistrationForm).from_params(params)
          UpdateOrganizationRegistrationForm.call(@registration_form) do
            on(:ok) do
              redirect_to decidim_admin_custom_registration_form.root_path
            end
            on(:invalid) do
              edit # Sets the model to the view so that it can render the form
              render :edit
            end
          end
        end

        private

        def authorized?
          enforce_permission_to :read, :custom_registration_form
        end
      end
    end
  end
end
