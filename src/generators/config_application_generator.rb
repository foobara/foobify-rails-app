require_relative "base_generator"

module Foobara
  module Generators
    module FoobifyRailsApp
      module Generators
        class ConfigApplicationGenerator < BaseGenerator
          def applicable?
            File.exist?(template_path) && application_rb_contents !~ /Rails\.root\.join.*\bapp\b.*\bcommands\b/
          end

          def template_path
            "config/application.rb"
          end

          def target_path
            template_path
          end

          def generate(_elements_to_generate)
            match = application_rb_contents.match(/class\s+Application\s*<.*Application\b/)

            if match
              new_entry = '    config.eager_load_paths << Rails.root.join("app", "commands")'

              "#{match.pre_match}\n#{match}\n#{new_entry}\n#{match.post_match}"
            else
              # TODO: maybe print a warning and return the original Gemfile
              # :nocov:
              raise "Not sure how to inject foobara into the Gemfile"
              # :nocov:
            end
          end

          def application_rb_contents
            File.read(template_path)
          end
        end
      end
    end
  end
end
