# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module RegistrationFormExtend
      extend ActiveSupport::Concern
      included do
        # Gender field
        GENDERS = %w(male female other).freeze
        attribute :gender, String
        validates :gender, presence: true, inclusion: { in: GENDERS }, if: -> { gender.present? }
      end
    end
  end
end
