@pg_restore
Feature: pg_restore behave tests

    Scenario: pg_restore -?
        #Given the database is not running
        When the user runs "pg_restore -?"
	Then pg_restore should return a return code of 0
	Then pg_restore should print "bugs@inspur.com" to stdout

    Scenario: pg_restore -V
        #Given the database is not running
        When the user runs "pg_restore -V"
        Then pg_restore should return a return code of 0
        Then pg_restore should print "inHybrid Database" to stdout

    Scenario: pg_restore functional test
        Given the database is running
        When the user runs "pg_dump -Ft restoredb > /tmp/restore.tar"
        Then the output file "/tmp/restore.tar" should exist
        And the user runs "pg_restore -d restoredbtest /tmp/restore.tar"
        Then pg_restore should return a return code of 0
        And the user runs "psql restoredbtest -c "\d""
        Then pg_restore should print "t1" to stdout
