require_relative "base_generator"

module Foobara
  module Generators
    module FoobifyRailsApp
      module Generators
        class RoutesGenerator < BaseGenerator
          def applicable?
            use_rails_command_connector? &&
              File.exist?(template_path) &&
              routes_rb_contents !~ /require.*foobara\/rails_command_connector/
          end

          def template_path
            "config/routes.rb"
          end

          def target_path
            template_path
          end

          def generate(_elements_to_generate)
            with_requires_prepended = <<~HERE
              require "foobara/rails_command_connector"
              # require "foobara/auth_http"
              # Foobara::CommandConnectors::RailsCommandConnector.new(authenticator: Foobara::AuthHttp::BearerAuthenticator)
              Foobara::CommandConnectors::RailsCommandConnector.new
              require "foobara/rails/routes"
            HERE

            with_requires_prepended = "#{with_requires_prepended}\n#{routes_rb_contents}"

            match = with_requires_prepended.match(/Rails.application.routes.draw do/)

            if match
              # You can hit /run/ConstructGreeting or /help/ConstructGreeting
              new_entry = "  command ConstructGreeting"

              unless include_sample_command?
                new_entry = "# #{new_entry}"
              end

              "#{match.pre_match}\n#{match}\n#{new_entry}#{match.post_match}"
            else
              # TODO: maybe print a warning and return the original Gemfile
              # :nocov:
              raise "Not sure how to inject foobara into the Gemfile"
              # :nocov:
            end
          end

          def routes_rb_contents
            File.read(template_path)
          end
        end
      end
    end
  end
end
