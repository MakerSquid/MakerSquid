Feature: Addition
	As a watcher of downloaded TV content
	I want files that have finished downloading to be copied to a specific folder based on the name of the file
	so that I don't have to do that manually.

Scenario: Copy Downloaded Episode
	Given the file V.(2009).S02E04.filename.avi has just finished downloading
	When the file copier runs
	Then the file "Target\V (2009) (2)\V.(2009).S02E04.filename.avi" will exist
