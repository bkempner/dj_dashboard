module DjDashboard
  class JobsController < ApplicationController
    layout 'dj_dashboard'

    before_filter :authenticate!

    def index
      @jobs = Job.fetch
    end

    def stats
      @jobs = Delayed::Job.where("job_name = '#{params[:job_name]}'").limit(10)
      @job_name = @jobs.first.job_name
      @stat_type = params[:type]
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
