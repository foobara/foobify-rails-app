# FoobifyRailsApp

This is a code generator for quickly wiring up foobara to an existing Rails application.

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

#### Using foobara as a service-object solution in an existing Rails application

You would only need to run it with:

```
$ foob g foobify-rails-app
```

TODO: Finish this up once deployed and added to `foob`

If you're new to Foobara and want a sample command generated, you can run:

#### Exposing Foobara through the Rails router with foobara-rails-command-generator

If you want to expose your Foobara commands such that they can be used by external tools like
code generators (to generate a TypeScript SDK, for example), MCP servers, etc, then run:

TODO

#### Letting ActiveRecord Models be used as if they were Foobara types

You can run:

This will allow you to use active record as types like so:

```ruby
TODO

```

You can do this without `foobara-active-record-type` and Foobara will still guarantee that what is
passed in is an instance of that active record class. But with `foobara-active-record-type` you can
get additional foobara-entity-like behaviors, such as automatically casting primary keys to records
and being able to make use of the record attributes in code generators if, for example, you wanted
to quickly generate a TypeScript React form as a starting point for working with your 
ActiveRecord class.

## Contributing

Bug reports and pull requests are welcome on GitHub
at https://github.com/foobara/foobify-rails-app

You can find a contributing guide in the foobara monorepo here: 
https://github.com/foobara/foobara/blob/main/CONTRIBUTING.md

## License

This project is licensed under the MPL-2.0 license. Please see LICENSE.txt for more info.
