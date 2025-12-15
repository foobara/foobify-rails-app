require_relative "base_generator"

module Foobara
  module Generators
    module FoobifyRailsApp
      module Generators
        class SampleCommandSpecGenerator < BaseGenerator
          def applicable?
            foobify_rails_app_config.include_sample_command? &&
              foobify_rails_app_config.use_rspec?
          end

          def template_path
            ["spec", "commands", "construct_greeting_spec.rb.erb"]
          end
        end
      end
    end
  end
end
