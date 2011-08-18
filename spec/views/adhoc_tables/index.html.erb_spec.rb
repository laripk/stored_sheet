require 'spec_helper'

describe "adhoc_tables/index.html.erb" do
  before(:each) do
    assign(:adhoc_tables, [
      stub_model(AdhocTable),
      stub_model(AdhocTable)
    ])
  end

  it "renders a list of adhoc_tables" do
    render
  end
end
