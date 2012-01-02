module DjDashboard
  class JobsController < ApplicationController
    layout 'dj_dashboard'

    before_filter :authenticate!

    def index
      @jobs = Job.fetch
    end

    def stats
      @jobs = Delayed::Job.send(params[:type].to_sym, params[:job_name]).page(params[:page]).per_page(10)
      @is_pagination_link = params[:page] ? true : false
      @job_name = @jobs.first.job_name if @jobs.any?
      @stat_type = params[:type]

      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
