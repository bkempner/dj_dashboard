module DjDashboard
  class JobsController < ApplicationController
    layout 'dj_dashboard'

    before_filter :authenticate!

    def index
      @jobs = Job.fetch
    end
  end
end
