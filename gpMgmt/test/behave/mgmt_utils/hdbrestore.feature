@hdbrestore
Feature: hdbrestore behave tests
    Scenario: hdbrestore --help
        #Given the database is not running
        When the user runs "hdbrestore --help > /tmp/hdbrestore.output"
        Then hdbrestore should return a return code of 0
	Then the output file "/tmp/hdbrestore.output" should contain "hdbrestore is the parallel restore utility for HDB"
	Then the output file "/tmp/hdbrestore.output" should contain "hdbrestore [flags]"
	Then the output file "/tmp/hdbrestore.output" should contain "Help for hdbrestore"

    Scenario: hdbrestore --version
        #Given the database is not running
        When the user runs "hdbrestore --version"
        Then hdbrestore should return a return code of 0
        Then hdbrestore should print "hdbrestore version 1.17.0.*" to stdout

    Scenario: hdbrestore functional test
        Given the database is running
	When the user runs "hdbrestore --backup-dir /tmp/hdbrestore/data --timestamp 20200421120742 --create-db > /tmp/hdbrestore.output"
        Then hdbrestore should return a return code of 0
	Then the output file "/tmp/hdbrestore.output" should contain "hdb_email_contacts"
	Then the output file "/tmp/hdbrestore.output" should contain "hdbrestore_"
	Then the output file "/tmp/hdbrestore.output" should contain "Email containing hdbrestore report"
        And the user runs "hdbrestore --backup-dir /tmp/hdbrestore/data --timestamp 20200421120742 --create-db > /tmp/hdbrestore.output"
	Then the output file "/tmp/hdbrestore.output" should contain "Run hdbrestore again without"
