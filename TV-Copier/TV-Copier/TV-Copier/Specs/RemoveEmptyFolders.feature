Feature: Remove Empty Folders
	As a user of a collection of media files
	I want any empty folders in my collection automatically removed
	so that I don't have to manually remove them

Scenario: Remove an empty folder
	Given A directory "Target" with a folder "The Walking Dead (1)" that has 0 media files
	When the maintenance process runs
	Then the folder "The Walking Dead (0)" should be removed
