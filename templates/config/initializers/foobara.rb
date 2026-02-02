# We need to make sure Foobara is reset whenever we're reloading classes via Zeitwerk
# or really strange stuff happens with stale Foobara types, etc.
rails_env = Rails.env
ENV["FOOBARA_ENV"] ||= rails_env

Rails.application.reloader.to_prepare do
  if rails_env != "test" && rails_env != "development"
    raise "Not going to attempt to reload classes in Rails.env: #{rails_env}"
  end

  Foobara.reset_alls
end
