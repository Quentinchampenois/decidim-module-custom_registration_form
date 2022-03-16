# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module Admin
      class RegistrationForm < Form
        attribute :custom_registration_form_enabled, Boolean

        validates :custom_registration_form_enabled, presence: true, inclusion: { in: [true, false] }
      end
    end
  end
end
