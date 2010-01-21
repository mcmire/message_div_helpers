# Copy images to the project
images_dir = "#{RAILS_ROOT}/public/images/message_div_helpers"
FileUtils.mkdir_p(images_dir)
FileUtils.cp_r(Dir[File.dirname(__FILE__) + '/public/images/*'], images_dir)