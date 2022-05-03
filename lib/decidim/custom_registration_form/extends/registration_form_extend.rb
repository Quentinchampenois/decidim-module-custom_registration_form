# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module RegistrationFormExtend
      extend ActiveSupport::Concern

      included do
        attribute :gender, String

        validates :gender, presence: true
      end
    end
  end
end
