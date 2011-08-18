require 'spec_helper'

describe "adhoc_tables/show.html.erb" do
  before(:each) do
    @adhoc_table = assign(:adhoc_table, stub_model(AdhocTable))
  end

  it "renders attributes in <p>" do
    render
  end
end
