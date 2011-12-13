module DjDashboard
  class ApplicationController < ActionController::Base
    def authenticate!
      # custom auth logic here
      # 
      # example using devise:
      # redirect_to new_user_session_url unless user_signed_in?
    end
  end
end
