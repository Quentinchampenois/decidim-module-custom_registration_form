# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module Admin
      class RegistrationForm < Form
        attribute :custom_registration_form_enabled, Boolean
      end
    end
  end
end
