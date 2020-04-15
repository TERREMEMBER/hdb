@pg_dump
Feature: pg_dump behave tests

    Scenario: pg_dump -?
        #Given the database is not running
        When the user runs "pg_dump -?"
	Then pg_dump should return a return code of 0
	Then pg_dump should print "hdb-syntax" to stdout
	Then pg_dump should print "inHybrid Database" to stdout
	Then pg_dump should print "default if hdb" to stdout
	Then pg_dump should print "bugs@inspur.com" to stdout

    Scenario: pg_dump functional test
        Given the database is running
        When the user runs "pg_dump postgres > /tmp/result.out"
        Then the output file "/tmp/result.out" should exist
        And the output file "/tmp/result.out" should contain "inHybrid Database database dump"
        And the output file "/tmp/result.out" should contain "inHybrid Database database dump complete"
