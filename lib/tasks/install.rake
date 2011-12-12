require File.expand_path('../../dj_dashboard/tasks/install', __FILE__)

namespace :dj_dashboard do
  desc "Install dj_dashboard"
  task :install do
    DjDashboard::Tasks::Install.run
  end
end
