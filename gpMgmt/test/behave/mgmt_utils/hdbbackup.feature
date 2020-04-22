@hdbbackup
Feature: hdbbackup behave tests

    Scenario: hdbbackup --help
        #Given the database is not running
        When the user runs "hdbbackup --help > /tmp/hdbbackup.output"
	Then hdbbackup should return a return code of 0
	Then the output file "/tmp/hdbbackup.output" should contain "hdbbackup is the parallel backup utility for HDB"
	Then the output file "/tmp/hdbbackup.output" should contain "hdbbackup [flags]"
	Then the output file "/tmp/hdbbackup.output" should contain "Help for hdbbackup"

    Scenario: hdbbackup --version
        #Given the database is not running
        When the user runs "hdbbackup --version"
        Then hdbbackup should return a return code of 0
        Then hdbbackup should print "hdbbackup version 1.17.0.*" to stdout

    Scenario: hdbbackup functional test
        Given the database is running
	When the user runs "hdbbackup --backup-dir /tmp/hdbbackup/data --dbname hdbbackupdb > /tmp/hdbbackup.output"
	#        Then the output file "/tmp/mybak/*" should existi
        Then hdbbackup should return a return code of 0
	Then the output file "/tmp/hdbbackup.output" should contain "hdb_email_contacts"
	Then the output file "/tmp/hdbbackup.output" should contain "hdbbackup_"
	Then the output file "/tmp/hdbbackup.output" should contain "Email containing hdbbackup report"
