require 'rake'
require File.dirname(__FILE__) + '/../Rakefile'


Rake::Task['jasmine:ci'].invoke
