Feature: Viewing Quizzes

  As a quizzy quiz taker
  I want to view a list of quizzes
  So that I can take one

  Background:
    Given I am on the homepage

  Scenario: No Quizzes Exist
    Given no quizzes exist
    When I follow "View Quizzes"
    Then I should see "There are currently 0 quizzes"

  Scenario: One Quiz Exists
    Given a quiz "My First Quiz" 
    When I follow "View Quizzes"
    Then I should see "There is currently 1 quiz"
    And I should see "My First Quiz"

  Scenario: Multiple Quizzes Exist
    Given the quizzes:
      | name           |
      | My First Quiz  |
      | My Second Quiz |
      | My Third Quiz  |
    When I follow "View Quizzes"
    Then I should see "There are currently 3 quizzes"
    And I should see "My First Quiz"
    And I should see "My Second Quiz"
    And I should see "My Third Quiz"

