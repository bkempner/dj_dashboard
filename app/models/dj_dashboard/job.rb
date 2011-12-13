require 'set'

module DjDashboard
  class Job
    def self.fetch(opts={})
      jobs = Delayed::Job.select(:job_name).group(:job_name)
      jobs.map do |job|
        {
          name:     job.job_name,
          running:  Delayed::Job.where(job_name: job.job_name).where("locked_at is not null").count,
          failed:   Delayed::Job.where(job_name: job.job_name).where("failed_at is not null and attempts >= 3").count,
          pending:  Delayed::Job.where(job_name: job.job_name).where(locked_at: nil, failed_at: nil).count,
          retrying: Delayed::Job.where(job_name: job.job_name).where(locked_at: nil).where("failed_at is not null").count
        }
      end
    end
  end
end
