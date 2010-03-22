require 'helper'

module ERBView
  class << self
    include ActionView::Helpers
    include Mcmire::MessageDivHelpers
    def concat(content)
      content
    end
    def capture(&block)
      block.call
    end
  end
end

module HamlView
  class << self
    include ActionView::Helpers
    include Mcmire::MessageDivHelpers
    def concat(content)
      content
    end
    def capture_haml(&block)
      block.call
    end
  end
end

Protest.context "message_div_helpers" do
  def html(content)
    Regexp.new(content.strip.gsub(/\s*\n+\s*/, ""))
  end
  
  $shared_tests = lambda do
    {:notice => "information", :success => "accept", :error => "exclamation"}.each do |message_kind, image|
      test "basic #{message_kind} message" do
        view_mock.message_div_for(message_kind, "the message").should =~ html(%|
          <div class="message-div #{message_kind}">
            <div class="message-div-icon">
              <img alt="#{message_kind}" src="/images/message_div_helpers/#{image}.png\\?\\d+" />
            </div>
            <div class="message-div-content">the message</div>
          </div>
        |)
      end
      test "#{message_kind} with a block for the message" do
        view_mock.message_div_for(message_kind) { "the message" }.should =~ html(%|
          <div class="message-div #{message_kind}">
            <div class="message-div-icon">
              <img alt="#{message_kind}" src="/images/message_div_helpers/#{image}.png\\?\\d+" />
            </div>
            <div class="message-div-content">the message</div>
          </div>
        |)
      end
      test "#{message_kind} message returns nothing when message is blank, by default" do
        view_mock.message_div_for(message_kind, "").should == ""
      end
      # -- test returns nothing when the block is blank?
      test "#{message_kind} message returns an empty div when message is blank and :unless_blank is false" do
        view_mock.message_div_for(message_kind, "", :unless_blank => false).should =~ html(%|
          <div class="message-div #{message_kind}">
            <div class="message-div-icon">
              <img alt="#{message_kind}" src="/images/message_div_helpers/#{image}.png\\?\\d+" />
            </div>
            <div class="message-div-content"></div>
          </div>
        |)
      end
      # -- test returns an empty div when the block is blank and :unless_blank is false?
      test "#{message_kind} message excludes an image when :image option is false" do
        view_mock.message_div_for(message_kind, "the message", :image => false).should =~ html(%|
          <div class="message-div #{message_kind}">
            <div class="message-div-content">the message</div>
          </div>
        |)
      end
      test "#{message_kind} with custom html options" do
        view_mock.message_div_for(message_kind, "the message", {}, :style => "text-align: center").should =~ html(%|
          <div class="message-div #{message_kind}" style="text-align: center">
            <div class="message-div-icon">
              <img alt="#{message_kind}" src="/images/message_div_helpers/#{image}.png\\?\\d+" />
            </div>
            <div class="message-div-content">the message</div>
          </div>
        |)
      end
      test "#{message_kind} with a custom class does not override default class" do
        view_mock.message_div_for(message_kind, "the message", {}, :class => "foo").should =~ html(%|
          <div class="message-div foo #{message_kind}">
            <div class="message-div-icon">
              <img alt="#{message_kind}" src="/images/message_div_helpers/#{image}.png\\?\\d+" />
            </div>
            <div class="message-div-content">the message</div>
          </div>
        |)
      end
      test "#{message_kind} with a nil class does not crash" do
        view_mock.message_div_for(message_kind, "the message", {}, :class => nil).should =~ html(%|
          <div class="message-div #{message_kind}">
            <div class="message-div-icon">
              <img alt="#{message_kind}" src="/images/message_div_helpers/#{image}.png\\?\\d+" />
            </div>
            <div class="message-div-content">the message</div>
          </div>
        |)
      end
    end
  end
  
  context "under erb" do
    def view_mock; ERBView; end
    instance_eval(&$shared_tests)
  end
  
  context "under haml" do
    def view_mock; HamlView; end
    instance_eval(&$shared_tests)
  end
  
end