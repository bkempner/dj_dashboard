module DjDashboard
  class Engine < Rails::Engine
    initializer 'dj_dashboard.load_app_instance_data' do |app|
      DjDashboard.setup do |config|
        config.app_root = app.root
      end 
    end

    initializer 'dj_dashboard.load_static_assets' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public" if Rails.version =~ /3.0/
      app.middleware.use ::ActionDispatch::Static, "#{root}/app/assets" if Rails.version =~ /3.1/
    end
  end
end
