@use_selenium

Feature: Individual Client Profile Page 

#Feature 1: Client info page 

#Happy path 

Scenario: Seeing patient information in client information page
    Given that I would like to view a specific client information
    When I click on the individual client row
    Then a page will appear showing the client profile with key information

#Sad path 

Scenario: Writing the wrong information of the client in the client profile page
    Given that I am in the client profile page and I realized there are wrong information of the client on the profile page
    When I click on the edit button in the client profile page
    And I make the changes I need
    When I click save and back
    Then the changes should be applied and saved and now updated to the new version 

Scenario: Accidentally clicking the edit button without changing anything 
    Given that I am in the client profile page
    And I accidentally click on the edit button when I do not intend to make a change
    When I click back without clicking save
    Then no changes would be applied and the information would be as per before I click the edit button

#Feature 2: Patient Assessment page 

#Sad path

Scenario: Forgetting to fill in the patient assessment form 
    Given that I am on the client profile page and have forgotten to look through the videos and fill in the patient asessment 
    Then I should see the Patient Assessment tab show up as red color

#Happy Path 

Scenario: Deciding on the outcome of the assessment
    Given that I am in the process of assessing the physical mental and encironmental assessment of the patient
    When I click on either good fair or poor
    And I clicks the button save
    Then I should see that the assessment I made earlier should be saved
 
Scenario: Needing to describe the patient in more words other than just simply good fair or poor
    Given that I am assessing the patient and I need to describe the patient in more words other than just simply good fair or poor
    When I write the information I want to write in the Physical Mental or Environment Assessment Detail box
    When I clicked the save button
    Then I should be able to see that the Physical Assessment states the information I wrote

#Sad path


Scenario: Writing the wrong information 
    Given that I am on the patient asessment tab and I realized that I have assessed the patients physical,mental or environment wrong and need to change my assessment 
    When I make the necessary changes 
    And I click save button 
    Then I should see my changes being saved 

#Feature 4: NOK details

#Happy path

Scenario: Looking for NOKs contact information
    Given that I want to know what is the NOKs contact information
    When I am in the client profile page and I click on the tab NOK Details
    Then I should be able to see the details of the NOK 


#Feature 3: Meeting Details 

#Happy Path 

Scenario: Being able to access the Meeting Details page
    Given that I have finished assessing the physical, mental and environmental of the patient
    And when I click on the meeting details page
    Then I should see a calendar

Scenario: Setting a meeting in the meeting details page
    Given that I want to set a meeting in the meeting details page
    When I fill up the description, location, start time and end time
    And I click the create meeting button
    Then I should see that meeting was successfully created by seeing the patient name and the timing of the meeting on the calendar

Scenario: Using the calendar
    Given that I want to see the next month in the calendar, when I click the button Next
    Then I should be brought to the next month in the calendar  
 
Scenario: Using the calendar
    Given that I want to see the previous month in the calendar, when I click the button Previous
    Then I should be brought to the previous month

Scenario: Details of other patients 
    Given that I am on a individual client profile meeting date page and I want to check other clients previously already set meeting details 
    When I click on their meeting details on the calendar 
    Then I should be able to see their meeting details even though I am not in the overall calendar page nor am I in that specific client that I was checking on page 

#Sad path 

Scenario: Far away from the current date in the calendar
    Given that I have clicked on other months and I am not on the current month in the calendar, when I click the button Today
    Then I should be brought back to the current month from any month I was at.


#Feature 5: Upload Service agreement form 

#Sad path 
Scenario: Forgetting to upload service agreement form after meeting 
    Given that I am in the client profile and I have the signed service agreement form but have not uploaded or forgotten to upload it 
    Then I should see the Service Agreement tab turn red color

#Happy Path 

Scenario: Uploading the service agreement form
    Given that I have the signed service agreement form after meeting the patient and I am in the client profile page and wish to upload it
    When I click on the service agreement tab
    And I click choose file on the tab and upload the service agreement form
    And I click save
    Then I should see the words service agreement preview and see a pdf preview of the service agreement I have uploaded indicating that the service agreement form has been uploaded successfully
 

 

