module Foobara
  module Generators
    module FoobifyRailsApp
      module Generators
        class GemfileGenerator < BaseGenerator
          def applicable?
            return false unless File.exist?(template_path)

            need_to_add_foobara? ||
              need_to_add_foobara_active_record_type? ||
              need_to_add_foobara_rails_command_connector?
          end

          def need_to_add_foobara?
            gemfile_contents !~ /^\s*gem\s*["']foobara\b["']/
          end

          def need_to_add_foobara_active_record_type?
            if foobify_rails_app_config.use_active_record_type?
              gemfile_contents !~ /^\s*gem\s*["']foobara-active-record-type\b["']/
            end
          end

          def need_to_add_foobara_rails_command_connector?
            if foobify_rails_app_config.use_rails_command_connector?
              gemfile_contents !~ /^\s*gem\s*["']foobara-rails-command-connector\b["']/
            end
          end

          def template_path
            "Gemfile"
          end

          def target_path
            template_path
          end

          def generate(_elements_to_generate)
            match = gemfile_contents.match(/^gem\s/)

            if match
              new_entries = []

              new_entries << 'gem "foobara"' if need_to_add_foobara?
              new_entries << 'gem "foobara-active-record-type"' if need_to_add_foobara_active_record_type?
              new_entries << 'gem "foobara-rails-command-connector"' if need_to_add_foobara_rails_command_connector?

              new_entry = new_entries.join("\n")

              "#{match.pre_match}\n#{new_entry}\n#{match}#{match.post_match}"
            else
              # TODO: maybe print a warning and return the original Gemfile
              # :nocov:
              raise "Not sure how to inject foobara into the Gemfile"
              # :nocov:
            end
          end

          def gemfile_contents
            File.read(template_path)
          end
        end
      end
    end
  end
end
