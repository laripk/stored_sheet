module Haml::Filters::Coffee
  attr_accessor :coffee_path
  include Haml::Filters::Base

  def coffee_path
    @coffee_path || "coffee"
  end

  def render_with_options(text, options)
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
# derived from the coffee-haml-filter gem, http://github.com/aussiegeek/coffee-haml-filter
