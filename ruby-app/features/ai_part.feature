@use_selenium
Feature: AI Generated Assessment Results

Scenario: Checking the AI generated assessment results 
    Given that I would like to see the patients AI generated assessment results
    When I click on the patient assessment tab
    Then I should be able to see the Physical Video AI assessment results

Scenario: Transcribing the mental AI video 
    Given that I would like to see a transcription of the mental video assessment the patient has uploaded so I do not need to spend time watching the whole video
    When I clicked on the patient assessment tab 
    Then I should be able to see the transcription of the mental video assessment 

Scenario: Determining the mental state of the patient 
    Given that I would like to find out the mental state of the patient without watching the mental assessment video 
    When I clicks on the patient assessment tab 
    Then I should be able to see a section that says animal count, which can help me to determine the mental status of the patient based on how many animals the patient is able to list out 


#Sad path 

Scenario: Having a manual input option 
    Given that the AI asssessment results are preliminary and may be incorrect 
    When I am on the patient assessment tab 
    Then I should still be able to manually input a assessment results based on my own judgement and choose good fair or poor 
    And I should also be able to write additional comments in the assessment details section 
    And these information should be saved when I click the save button 

Scenario: Having the videos that the patients uploaded available 
    Given that the AI assessment results might be incorrect
    When I am on the patients assessment tab 
    Then I should still be able to view the original videos the patients have uploaded to verify if the AI assessment results are valid or not 
