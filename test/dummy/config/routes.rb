Rails.application.routes.draw do

  mount DelayedJobDashboard::Engine => "/dj"
end
