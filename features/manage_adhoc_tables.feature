Feature: Manage adhoc_tables
  In order to create tables easily
  As a researcher
  I want to just type up a table
  
  Scenario: Name a new adhoc_table
    Given I am on the new adhoc_table page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1"


