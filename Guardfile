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


guard 'rspec', :version => 2 do
   # watch(%r{^spec/.+_spec\.rb$})
   # 
   # watch('spec/spec_helper.rb')  { 'spec' }
   # watch('stored_sheet.rb') { 'spec' }
   # 
   # # watch(%r{^lib/app_(.+)\.rb$}) { 'spec' }
   # 
   # watch(%r{^lib/(.+)\.rb$}) { 'spec' }   
   # # watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
   # 
   # watch(%r{^views/(.+)\.haml$}) { 'spec' }
   # 

   # watch(%r{^public/app/(.+)\.js$}) { 'spec/run_jasmine_spec.rb' }
   # watch(%r{^spec/javascripts/(.+)\.js$}) { 'spec/run_jasmine_spec.rb' }
   # watch('spec/javascripts/support/jasmine.yml') { 'spec/run_jasmine_spec.rb' }


   # Rails example
   watch(%r{^spec/.+_spec\.rb$})
   watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
   watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
   watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
   watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
   watch('spec/spec_helper.rb')                        { "spec" }
   watch('config/routes.rb')                           { "spec/routing" }
   watch('app/controllers/application_controller.rb')  { "spec/controllers" }
   # Capybara request specs
   watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
   
   callback(:start_end) { print_timestamp }
end

# guard 'shell' do
#    watch('*')  { `date` }
#    callback(:start_end) { print_timestamp }
# end

guard 'jasmine' do
   watch(%r{app/assets/javascripts/(.+)\.(js\.coffee|js)}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
   watch(%r{spec/javascripts/(.+)_spec\.(js\.coffee|js)})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
   watch(%r{spec/javascripts/spec\.(js\.coffee|js)})       { "spec/javascripts" }
   
   callback(:start_end) { print_timestamp }
end


