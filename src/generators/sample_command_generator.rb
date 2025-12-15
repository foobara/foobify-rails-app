require_relative "base_generator"

module Foobara
  module Generators
    module FoobifyRailsApp
      module Generators
        class SampleCommandGenerator < BaseGenerator
          def applicable?
            foobify_rails_app_config.include_sample_command?
          end

          def template_path
            ["app", "commands", "construct_greeting.rb.erb"]
          end

          def target_path
            template_path
          end
        end
      end
    end
  end
end
