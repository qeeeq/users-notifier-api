namespace :rpush do
  desc "Create Rpush android app"
  task android_app: [:environment] do
    Rpush::Gcm::App.create(
      name: "android_app",
      connections: 1,
      environment: Rails.env,
      type: "Rpush::Client::ActiveRecord::Gcm::App",
      auth_key: ENV['AUTH_KEY']
    )
    puts "Rpush Android app created Successfully"
  end
end
