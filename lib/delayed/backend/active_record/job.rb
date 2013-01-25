module Delayed
  module Backend
    module ActiveRecord
      class Job < ::ActiveRecord::Base
        before_save ->{ self.job_name = self.name }
      end
    end
  end
end