@hdbsd
Feature: hdbsd behave tests

    Scenario: hdbsd -?
        #Given the database is not running
        When the user runs "hdbsd -?"
	Then hdbsd should return a return code of 0
	Then hdbsd should print "Usage: hdbsd" to stdout

    Scenario: hdbsd --version
        #Given the database is not running
        When the user runs "hdbsd --version"
	Then hdbsd should return a return code of 0
        Then hdbsd should print "hdbsd 1.0" to stdout
    
    Scenario: hdbsd functional test
        Given the database is running
        When the user runs "hdbsd hdbsd_db -p 6000 -U hdbadmin > /tmp/out.sql"
        Then the output file "/tmp/out.sql" should exist
        And the output file "/tmp/out.sql" should contain "inHybrid database Statistics Dump"
        And the output file "/tmp/out.sql" should contain "hdbsd hdbsd_db -p 6000 -U hdbadmin"
	And the output file "/tmp/out.sql" should contain "CREATE TABLE public.t1"
