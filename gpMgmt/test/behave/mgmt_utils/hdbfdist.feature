@hdbfdist
Feature: hdbfdist version tests

    Scenario: hdbload data test
	When the user runs command "hdbfdist --version"
	Then hdbfdist should print "hdbfdist version \"1.0.0" to stdout
