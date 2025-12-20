module Foobara
  module Generators
    module FoobifyRailsApp
      class FoobifyRailsAppConfig < Foobara::Model
        attributes do
          include_sample_command :boolean,
                                 default: false,
                                 description: "Includes a sample Foobara command in the output"
          rails_command_connector :boolean,
                                  default: false,
                                  description: "Wires up a RailsCommandConnector with the Rails router. " \
                                               "You can use this to see what it would be like to run  " \
                                               "Foobara commands via RPC."
          active_record_type :boolean,
                             default: false,
                             description: "Will add foobara-active-record-type to the Gemfile which will allow " \
                                          "ActiveRecord classes to be used in certain ways " \
                                          "as if they were Foobara entities."
          rspec :boolean,
                default: false,
                description: "If including a sample command then " \
                             "this will also generate an RSpec spec for the sample command."
        end

        def use_active_record_type?
          active_record_type
        end

        def use_rails_command_connector?
          rails_command_connector
        end

        def use_rspec?
          rspec
        end

        def include_sample_command?
          include_sample_command
        end
      end
    end
  end
end
