Feature: Dashboard

Scenario: Staff is looking for a specific patients form
    Given that a NOK has successfully submitted a form
    And I am a staff and I am in the staff dashboard looking for a specific patient form
    When I type in the patient name or the NOK name
    And I click the search button 
    Then I should only see the form of the patient or the NOK with that specific name being listed out 

Scenario: Staff is done looking for a specific patients form and wants to go back to the main dashboard 
    Given that a NOK has submitted a form
    And I am a staff and I am done looking for a specific patients form
    When I click the clear button
    Then I should be brought back to the main dashboard with all the forms 

Scenario: Staff wants to sort the forms by patient names 
    Given that multiple NOKs has submitted forms 
    And I am a staff and I want to sort all the forms i have by alphabatical order of the patient name
    When I click the sort checkbox next to patient name 
    Then I should see that all the patient names have been sorted in alphabatical order

Scenario: Staff wants to sort the forms by address
    Given that different NOKs has submitted forms 
    And I am a staff and I want to sort all the forms i have by alphabatical order of the address of the patient 
    When I click the sort checkbox next to address
    Then I should see that all the address have been sorted in alphabatical order

Scenario: Staff wants to sort the forms 
    Given that many NOKs has submitted forms 
    And I am a staff and I want to sort all the forms i have by earliest start date or end date
    When I click the sort checkbox next to start date or end date
    Then I should see that all the address have been sorted by earliest start date or end date 

Scenario: Staff wants to filter the forms
    Given that NOKs has submitted forms
    And I am a staff and I want to sort all the forms i have by male or female patients 
    When I click the M checkbox next to gender 
    Then I should see all the male patients appear above the female patients 

#Sad Path 
Scenario: Staff is unable to identify which forms have just been submitted and which forms have been submitted for some time
    Given that I am a staff and I cannot differentiate between the new forms that have just been submitted recently and the older forms that have been submitted some time ago 
    When a new form has just been submitted by the NOK
    Then I should see the words “New Changes Made!” under the patients name 


#Sad Path 
Scenario: NOK has filled up their forms wrongly after submitting or does not know how to fill up 
    Given that NOK has filled up their forms wrongly after submitting or does not know how to fill up 
    And I am a staff and I want to help a NOK edit their form on their behalf as they filled in the forms wrongly or does not know how to fill up 
    When I click on the edit button of the patient’s form on the staff dashboard 
    And I make the necessary edits i need to the form 
    And I click save and exit out of the form 
    Then my changes should be saved 

#Sad Path 
Scenario: Staff wants to find information from the patient’s form but does not know which page it is on and has to click through multiple pages
    Given that I am a staff and I want to find information but I do not know which page the information is on
    When I click the summary button on the dashboard 
    Then I should see a summary of all the information the patient has filled up in their forms and can find the information at once