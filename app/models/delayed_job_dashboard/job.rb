module DelayedJobDashboard
  class Job
    def self.fetch(opts={})
      jobs = Delayed::Job.select(:handler).group(:handler).map { |job| { handler: job[:handler].chomp, name: job[:handler].scan(/object:(\w+)\ /).flatten.first } }
      jobs.each do |job|
        job[:running] = Delayed::Job.where("handler like '%#{job[:name]}%'").where("locked_at is not null").count
        job[:failed] = Delayed::Job.where("handler like '%#{job[:name]}%'").where("failed_at is not null and attempts > 3").count
        job[:pending] = Delayed::Job.where("handler like '%#{job[:name]}%'").where(locked_at: nil, failed_at: nil).count
        job[:retrying] = Delayed::Job.where("handler like '%#{job[:name]}%'").where(locked_at: nil).where("failed_at is not null").count
      end
    
      jobs
    end
  end
end
