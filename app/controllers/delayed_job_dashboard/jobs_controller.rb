module DelayedJobDashboard
  class JobsController < ApplicationController

    def index
      @jobs = Job.fetch
    end
  
  end
end
