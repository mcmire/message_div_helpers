require File.dirname(__FILE__)+'/lib/controller'
ActionController::Base.send(:include, Mcmire::MessageDivHelpers::Controller)
