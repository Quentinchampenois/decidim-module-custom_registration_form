# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module Admin
      # This controller is the abstract class from which all other controllers of
      # this engine inherit.
      #
      # Note that it inherits from `Decidim::Admin::BaseController`, which
      # override its layout and provide all kinds of useful methods.
      class ApplicationController < Decidim::Admin::BaseController
      end
    end
  end
end