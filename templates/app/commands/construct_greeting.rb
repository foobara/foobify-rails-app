class ConstructGreeting < Foobara::Command
  description "Takes an optional salutation and greetee to greet and constructs a greeting"

  inputs do
    salutation :string, default: "hello"
    greetee :string, default: "world"
  end

  result :string

  possible_input_error :salutation, :threatening_to_capybaras, threatening_salutation: :string
  possible_error :greeting_overreach, greetee: :string

  def execute
    normalize_greetee
    normalize_salutation

    check_for_greeting_overreach

    build_greeting

    greeting
  end

  def validate
    if salutation.strip =~ /\s*h*i*ss+\s*/i
      add_input_error :salutation,
                      :threatening_to_capybaras,
                      threatening_salutation: salutation,
                      message: "Do not hiss around our capybaras!"
    end
  end

  attr_accessor :greeting, :normalized_salutation, :normalized_greetee

  def normalize_greetee
    self.normalized_greetee = greetee.strip.capitalize
  end

  def check_for_greeting_overreach
    if salutation != "Hello" && greetee == "Universe"
      message = "Can we keep custom salutations within this galaxy, please?"
      add_error :greeting_overreach, greetee:, message:
    end
  end

  def normalize_salutation
    self.normalized_salutation = salutation.strip.capitalize
  end

  def build_greeting
    self.greeting = "#{salutation}, #{greetee}!"
  end
end
