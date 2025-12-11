require_relative "generate_foobified_rails_files"

module Foobara
  module Generators
    module FoobifyRailsApp
      class WriteFoobifiedRailsFilesToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class << self
          def generator_key
            "FoobifyRailsApp"
          end
        end

        depends_on GenerateFoobifiedRailsFiles

        inputs do
          foobify_rails_app_config FoobifyRailsAppConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string
        end

        def execute
          generate_file_contents
          write_all_files_to_disk
          run_post_generation_tasks

          stats
        end

        def output_directory
          inputs[:output_directory] || default_output_directory
        end

        def default_output_directory
          "."
        end

        def generate_file_contents
          puts "generating files..."
          self.paths_to_source_code = run_subcommand!(GenerateFoobifiedRailsFiles,
                                                      foobify_rails_app_config.attributes)
        end

        def run_post_generation_tasks
          Dir.chdir output_directory do
            bundle_install
            rubocop_autocorrect
          end
        end

        # TODO: is this not in the base class?
        def bundle_install
          unless File.exist?("Gemfile")
            # :nocov:
            return
            # :nocov:
          end

          puts "bundling..."
          cmd = "bundle install"

          Bundler.with_unbundled_env do
            Open3.popen3(cmd) do |_stdin, _stdout, stderr, wait_thr|
              exit_status = wait_thr.value

              unless exit_status.success?
                # :nocov:
                warn "WARNING: could not #{cmd}\n#{stderr.read}"
                # :nocov:
              end
            end
          end
        end

        # TODO: is this not in the base class?
        def rubocop_autocorrect
          unless File.exist?(".rubocop.yml")
            # :nocov:
            return
            # :nocov:
          end

          puts "linting..."
          cmd = "bundle exec rubocop --no-server -A"

          Bundler.with_unbundled_env do
            Open3.popen3(cmd) do |_stdin, stdout, stderr, wait_thr|
              exit_status = wait_thr.value
              unless exit_status.success?
                # :nocov:
                warn "WARNING: could not #{cmd}.\n#{stdout.read}\n#{stderr.read}"
                # :nocov:
              end
            end
          end
        end
      end
    end
  end
end
