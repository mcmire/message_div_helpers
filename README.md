# message_div_helpers

## Summary

A little plugin for Rails that gives you a handy way of creating a div you would use to display a message to the user after some action -- maybe an informational message, or a message indicating success or failure -- and doing so in a consistent way.

## Examples

    <%= message_div_for :notice, flash[:notice] %>

    <%= message_div_for :success, @success, {}, :style => "border: 1px solid green" %>

    <% message_div_for :error do %>
      Some content goes here
    <% end %>

## Installation

Nothing special here, just the ordinary:

  script/plugin install git://github.com/mcmire/message_div_helpers

Be aware that when you install the plugin, three images will be installed to `public/images/message_div_helpers`. These are just icons for each of the message types, taken from the fabulous "silk" icon set at [famfamfam.com](http://famfamfam.com/lab/icons/silk/).

## Support

If you find a bug or have a feature request, I want to know about it! Feel free to file a [Github issue](http://github.com/mcmire/message_div_helpers/issues), or do one better and fork the [project on Github](http://github.com/mcmire/message_div_helpers) and send me a pull request or patch. Be sure to add tests if you do so, though.

You can also [email me](mailto:elliot.winkler@gmail.com), or [find me on Twitter](http://twitter.com/mcmire).

## Author/License

(c) 2009-2010 Elliot Winkler. See LICENSE for details.