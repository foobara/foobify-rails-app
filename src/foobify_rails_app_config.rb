module Foobara
  module Generators
    module FoobifyRailsApp
      class FoobifyRailsAppConfig < Foobara::Model
        attributes do
          include_sample_command :boolean, default: true
          use_rails_command_connector :boolean,
                                      default: false,
                                      description: "Do you want to expose commands through the rails " \
                                                   "router directly instead of running them in controller actions?"
          use_active_record_type :boolean,
                                 default: false,
                                 description: "Do you want to treat ActiveRecord classes like Foobara entities? " \
                                              "This means automatically casting primary keys to records and " \
                                              "being able to expose their attributes via command connectors"
          rspec :boolean, default: false
        end

        def use_active_record_type?
          use_active_record_type
        end

        def use_rails_command_connector?
          use_rails_command_connector
        end

        def use_rspec?
          rspec
        end
      end
    end
  end
end
