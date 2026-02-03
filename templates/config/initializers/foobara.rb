# We need to make sure Foobara is reset whenever we're reloading classes via Zeitwerk
# or really strange stuff happens with stale Foobara types, etc.

rails_env = Rails.env
ENV["FOOBARA_ENV"] ||= rails_env

if rails_env == "test" || rails_env == "development"
  Rails.application.reloader.to_prepare do
    Foobara.reset_alls
  end
end
