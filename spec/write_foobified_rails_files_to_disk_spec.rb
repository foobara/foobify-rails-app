RSpec.describe Foobara::Generators::FoobifyRailsApp::WriteFoobifiedRailsFilesToDisk do
  let(:command) { described_class.new(inputs) }
  let(:test_project) { "rails-test-app" }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:inputs) do
    {
      output_directory:,
      foobify_rails_app_config:
    }
  end
  let(:foobify_rails_app_config) do
    Foobara::Generators::FoobifyRailsApp::FoobifyRailsAppConfig.new(
      include_sample_command:,
      use_rails_command_connector:,
      use_active_record_type:,
      rspec:
    )
  end
  let(:include_sample_command) { false }
  let(:use_rails_command_connector) { false }
  let(:use_active_record_type) { false }
  let(:rspec) { false }
  let(:output_directory) { "#{__dir__}/../tmp/foobified_rails_app_test_suite_output" }

  around do |example|
    FileUtils.rm_rf output_directory
    FileUtils.mkdir_p output_directory

    project_fixture_dir = "#{__dir__}/fixtures/#{test_project}"

    Dir["#{project_fixture_dir}/*", "#{project_fixture_dir}/.*"].each do |f|
      next if f.end_with?(".")

      FileUtils.cp_r f, output_directory
    end

    Dir.chdir(output_directory) { example.run }
  end

  describe "#run" do
    it "generates the expected files" do
      expect(outcome).to be_success

      expect(
        command.paths_to_source_code.keys
      ).to contain_exactly("Gemfile", "config/application.rb")
    end

    it "updates the Gemfile" do
      expect(outcome).to be_success

      expect(
        command.paths_to_source_code["Gemfile"]
      ).to include('gem "foobara"')
    end

    context "when using foobara-rails-command-connector" do
      let(:use_rails_command_connector) { true }

      it "updates the Gemfile" do
        expect(outcome).to be_success

        expect(
          command.paths_to_source_code["Gemfile"]
        ).to include('gem "foobara-rails-command-connector"')
      end
    end

    context "when using foobara-active-record-type" do
      let(:use_active_record_type) { true }

      it "updates the Gemfile" do
        expect(outcome).to be_success

        expect(
          command.paths_to_source_code["Gemfile"]
        ).to include('gem "foobara-active-record-type"')
      end
    end

    context "when generating a sample command" do
      let(:include_sample_command) { true }

      context "when using rspec" do
        let(:rspec) { true }

        it "updates the Gemfile" do
          expect(outcome).to be_success

          # TODO: make this test something useful
          expect(
            command.paths_to_source_code["Gemfile"]
          ).to include('gem "foobara"')
        end
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end

  describe "#default_output_directory" do
    subject { command.default_output_directory }

    it { is_expected.to eq(".") }
  end
end
