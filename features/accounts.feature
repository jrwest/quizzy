Feature Name:

   As a quizzy user
   I want an account
   So that I can create and take quizzes

   Scenario: Account Creation Page
     Given I am on the homepage
     When I follow "Create New Account"
     Then I should be the Create New Account Page
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
