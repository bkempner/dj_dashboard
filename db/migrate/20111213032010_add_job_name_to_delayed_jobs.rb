class AddJobNameToDelayedJobs < ActiveRecord::Migration
  def self.up
    add_column :delayed_jobs, :job_name, :string
    add_index :delayed_jobs, :job_name
  
    # populate name field with job class name
    Delayed::Job.find_each do |job|
      job.update_attributes(job_name: job.name)
    end
  end

  def self.down
    remove_column :delayed_jobs, :job_name
  end
end
