module Haml::Filters::Coffee
  attr_accessor :coffee_path
  include Haml::Filters::Base

  lazy_require 'open3'

  def coffee_path
    @coffee_path || "coffee"
  end

  # def popen_args
  #   bin, args = coffee_path.split(' ')
  #   if args
  #     args << " -sc"
  #   else
  #     args = "-sc"
  #   end
  # 
  #   [bin, args]
  # end

  def render_with_options(text, options)
    # bin, path = popen_args
    # js, error = Open3.popen3(bin, path) do |i,o,e|
    #   i << text
    #   i.close
    #   [o.read, e.read]
    # end
    # raise SyntaxError, error unless error.blank?
    
    # begin
    js = CoffeeScript.compile(text)
    # rescue CoffeeScript::CompilationError
    
    <<RTNVAL
<script type=#{options[:attr_wrapper]}text/javascript#{options[:attr_wrapper]}>
  //<![CDATA[
    #{js}
  //]]>
</script>
RTNVAL
  end
end
