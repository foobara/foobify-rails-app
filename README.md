# foobify-rails-app

This is a code generator for quickly wiring up foobara to an existing Rails application.
It can be helpful if you want to use Foobara as a service-object layer or if you'd like
to use Foobara's automatic-integration features while still having access to aspects of the
Rails ecosystem.

## Installation

Normally, you would just use this with `foob` so you would install `foob` however you would, such as
adding `foob` to the `:development` section of your Gemfile or maybe even just `gem install foob`.

If you want to use this code generator outside of `foob` you can do the typical stuff like adding
`gem "foobara-foobify-rails-app"` to your Gemfile or .gemspec file.

## Usage

### Using via `foob`

You can see the options with `foob help foobify-rails-app` or `foob h foobify-rails-app`:

```
$ foob help foobify-rails-app
```

#### Using Foobara as a service-object layer for an existing Rails app

You can wire up your Rails app with Foobara commands with the following:

```
$ foob g foobify-rails-app
```

If you'd like to have a sample command generated, which is probably a good idea if you're a n00bz of teh f00bz,
you can run:

```
$ foob g foobify-rails-app --include-sample-command
```

Here's an example of calling a Foobara command from a JSON API controller:

```ruby
class GreetingsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    inputs = params.permit(:greetee, :salutation).to_h.symbolize_keys
    outcome = ConstructGreeting.run(inputs)

    if outcome.success?
      render json: outcome.result
    else
      render json: outcome.errors, status: :unprocessable_entity
    end
  end
end
```

Notice that we don't have domain logic in our controller action. Calling this command from a job or
rake task or whatever is now easier due to the code reuse.

And if you want an RSpec spec also generated for the sample command, you can run:

```
$ foob g foobify-rails-app --include-sample-command --rspec
```

#### Using Foobara's automatic-integration features

If you'd like to see what it's like to use Foobara directly instead of through routes/controller actions,
you can run:

```
$ foob g foobify-rails-app --rails-command-connector --include-sample-command
```

And then you can hit `localhost:3000/help` or `localhost:3000/run/ConstructGreeting` to run
your commands RPC-style instead of REST style.

If you would like to make use of the `foobara-active-record-type` gem, you can run:

```
$ foob g foobify-rails-app --active-record-type
```

and this will let you use ActiveRecord classes as if they were Foobara entities.

This would let you pass primary keys to commands instead of records, for example. You could also
generate react forms for your commands and typescript-react-form-generator will be aware of the 
attributes of your ActiveRecord models and make UI fields for them.

## Contributing

Bug reports and pull requests are welcome on GitHub
at https://github.com/foobara/foobify-rails-app

## License

This project is licensed under the MPL-2.0 license. Please see LICENSE.txt for more info.
