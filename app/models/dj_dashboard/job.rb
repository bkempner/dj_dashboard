require 'set'

module DjDashboard
  class Job
    def self.fetch(opts={})
      results = Delayed::Job.select(:handler).group(:handler)
      names = results.reduce(Set.new) do |names, result|
        names << result[:handler].chomp.scan(/ruby\/\w+:([a-zA-Z:]+)\ /).flatten.first
      end

      names.map do |job|
        {
          name:     job,
          running:  Delayed::Job.where("handler like '%#{job}%'").where("locked_at is not null").count,
          failed:   Delayed::Job.where("handler like '%#{job}%'").where("failed_at is not null and attempts > 3").count,
          pending:  Delayed::Job.where("handler like '%#{job}%'").where(locked_at: nil, failed_at: nil).count,
          retrying: Delayed::Job.where("handler like '%#{job}%'").where(locked_at: nil).where("failed_at is not null").count
        }
      end
    end
  end
end
