# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module CustomRegistrationForm
    module OrganizationExtend
      extend ActiveSupport::Concern

      included do
        def registration_form_enabled?
          custom_registration_form_enabled.present?
        end
      end
    end
  end
end
