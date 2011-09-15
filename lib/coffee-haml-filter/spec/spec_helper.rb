$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'haml'
require 'haml/filters/coffee'

require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  
end

def read_fixture(filename)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', filename))
end

#hack around haml dependency on String#blank? method
class String
  def blank?
    self == ""
  end
end