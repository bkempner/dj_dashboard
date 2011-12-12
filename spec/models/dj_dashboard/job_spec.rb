require 'spec_helper'

describe DjDashboard::Job do

  describe ".fetch" do
    class MyJob
      def perform; end
    end

    class MyOtherJob
      def perform; end
    end

    it "should return a hash for each job" do
      Delayed::Job.enqueue MyJob.new
      Delayed::Job.enqueue MyOtherJob.new
      results = DjDashboard::Job.fetch

      found_myjob = results.any? { |job| job[:name] == 'MyJob' }
      found_myjob.should be_true
      found_myotherjob = results.any? { |job| job[:name] == 'MyOtherJob' }
      found_myotherjob.should be_true
    end

    it "should return each job hash with attributes: name, running, failed, pending, retrying" do
      Delayed::Job.enqueue MyJob.new
      Delayed::Job.enqueue MyOtherJob.new
      results = DjDashboard::Job.fetch
      results.each { |res| res.keys.should include(:name, :running, :failed, :pending, :retrying) }
    end

    it "should return running jobs" do
      2.times { Delayed::Job.enqueue MyJob.new }

      Delayed::Job.update_all(locked_at: Time.now)

      results = DjDashboard::Job.fetch
      results.first[:running].should eql(2)
    end

    it "should return failed jobs" do
      2.times { Delayed::Job.enqueue MyJob.new }

      Delayed::Job.update_all(failed_at: Time.now, attempts: 3)

      results = DjDashboard::Job.fetch
      results.first[:failed].should eql(2)
    end

    it "should return pending jobs" do
      2.times { Delayed::Job.enqueue MyJob.new }

      results = DjDashboard::Job.fetch
      results.first[:pending].should eql(2)
    end

    it "should return retrying jobs" do
      2.times { Delayed::Job.enqueue MyJob.new }

      Delayed::Job.update_all(failed_at: Time.now)

      results = DjDashboard::Job.fetch
      results.first[:retrying].should eql(2)
    end
  end

end
