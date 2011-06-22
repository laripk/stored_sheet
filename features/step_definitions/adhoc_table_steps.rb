Given /^the following adhoc_tables:$/ do |adhoc_tables|
  AdhocTable.create!(adhoc_tables.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) adhoc_table$/ do |pos|
  visit adhoc_tables_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following adhoc_tables:$/ do |expected_adhoc_tables_table|
  expected_adhoc_tables_table.diff!(tableish('table tr', 'td,th'))
end
