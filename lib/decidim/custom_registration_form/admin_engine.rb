# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    # This is the engine that runs on the public interface of `CustomRegistrationForm`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::CustomRegistrationForm::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :custom_registration_form do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "custom_registration_form#index"
      end

      def load_seed
        nil
      end
    end
  end
end
