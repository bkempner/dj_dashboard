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
      end
    end
  end
end
