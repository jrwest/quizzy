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
