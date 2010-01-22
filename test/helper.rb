require 'rubygems'

gem 'mcmire-protest'
require 'protest'
gem 'mcmire-matchy'
require 'matchy'
gem 'mcmire-mocha'
require 'mocha'
gem 'mocha-protest-integration'
require 'mocha-protest-integration'

Protest.report_with :documentation
Protest::Utils::BacktraceFilter::ESCAPE_PATHS.clear

gem 'activesupport'
require 'activesupport'
gem 'actionpack'
require 'action_view/helpers'
# trick AssetTagHelper into thinking ActionController is loaded
module ActionController
  class Base
    def self.asset_host
    end
  end
end

require 'mcmire/message_div_helpers'