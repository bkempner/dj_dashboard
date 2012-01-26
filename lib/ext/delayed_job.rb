module Delayed
  module Backend
    module Base
      module ClassMethods
        alias_method :old_enqueue, :enqueue
        def enqueue(*args)
          job = old_enqueue(*args)
          job.update_attributes(job_name: job.name)
          job
        end

        def running(job_name = nil)
          running = job_name ? where(job_name: job_name) : scoped
          running.where("locked_at is not null").where(:attempts => 0)
        end

        def failed(job_name = nil)
          failed = job_name ? where(job_name: job_name) : scoped
          failed.where("failed_at is not null and attempts >= #{Delayed::Worker.max_attempts}")
        end

        def pending(job_name = nil)
          pending = job_name ? where(job_name: job_name) : scoped
          pending.where(locked_at: nil, failed_at: nil)
        end
    
        def retrying(job_name = nil)
          retrying = job_name ? where(job_name: job_name) : scoped
          retrying.where(locked_at: nil).where("failed_at is not null").where("attempts < #{Delayed::Worker.max_attempts}")
        end
      end
    end
  end
end
