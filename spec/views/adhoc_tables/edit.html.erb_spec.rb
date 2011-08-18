require 'spec_helper'

describe "adhoc_tables/edit.html.erb" do
  before(:each) do
    @adhoc_table = assign(:adhoc_table, stub_model(AdhocTable))
  end

  it "renders the edit adhoc_table form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adhoc_tables_path(@adhoc_table), :method => "post" do
    end
  end
end
