@pg_dumpall
Feature: pg_dumpall behave tests

    Scenario: pg_dumpall -?
        #Given the database is not running
        When the user runs "pg_dumpall -?"
	Then pg_dumpall should return a return code of 0
	Then pg_dumpall should print "hdb-syntax" to stdout
	Then pg_dumpall should print "inHybrid Database" to stdout
	Then pg_dumpall should print "default if hdb" to stdout
	Then pg_dumpall should print "bugs@inspur.com" to stdout

    Scenario: pg_dumpall functional test
        Given the database is running
        When the user runs "pg_dumpall --schema-only > /tmp/result.out"
        Then the output file "/tmp/result.out" should exist
        And the output file "/tmp/result.out" should contain "inHybrid Database database dump"
        And the output file "/tmp/result.out" should contain "inHybrid Database database dump complete"
