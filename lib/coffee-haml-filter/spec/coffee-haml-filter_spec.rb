require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CoffeeHamlFilter" do
  it "should render valid coffeescript" do
    template = read_fixture('win.haml')
    engine = Haml::Engine.new(template)
    rendered = engine.render
    rendered.should == "<script type='text/javascript'>\n  //<![CDATA[\n    (function(){\n  alert('Win!');\n})();\n\n  //]]>\n</script>\n"
  end

  it "should show errors for invalid coffee script" do
    template = read_fixture('invalid.haml')
    lambda { Haml::Engine.new(template) }.should raise_error(SyntaxError)
  end

  describe "setup" do
    describe "default path" do
      it "should have the correct path" do
        Haml::Filters::Coffee.coffee_path.should == "coffee"
      end

      it "should generate popen args" do
        Haml::Filters::Coffee.popen_args.should == ["coffee", "-sc"]
      end
    end

    describe "should change the path if requested" do
      before do
        Haml::Filters::Coffee.coffee_path = "/usr/local/bin/node /usr/local/bin/coffee"
      end
      it "should update coffee path" do
        Haml::Filters::Coffee.coffee_path.should == "/usr/local/bin/node /usr/local/bin/coffee"
      end

      it "should generate popen args" do
        Haml::Filters::Coffee.popen_args.should == ["/usr/local/bin/node", "/usr/local/bin/coffee -sc"]
      end
    end
  end
end
