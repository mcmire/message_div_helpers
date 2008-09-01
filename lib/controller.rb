module Mcmire
  module MessageDivHelpers
    module Controller
    
      def self.included(klass)
        klass.class_eval do
          write_inheritable_attribute :message_divs, {}
          class_inheritable_reader    :message_divs
          extend ClassMethods
        end
      end
    
      module ClassMethods
      protected
        # Creates controller and helper methods for each of the names passed that
        # aid the programmer in creating message divs. The contents of the div will
        # be the value of flash[:#{name}] or @#{name}, and the div's class will be the
        # name itself.
        #
        # == Required arguments
        # * the key in the flash hash or the instance variable you're using to store
        #   the message
        #
        # == Options
        # * image: path to an image that will be put to the left of the message.
        #
        # == Example
        #
        #   message_div_helpers_for :success, :image => 'icons/accepted.gif'
        #   message_div_helpers_for :error
        #
        # will create these controller methods:
        #
        #   hide_success_div!
        #   success_div_hidden?
        #   hide_error_div!
        #   error_div_hidden?
        #
        # and these helper methods:
        #
        #   success_div_hidden?
        #   success_div
        #   success_div_unless_blank
        #   error_div_hidden?
        #   error_div
        #   error_div_unless_blank
        #
        def message_div_helpers_for(name, options={})
          message_divs[name.to_sym] = { :hidden => false }.merge(options)
          message_div_info = "self.class.message_divs[:#{name}]"
          class_eval(<<-EOS, __FILE__, __LINE__)
          protected
            def hide_#{name}_div!
              #{message_div_info}[:hidden] = true
            end
          
            def #{name}_div_hidden?
              #{message_div_info}[:hidden]
            end
            helper_method :#{name}_div_hidden?
          EOS
          message_div_info = "controller.message_divs[:#{name}]"
          ActionView::Base.class_eval(<<-EOS, __FILE__, __LINE__)
            def #{name}_div(*args)
              return "" if #{name}_div_hidden?
            
              div_options = { :class => "#{name}" }.merge(args.last.is_a?(Hash) ? args.pop : {})
              msg = args.first if args[0].is_a? String
              hide_using = args.pop || :display

              if hide_using && hide_using != :always_show
                div_options[:style] ? div_options[:style] += ";" : div_options[:style] = ""
                div_options[:style] += (hide_using == :visibility) ? "visibility: hidden" : "display: none"
              end

              content = ""
              if #{message_div_info}[:image]
                content << image_tag(#{message_div_info}[:image], :style => 'vertical-align: middle') + "&nbsp;&nbsp;"
              end
              content << (msg ? msg.to_s : value_for_#{name}_div)
              content_tag(:div, content, div_options)
            end
          
            def #{name}_div_unless_blank(div_options = {})
              value_for_#{name}_div.blank? ? "" : #{name}_div(:always_show, div_options)
            end
          
            def value_for_#{name}_div
              (flash[:#{name}] || @#{name}).to_s
            end
          EOS
        end
      end # ClassMethods
    
    end # Controller
  end # MessageDivHelpers
end # Mcmire