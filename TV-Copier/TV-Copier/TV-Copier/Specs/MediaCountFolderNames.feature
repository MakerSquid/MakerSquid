Feature: Folder Naming
	As a user of a collection of media files
	I want the number of media items in a particular folder to be part of the folder name
	so that I can see at a glance if I have something to watch

Scenario: Change Folder Name
	Given A directory "Target" with a folder "The Office (US) (2)" that has 3 media files
	When the maintenance process runs
	Then the folder name should be "The Office (US) (3)"
