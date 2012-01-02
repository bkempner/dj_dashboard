require 'active_support/dependencies'
require 'haml'
require 'delayed_job'
require 'will_paginate'

module DjDashboard

  mattr_accessor :app_root

  def self.setup
    yield self
  end

end

require 'dj_dashboard/engine'
require 'ext/delayed_job'
