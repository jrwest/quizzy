Feature: Creating Quizzes

  As a quizzy user
  I want to create quizzes
  So that other quizzy users can take them

  Background:
    Given an account "myaccount" with password "mypassword"
    And the account "myaccount" with password "mypassword" is authorized
  
  Scenario: Unauthorized User 
    Given an unauthorized account
    When I go to the Create Quiz Page
    Then I should be on the Authorization Page
  
  Scenario: Authorized User
    When I go to the Create Quiz Page
    Then I should see "Create New Quizzy"

  Scenario: Create New Quiz
    Given I am on the Create Quiz Page
    When I fill in "Quiz Name" with "My Quiz"
    And I press "Save"
    Then a quiz with name "My Quiz" and author "myaccount" should exist
    And I should be on the quiz page for "My Quiz"
    
