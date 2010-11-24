module Mcmire
  module MessageDivHelpers
    @@icon_path = "message_div_helpers"
    mattr_accessor :icon_path
    
    # This is a handy way of creating a div you would use to display a message
    # to the user after some action -- maybe an informational message, or a
    # message indicating success or failure -- and doing so in a consistent way.
    #
    # The first argument indicates what kind of message it is: :notice, :success,
    # or :error. This also chooses what kind of icon to show at the beginning of
    # the message. This assumes you have the silk icons from famfam.com installed
    # in public/images/icons/silk.
    #
    # The value of the div can be specified in the second argument, or you can
    # also pass a block that will get evaluated.
    #
    # Pass a hash for the third argument to specify the options. They are:
    # * :unless_blank - true by default, which means the div won't be output if
    #                   the message ends up being blank. Set to false to override.
    # * :image        - true by default, which means an icon will appear
    #                   corresponding to the message type, to the left of the
    #                   message. Set to false to override.
    #
    # Finally, pass a hash for the fourth argument to specify HTML options for
    # the div itself. By default, it will get a class name corresponding to the
    # message type (so "notice", "success", or "error").
    #
    # === Examples
    #
    #   <%= message_div_for :notice, flash[:notice] %>
    #
    #   <%= message_div_for :success, @success, {}, :style => "border: 1px solid green" %>
    #
    #   <% message_div_for :error do %>
    #     Some content goes here
    #   <% end %>
    #
    def message_div_for(kind, *args, &block)
      value, options, div_options = args
      options ||= {}
      div_options ||= {}

      kind = kind.to_sym
      options[:unless_blank] = true unless options.include?(:unless_blank)
      options[:image] = true if [:notice, :success, :error].include?(kind) && !options.include?(:image)
      div_options[:class] = ["message-div", div_options[:class].to_s, kind.to_s].reject(&:blank?).join(" ")

      div_content = block_given? ? (respond_to?(:capture_haml) ? capture_haml(&block) : capture(&block)).chomp : value
      return "" if options[:unless_blank] && div_content.blank?

      image_content = ""
      if options.delete(:image)
        image = case kind
          when :notice  then "information"
          when :success then "accept"
          when :error   then "exclamation"
        end
        image_div_options = { :class => 'message-div-icon' }
        image_content = content_tag(:div, image_tag("#{MessageDivHelpers.icon_path}/#{image}.png", :alt => kind.to_s), image_div_options)
      end

      div = content_tag(:div, image_content + content_tag(:div, div_content, :class => "message-div-content"), div_options)
      block_given? ? concat(div) : div
    end
    safe_helper :message_div_for if respond_to?(:safe_helper)

    def message_divs
      message_div_for(:success, (flash[:success] || @success)) +
      message_div_for(:error,   (flash[:error]   || @error)) +
      message_div_for(:notice,  (flash[:notice]  || @notice))
    end
    safe_helper :message_divs if respond_to?(:safe_helper)
  end
end