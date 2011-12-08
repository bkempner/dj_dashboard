DelayedJobDashboard::Engine.routes.draw do
  #get "jobs/index"

  root :to => "jobs#index"
end
