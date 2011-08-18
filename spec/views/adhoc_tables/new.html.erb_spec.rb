require 'spec_helper'

describe "adhoc_tables/new.html.erb" do
  before(:each) do
    assign(:adhoc_table, stub_model(AdhocTable).as_new_record)
  end

  it "renders new adhoc_table form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adhoc_tables_path, :method => "post" do
    end
  end
end
