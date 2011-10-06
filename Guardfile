# More info at https://github.com/guard/guard#readme
# Note to guard newbies: Ctrl-C exits, Enter reruns

ignore_paths '.git', '.notes_to_self'

def print_timestamp
   puts "\n## Waiting since #{Time.now}\n\n"
end

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
  callback(:start_end) { print_timestamp }
end

guard 'coffeescript', :input => 'lib/coffee', :output => 'public/app', 
      :all_on_start => true, :bare => true do
   callback(:start_end) { print_timestamp }
end

guard 'coffeescript', :input => 'spec/coffeescripts', :output => 'spec/javascripts', :all_on_start => true do
   callback(:start_end) { print_timestamp }
end

guard 'rspec', :version => 2 do
   watch(%r{^spec/.+_spec\.rb$})

   watch('spec/spec_helper.rb')  { 'spec' }
   watch('stored_sheet.rb') { 'spec' }

   # watch(%r{^lib/app_(.+)\.rb$}) { 'spec' }

   watch(%r{^lib/(.+)\.rb$}) { 'spec' }   
   # watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
   
   watch(%r{^views/(.+)\.haml$}) { 'spec' }


   # # Rails example
   # watch(%r{^spec/.+_spec\.rb$})
   # watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
   # watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
   # watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
   # watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
   # watch('spec/spec_helper.rb')                        { "spec" }
   # watch('config/routes.rb')                           { "spec/routing" }
   # watch('app/controllers/application_controller.rb')  { "spec/controllers" }
   # # Capybara request specs
   # watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
   
   callback(:start_end) { print_timestamp }
end

guard 'shell' do
   # # watch(%r{app/assets/javascripts/(.+)\.(js\.coffee|js)}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
   # watch(%r{public/app/(.+)\.js}) { |m| "spec/javascripts/#{m[1]}_spec.js" }
   # watch(%r{spec/javascripts/(.+)_spec\.(js\.coffee|js)})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
   # watch(%r{spec/javascripts/spec\.(js\.coffee|js)})       { "spec/javascripts" }
   watch(%r{public/app/(.+)\.js}) { `rake jasmine:ci` }
   watch(%r{spec/javascripts/(.+)\.js}) { `rake jasmine:ci` }
   watch('spec/javascripts/support/jasmine.yml') { `rake jasmine:ci` }
   
   callback(:start_end) { print_timestamp }
end
