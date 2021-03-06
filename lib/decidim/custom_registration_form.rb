# frozen_string_literal: true

require "decidim/custom_registration_form/admin"
require "decidim/custom_registration_form/engine"
require "decidim/custom_registration_form/admin_engine"
require "decidim/custom_registration_form/extends/organization_extend"
require "decidim/custom_registration_form/extends/registration_form_extend"
require "decidim/custom_registration_form/extends/create_registration_extend"

module Decidim
  # This namespace holds the logic of the `CustomRegistrationForm` component. This component
  # allows users to create customize the registration form
  module CustomRegistrationForm
  end
end
