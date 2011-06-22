Feature: Manage adhoc_tables
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new adhoc_table
    Given I am on the new adhoc_table page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1"

  Scenario: Delete adhoc_table
    Given the following adhoc_tables:
      |name|
      |name 1|
      |name 2|
      |name 3|
      |name 4|
    When I delete the 3rd adhoc_table
    Then I should see the following adhoc_tables:
      |Name|
      |name 1|
      |name 2|
      |name 4|
