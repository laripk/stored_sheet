# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Signal handlers are used to interact with Guard:
# Ctrl-C - Calls each guard's #stop method, in the same order they are declared in the Guardfile, and then quits Guard itself.
# Ctrl-\ - Calls each guard's #run_all method, in the same order they are declared in the Guardfile.
# Ctrl-Z - Calls each guard's #reload method, in the same order they are declared in the Guardfile.

group 'servers' do # run: $ guard --group servers -n f
   guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
     watch('config/application.rb')
     watch('config/environment.rb')
     watch('config/routes.rb')
     watch(%r{^config/environments/.+\.rb$})
     watch(%r{^config/initializers/.+\.rb$})
     watch('spec/spec_helper.rb')
   end
end

group 'changes' do # run: $ guard --group changes -n f
   guard 'bundler' do
     watch('Gemfile')
     # Uncomment next line if Gemfile contain `gemspec' command
     # watch(/^.+\.gemspec/)
   end

   guard 'annotate' do
     watch( 'db/schema.rb' )
     # Uncomment the following line if you also want to run annotate anytime
     # a model file changes
     #watch( 'app/models/**/*.rb' )
   end

   guard 'cucumber', :cli => "--drb --guess" do
     watch(%r{^features/.+\.feature$})
     watch(%r{^features/support/.+$})          { 'features' }
     watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
   end

   guard 'rspec', :version => 2, :cli => "--drb" do # I don't need the --drb here since I have it already in .rspec, but it parallels nicely with cucumber
     # watch(%r{^spec/.+_spec\.rb$})
     # watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
     # watch('spec/spec_helper.rb')  { "spec" }

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
   end
end
