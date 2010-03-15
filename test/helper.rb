require 'rubygems'

gem 'mcmire-protest'
require 'protest'
gem 'mcmire-mocha'
require 'mocha'
# This must be required before matchy since matchy patches
# the current test case's #run method, however mocha-protest-integration
# completely overrides it
require 'mocha-protest-integration'
gem 'mcmire-matchy'
require 'matchy'

# Matchy/Protest integration
Matchy.adapter :protest, "Protest" do
  def assertions_module; Test::Unit::Assertions; end
  def test_case_class; Protest::TestCase; end
  def assertion_failed_error; Protest::AssertionFailed; end
end
Matchy.use(:protest)

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