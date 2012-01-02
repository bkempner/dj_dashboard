require 'set'

module DjDashboard
  class Job
    def self.fetch(opts={})
      jobs = Delayed::Job.select(:job_name).group(:job_name)
      jobs.map do |job|
        {
          name:     job.job_name,
          running: Delayed::Job.running(job.job_name).count,
          failed:   Delayed::Job.failed(job.job_name).count,
          pending:  Delayed::Job.pending(job.job_name).count,
          retrying: Delayed::Job.retrying(job.job_name).count
        }
      end
    end
  end
end
