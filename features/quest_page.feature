Feature: Quest management
  As a user
  I want to create, view, and delete quests
  So that I can manage my tasks effectively

  Background:
    Given I am on the homepage

 Scenario: Creating a new quest
  When I fill in "quest_name" with "Save the realm"
  And I press "Create Quest"
  Then I should see "Save the realm" under "My Missions"
  And I should see a success message "Quest created successfully"

Scenario: Creating a quest with empty name
  When I fill in "quest_name" with ""
  And I press "Create Quest"
  Then I should see an error message "Quest name cannot be empty"

Scenario: Creating a quest with very long name
  When I fill in "quest_name" with a 200 character string
  And I press "Create Quest"
  Then I should see an error message "Quest name is too long"

  Scenario: Completing a quest
  Given I have created a quest named "Defeat the dragon"
  And "Defeat the dragon" should be under "My Missions"
  When I check the checkbox for "Defeat the dragon"
  Then I should see "Defeat the dragon" under "Mission completed"
  And I should not see "Defeat the dragon" under "My Missions"

  Scenario: Deleting a quest with confirmation
  Given I have created a quest named "Clean the cave"
  When I press the delete button for "Clean the cave"
  And I confirm the deletion
  Then I should not see "Clean the cave"
  And I should see a success message "Quest deleted successfully"

  Scenario: Managing multiple quests
  Given I have created a quest named "Save the realm"
  And I have created a quest named "Defeat the dragon"
  When I check the checkbox for "Save the realm"
  Then I should see "Save the realm" under "Mission completed"
  And I should see "Defeat the dragon" under "My Missions"