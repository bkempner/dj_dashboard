# DjDashboard

The missing dashboard for delayed_job.

Tested with Ruby 1.9.2, Rails 3.0+

# Screenshots

Coming soon...

# Installation

Add to your Gemfile:

    gem 'dj_dashboard'

Then run:

    rake dj_dashboard:install

Installation may take several minutes if you have a lot of existing jobs (50k+).

# Usage

Start the server:

    rails s

View the dashboard at: http://localhost:3000/dj_dashboard

# Authentication

The installer will create an initializer in app/config/initializers/dj_dashboard.rb

In the initializer, you can define any auth logic that will be used by the controller's before_filter callback.

Below is an example using devise:

    module DjDashboard
      class ApplicationController < ActionController::Base
        def authenticate!
          redirect_to new_user_session_url unless user_signed_in?
        end
      end
    end
    
# Build Status

[![Build Status](https://secure.travis-ci.org/bkempner/dj_dashboard.png?branch=master)][travis]
[travis]: http://travis-ci.org/bkempner/dj_dashboard

# Dependency Status

[![Dependency Status](https://gemnasium.com/bkempner/dj_dashboard.png?travis)][gemnasium]

[gemnasium]: https://gemnasium.com/bkempner/dj_dashboard

# License

This project uses MIT-LICENSE.