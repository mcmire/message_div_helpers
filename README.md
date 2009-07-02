# message_div_helpers

## Summary

This is a Rails plugin to aid the programmer in creating and displaying message divs
(such as notices or errors) based on variables saved in flash, instance variables, 
or wherever.

## Usage

    <%= message_div_for :notice, flash[:notice] %>

    <%= message_div_for :success, @success, {}, :style => "border: 1px solid green" %>

    <% message_div_for :error do %>
      Some content goes here
    <% end %>

## Installation

First, download the silk icon set from [famfam.com](http://famfamfam.com/lab/icons/silk/) and put it in `public/images/icons/silk`.

Then, you can just use the standard Rails plugin installer:

    script/plugin install git://github.com/mcmire/message_div_helpers

## Support

If you find any bugs with this plugin, feel free to:

* file a bug report in the [Issues area on Github](http://github.com/mcmire/message_div_helpers/issues)
* fork the [project on Github](http://github.com/mcmire/message_div_helpers) and send me a pull request
* email me (*firstname* dot *lastname* at gmail dot com)

## Author/License

(c) 2009 Elliot Winkler. Released under the MIT license.