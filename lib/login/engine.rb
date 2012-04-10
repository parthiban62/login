
module Login

  class Engine < Rails::Engine

    initialize "login.load_app_instance_data" do |app|
      Parthiban.setup do |config|
        config.app_root = app.root
      end
    end

    initialize "login.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

  end

end