@use_selenium
Feature: Video Analysis

Scenario: Play Example Video
  Given I am filling out a new form
  When I go to the second page
  When I am on the second page and want to go to the video analysis page
  And I want to view the example video
  When I click the play button on the example video
  Then the example video will start playing

@use_selenium
Scenario: Preview Uploaded Video
  Given I am on the video analysis page 
  And I upload a video
  When I click the play button on the uploaded video 
  Then the uploaded video will start playing 