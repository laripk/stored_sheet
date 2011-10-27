module ApplicationHelper

   def webdebug?
      puts Rails.env
      puts ENV["RAILS_ENV"]
      ['development'].include?(Rails.env)  # , 'test'
   end

end
