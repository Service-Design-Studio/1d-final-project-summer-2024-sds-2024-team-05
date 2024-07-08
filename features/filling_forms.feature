# features/user_stories.feature

Feature: User form interactions

Scenario: Continue to next page
  Given I am on the first page of the form
  When I click the next button
  Then I should be brought to the second page of the form

Scenario: Save currently filled information
  Given I have not completed filling up the form
  When I click the save button
  When I reopen the form
  Then I should not have to re-enter the previously filled up fields

