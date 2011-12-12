Rails.application.routes.draw do
  get "dj_dashboard" => "dj_dashboard/jobs#index", :as => :dj_dashboard
end
