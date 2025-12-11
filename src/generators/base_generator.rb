require "foobara/files_generator"

module Foobara
  module Generators
    module FoobifyRailsApp
      module Generators
        class BaseGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when FoobifyRailsAppConfig
                [
                  Generators::GemfileGenerator,
                  ConfigApplicationGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          alias foobify_rails_app_config relevant_manifest

          def templates_dir
            # :nocov:
            "#{__dir__}/../../templates"
            # :nocov:
          end
        end
      end
    end
  end
end
