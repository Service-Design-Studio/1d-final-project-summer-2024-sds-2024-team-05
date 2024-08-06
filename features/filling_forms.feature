# features/user_stories.feature

Feature: User form interactions

Scenario: Continue to next page
  Given I have signed up and login to my account
  When I create a new form
  When I click the next button
  Then I should be brought to the second page of the form

Scenario: Save currently filled information
  Given I have not completed filling up the form
  When I click the save button
  When I reopen the form
  Then I should not have to re-enter the previously filled up fields

Scenario: Going to a specific page in the form 
  Given that I would like to go to a specific page in the form 
  When I click on page number "4"
  Then I should be brought to page 4 of the form

Scenario: Incomplete Page 
  Given that I missed filling up a field on one page 
  When I move on to the next page 
  Then I should see the page header of the page with unfilled information be highlighted in red

Scenario: Submitting the form 
  Given that I have submitted the form 
  When I am in the main user dashboard
  And I should see the word submitted
  Then I cannot edit or delete the form further