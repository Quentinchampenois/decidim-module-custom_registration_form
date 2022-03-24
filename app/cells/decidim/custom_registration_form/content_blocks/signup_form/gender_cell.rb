# frozen_string_literal: true

module Decidim
  module CustomRegistrationForm
    module ContentBlocks
      module SignupForm
        class GenderCell < Decidim::ViewModel
          def gender
            %w(male female other)
          end
        end
      end
    end
  end
end
