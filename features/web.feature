Feature: Cucumber Web Testing
  In order to make sure the test suite is working
  as a developer
  I want to see that Cucumber can open a browser

  Scenario: Google Search
    Given I am on the Google homepage
    When I search for "Sinatra Cucumber Template"
    Then I should see the search results

