Rails.application.reloader.to_prepare do
  env = Rails.env

  if env != "test" && env != "development"
    raise "Not going to attempt to reload classes in Rails.env: #{env}"
  end

  Foobara.reset_alls
end
