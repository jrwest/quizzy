Feature: Accounts

  As a quizzy user
  I want an account
  So that I can create and take quizzes

  Scenario: Account Creation Page
    Given I am on the homepage
    When I follow "Create New Account"
    Then I should be on the Create New Account Page
    And I should see "Create New Account"
    
  Scenario: Create Valid Account
    Given I am on the Create New Account Page
    When I fill in the following:
      | Account Name     | jrwest     |
      | Password         | mypassword |
      | Confirm Password | mypassword |
    And I press "Create"
    Then an account should exist with name "jrwest"

  @undefined_scenario
  Scenario: Create Invalid Account (Non-Matching Passwords)
     
  @undefined_scenario
  Scenario: Create Invalid Account (Existing Username)

  Scenario: Authorization Page
    And I am on the homepage
    When I follow "Log In"
    Then I should be on the Authorization Page
    And I should see "Log Into Quizzy"

  Scenario: Authorization (Valid)
    Given an account "myaccount" with password "mypassword"
    And I am on the Authorization Page
    When I fill in the following:
      | username | myaccount  |
      | password | mypassword |
    And I press "Log In"
    Then I should be on the Quizzes Page
