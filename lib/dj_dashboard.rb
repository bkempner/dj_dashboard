require 'active_support/dependencies'

module DjDashboard

  mattr_accessor :app_root

  def self.setup
    yield self
  end

end

require 'dj_dashboard/engine'
