Rails.application.routes.draw do
  get "dj_dashboard" => "dj_dashboard/jobs#index", :as => :dj_dashboard
  get "dj_dashboard/jobs/stats" => "dj_dashboard/jobs#stats", :as => :dj_dashboard_job_stats
end
