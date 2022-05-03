# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module CreateRegistrationExtend
      extend ActiveSupport::Concern

      included do
        def create_user
          @user = User.create!(
            email: form.email,
            name: form.name,
            nickname: form.nickname,
            password: form.password,
            password_confirmation: form.password_confirmation,
            organization: form.current_organization,
            tos_agreement: form.tos_agreement,
            newsletter_notifications_at: form.newsletter_at,
            email_on_notification: true,
            accepted_tos_version: form.current_organization.tos_version,
            locale: form.current_locale,
            extended_data: build_extra_data
          )
        end

        def custom_registration_fields
          Decidim::ContentBlock.published.for_scope(:signup_form, organization: form.current_organization).map(&:manifest_name)
        end

        def build_extra_data
          extended_data = { "custom_registration_form" => {} }

          custom_registration_fields.each do |manifest_name|
            extended_data["custom_registration_form"][manifest_name] = form.attributes[manifest_name.to_sym]
          end

          extended_data
        end
      end
    end
  end
end
