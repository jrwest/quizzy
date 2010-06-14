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
    And I should see "My Quiz"
    And I should see "0 questions"

  Scenario: Edit Quiz by Authorized User
    Given a quiz "My Quiz" with author "myaccount"
    And I am on the quiz page for "My Quiz"
    When I follow "new question"
    Then I should be on the Create Question Page for "My Quiz"
    And I should see "Add Question to My Quiz"
    
  Scenario: Add Questions to Quiz
    Given a quiz "My Quiz" with author "myaccount"
    And I am on the quiz page for "My Quiz"
    When I follow "new question"
    And I fill in "Question" with "This is a first true/false question?"
    And I choose "true"
    And I press "Save"
    Then I should be on the quiz page for "My Quiz"
    And I should see "1 question"
    And I should see "This is a first true/false question?"
    When I follow "new question"
    And I fill in "Question" with "This is a second true/false question?"
    And I choose "false"
    And I press "Save"
    Then I should be on the quiz page for "My Quiz"
    And I should see "2 questions"
    And I should see "This is a second true/false question?"
