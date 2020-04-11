@hdbreload
Feature: hdbreload tests
    Scenario: hdbreload version test
	When the user runs command "hdbreload --version"
	Then the hdbreload should print "hdbreload version 1.0.0" escaped to stdout
