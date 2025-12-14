RSpec.describe ConstructGreeting do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }

  let(:inputs) { nil }

  it "constructs 'Hello, World!'" do
    expect(outcome).to be_success
    expect(result).to eq("Hello, World!")
  end

  context "when constructing a custom greeting" do
    let(:inputs) do
      { salutation: "howdy", greetee: "y'all" }
    end

    it "constructs the custom greeting" do
      expect(outcome).to be_success
      expect(result).to eq("Howdy, Y'all!")
    end
  end

  context "when hissing" do
    let(:inputs) do
      { salutation: "hiss" }
    end

    it "is an error" do
      expect(outcome).to_not be_success
    end
  end

  context "when using a custom salutation to the universe" do
    let(:inputs) do
      { salutation: "howdy", greetee: "universe" }
    end

    it "is an error" do
      expect(outcome).to_not be_success
    end
  end
end
