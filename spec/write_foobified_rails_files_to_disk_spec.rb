RSpec.describe Foobara::Generators::FoobifyRailsApp::WriteFoobifiedRailsFilesToDisk do
  let(:command) { described_class.new(inputs) }
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
      rails_command_connector:,
      active_record_type:,
      rspec:
    )
  end
  let(:include_sample_command) { false }
  let(:rails_command_connector) { false }
  let(:active_record_type) { false }
  let(:rspec) { false }

  let(:test_project) { "rails-test-app" }
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
    it "updates the Gemfile" do
      expect(outcome).to be_success

      expect(
        command.paths_to_source_code["Gemfile"]
      ).to include('gem "foobara"')
    end

    context "with no FoobifyRailsAppConfig used" do
      let(:inputs) do
        { output_directory: }
      end

      it "updates the Gemfile" do
        expect(outcome).to be_success

        expect(
          command.paths_to_source_code["Gemfile"]
        ).to include('gem "foobara"')
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
