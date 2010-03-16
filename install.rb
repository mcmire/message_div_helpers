# Copy images to the project
images = File.dirname(__FILE__) + '/public/images/message_div_helpers'
images_dir = "#{RAILS_ROOT}/public/images"
FileUtils.cp_r(images, images_dir)
puts "%s installed to %s." % [ Dir["#{images}/*"].map {|x| File.basename(x) }.to_sentence, images_dir]

# Copy stylesheet to the project
css_file = File.dirname(__FILE__) + '/public/stylesheets/message_div_helpers.css'
stylesheets_dir = "#{RAILS_ROOT}/public/stylesheets"
FileUtils.cp(css_file, stylesheets_dir)
puts "%s installed to %s." % [ File.basename(css_file), stylesheets_dir ]