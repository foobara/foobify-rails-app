class ConstructGreeting < Foobara::Command
  description "Takes an optional salutation and greetee to greet and constructs a greeting"

  inputs do
    salutation :string, default: "hello"
    greetee :string, default: "world"
  end

  result :string

  possible_input_error :salutation, :threatening_to_capybaras,
                       context: { threatening_salutation: :string },
                       message: "Do not hiss around our capybaras!"
  possible_error :greeting_overreach,
                 context: { greetee: :string },
                 message: "Can we keep custom salutations within this galaxy, please?"

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
                      threatening_salutation: salutation

    end
  end

  attr_accessor :greeting, :normalized_salutation, :normalized_greetee

  def normalize_greetee
    self.normalized_greetee = greetee.strip.capitalize
  end

  def check_for_greeting_overreach
    if normalized_salutation != "Hello" && normalized_greetee == "Universe"
      add_runtime_error :greeting_overreach, greetee:
    end
  end

  def normalize_salutation
    self.normalized_salutation = salutation.strip.capitalize
  end

  def build_greeting
    self.greeting = "#{normalized_salutation}, #{normalized_greetee}!"
  end
end
