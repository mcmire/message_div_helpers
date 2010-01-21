require 'rubygems'

gem 'mcmire-protest'
require 'protest'
gem 'mcmire-matchy'
require 'matchy'
gem 'mcmire-mocha'
require 'mocha'
require 'mocha-protest-integration'

Protest.report_with :documentation
Protest::Utils::BacktraceFilter::ESCAPE_PATHS.clear

require 'activesupport'
require 'action_view/helpers'
module ActionController
  class Base
    def self.asset_host
    end
  end
end

require 'mcmire/message_div_helpers'