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
                  SampleCommandGenerator,
                  SampleCommandSpecGenerator,
                  RoutesGenerator
                ]
              else
                # simplecov:disable
                raise "Not sure how build a generator for a #{manifest}"
                # simplecov:enable
              end
            end
          end

          alias foobify_rails_app_config relevant_manifest

          def templates_dir
            # simplecov:disable
            "#{__dir__}/../../templates"
            # simplecov:enable
          end
        end
      end
    end
  end
end
