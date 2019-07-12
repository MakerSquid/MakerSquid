Feature: File Copy Target Folder Naming
	As a watcher of downloaded TV content
	I want downloaded files to use a destination folder name based on the incoming file's series name
	so that I don't end up with a bunch of crappy folder names

Scenario: Folder Name is Found
	Given a defined list of series folders
	When I request the target folder for a file named "The.Office.S01E03.filename.avi"
	Then the result should be "The Office (US)"
	
Scenario: Folder Name is not Found
	Given a defined list of series folders
	When I request the target folder for a file named "The Friendly Ghost - S01E02 - filename.avi"
	Then the result should be "The Friendly Ghost"

Scenario: Show is Date Stamped
	Given a defined list of series folders
	When I request the target folder for a file named "Craig Ferguson - 2010/12/30 - Katy Perry - filename.avi"
	Then the result should be "The Late Late Show with Craig Ferguson"

Scenario: Show is Date Stamped (Variation 1)
	Given a defined list of series folders
	When I request the target folder for a file named "Craig Ferguson - 12/30/2010 - Katy Perry - filename.avi"
	Then the result should be "The Late Late Show with Craig Ferguson"

Scenario: Show is Date Stamped (Variation 2)
	Given a defined list of series folders
	When I request the target folder for a file named "Craig Ferguson - 12/2010 - Katy Perry - filename.avi"
	Then the result should be "The Late Late Show with Craig Ferguson"

Scenario: Show is Date Stamped (Variation 3)
	Given a defined list of series folders
	When I request the target folder for a file named "Craig.Ferguson.12/30/2010.Katy.Perry.filename.avi"
	Then the result should be "The Late Late Show with Craig Ferguson"

Scenario: Show is Date Stamped (Variation 4)
	Given a defined list of series folders
	When I request the target folder for a file named "Craig.Ferguson.2010/12/30.Katy.Perry.filename.avi"
	Then the result should be "The Late Late Show with Craig Ferguson"

Scenario: Show has Old School Numbering
	Given a defined list of series folders
	When I request the target folder for a file named "The.Office.4x02.filename.avi"
	Then the result should be "The Office (US)"

Scenario: Show has Old School Numbering (Variation 1)
	Given a defined list of series folders
	When I request the target folder for a file named "The.Office.04x02.filename.avi"
	Then the result should be "The Office (US)"

Scenario: Show has Old School Numbering (Variation 2)
	Given a defined list of series folders
	When I request the target folder for a file named "The.Office.10x02.filename.avi"
	Then the result should be "The Office (US)"

Scenario: Show has Old School Numbering (Variation 3)
	Given a defined list of series folders
	When I request the target folder for a file named "The.Office.10x2.filename.avi"
	Then the result should be "The Office (US)"

Scenario: Show has Old School Numbering (Variation 4)
	Given a defined list of series folders
	When I request the target folder for a file named "The.Office.1x2.filename.avi"
	Then the result should be "The Office (US)"
