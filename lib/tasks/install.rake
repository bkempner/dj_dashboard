require File.expand_path('../../dj_dashboard/tasks/install', __FILE__)

namespace :dj_dashboard do
  desc "Install dj_dashboard"
  task :install do
    puts "Installing dj_dashboard"
    puts "This may take several minutes if you have lots of existing jobs."
    DjDashboard::Tasks::Install.run
  end
end
