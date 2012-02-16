module DjDashboard
  class JobsController < ApplicationController
    layout 'dj_dashboard'

    before_filter :authenticate!

    PAGE_SIZE = 10

    def index
      @jobs = Job.fetch
    end

    def stats
      @current_page = params[:page] && params[:page].to_i || 1
      offset = params[:page] && ((params[:page].to_i-1) * PAGE_SIZE) || 0
      @jobs = Delayed::Job.send(params[:type].to_sym, params[:job_name]).order("created_at desc").limit(PAGE_SIZE).offset(offset)
      @pages = (1..(Delayed::Job.send(params[:type].to_sym, params[:job_name]).count.to_f / PAGE_SIZE).ceil).to_a
      @jobs_wp = Delayed::Job.send(params[:type].to_sym, params[:job_name]).page(params[:page]).per_page(PAGE_SIZE)
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
