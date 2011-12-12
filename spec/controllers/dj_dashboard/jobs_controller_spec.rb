require 'spec_helper'

describe DjDashboard::JobsController do

  describe "GET /" do

    it "should fetch jobs" do
      mock(DjDashboard::Job).fetch
      get :index
    end

  end

end
