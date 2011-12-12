module DjDashboard
  class JobsController < ApplicationController
    layout 'dj_dashboard'

    def index
      @jobs = Job.fetch
    end
  
  end
end
