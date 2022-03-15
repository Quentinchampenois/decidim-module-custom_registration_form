# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module Admin
      class CustomRegistrationFormController < CustomRegistrationForm::Admin::ApplicationController
        before_action :authorized?

        def index
          @form = Decidim::CustomRegistrationForm::Admin::RegistrationForm.new
        end

        private

        def authorized?
          enforce_permission_to :read, :custom_registration_form
        end
      end
    end
  end
end
