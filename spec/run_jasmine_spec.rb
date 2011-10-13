require 'rake'
require File.dirname(__FILE__) + '/../Rakefile'

begin
   Rake::Task['jasmine:ci'].invoke
rescue RuntimeError
   puts "RuntimeError occurred: #{$!}"
end
