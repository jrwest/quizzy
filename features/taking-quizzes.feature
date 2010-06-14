Feature: Taking Quizzes

  As a quizzy quiz take
  I want to take a quiz
  So I can see just how smart I am

  Background:
    Given an account "myaccount" with password "mypassword"
    And the account "myaccount" with password "mypassword" is authorized
    And a quiz "Some Quiz" with author "someaccount" and questions:
      | text          | answer |
      | Question 1    | true   |
      | Question 2    | false  |
      | Question 3    | false  |
      | Question 4    | true   |
      | Question 5    | true   |
    And I am on the Quizzes Page

  Scenario: Unauthorized
    Given an unauthorized account
    And I am on the Quizzes Page
    When I follow "Some Quiz"
    Then I should be on the Authorization Page

  Scenario: Authorized
    When I follow "Some Quiz"
    Then I should be on the quiz page for "Some Quiz"

  Scenario: Getting All Questions Correct
    Given I am on the quiz page for "Some Quiz"
    When I answer "true,false,false,true,true"
    And I press "Score"
    Then I should be on the Score Page
    And I should see "Your Score for Some Quiz"
    And I should see "5/5 (100%)"
    And I should see "Correct Answers to Questions 1, 2, 3, 4, 5"
    And I should not see "Wrong Answers"

  Scenario: Getting Some Questions Wrong and Some Correct
    Given I am on the quiz page for "Some Quiz"
    When I answer "true,true,false,true,false"
    And I press "Score"
    Then I should be on the Score Page
    And I should see "Your Score for Some Quiz"
    And I should see "3/5 (60%)"
    And I should see "Correct Answers to Questions 1, 3, 4"
    And I should see "Wrong Answers to Questions 2, 5"

  Scenario: Getting All Questions Wrong
    Given I am on the quiz page for "Some Quiz"
    When I answer "false,true,true,false,false"
    And I press "Score"
    Then I should be on the Score Page
    And I should see "Your Score for Some Quiz"
    And I should see "0/5 (0%)"
    And I should see "Wrong Answers to Questions 1, 2, 3, 4, 5"
