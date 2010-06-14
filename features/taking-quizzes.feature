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
    And I am on the Quiz Page

  Scenario: Unauthorized
    Given an unauthorized account
    When I follow "Some Quiz"
    Then I should be on the Authorization Page

  Scenario: Authorized
    When I follow "Some Quiz"
    Then I should be on the quiz page for "Some Quiz"
      
