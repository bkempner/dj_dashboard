class AddIndexesOnDelayedJob < ActiveRecord::Migration
  def self.up
    add_index :delayed_jobs, :locked_at
    add_index :delayed_jobs, :failed_at
    add_index :delayed_jobs, [:locked_at, :failed_at]
    add_index :delayed_jobs, [:failed_at, :attempts]
  end

  def self.down
    remove_index :delayed_jobs, :locked_at
    remove_index :delayed_jobs, :failed_at
    remove_index :delayed_jobs, [:locked_at, :failed_at]
    remove_index :delayed_jobs, [:failed_at, :attempts]
  end
end
