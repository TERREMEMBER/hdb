@hdbreload
Feature: hdbreload tests
    Scenario: hdbreload version test
	When the user runs command "hdbreload --version"
	Then the hdbreload should print "hdbreload version 1.0.0+dev.7.gab9df84657 build dev" escaped to stdout
