@hdbmovemirrors
Feature: Tests for hdbmovemirrors

    @hdbmovemirrors1
    Scenario: hdbmovemirrors fails with totally malformed input file
        Given a standard local demo cluster is running
        And a hdbmovemirrors directory under '/tmp/hdbmovemirrors' with mode '0700' is created
        And a 'malformed' hdbmovemirrors file is created
        When the user runs hdbmovemirrors
        Then hdbmovemirrors should return a return code of 3

    @hdbmovemirrors2
    Scenario: hdbmovemirrors fails with bad host in input file
        Given a standard local demo cluster is running
        And a hdbmovemirrors directory under '/tmp/hdbmovemirrors' with mode '0700' is created
        And a 'badhost' hdbmovemirrors file is created
        When the user runs hdbmovemirrors
        Then hdbmovemirrors should return a return code of 3

    @hdbmovemirrors3
    Scenario: hdbmovemirrors fails with invalid option parameter
        Given a standard local demo cluster is running
        And a hdbmovemirrors directory under '/tmp/hdbmovemirrors' with mode '0700' is created
        And a 'good' hdbmovemirrors file is created
        When the user runs hdbmovemirrors with additional args "--invalid-option"
        Then hdbmovemirrors should return a return code of 2

    @hdbmovemirrors4
    Scenario: hdbmovemirrors can change the location of mirrors within a single host
        Given a standard local demo cluster is created
        And a hdbmovemirrors directory under '/tmp/hdbmovemirrors' with mode '0700' is created
        And a 'good' hdbmovemirrors file is created
        When the user runs hdbmovemirrors
        Then hdbmovemirrors should return a return code of 0
        And verify the database has mirrors
        And all the segments are running
        And the segments are synchronized
        And verify that mirrors are recognized after a restart

    @hdbmovemirrors5
    Scenario: hdbmovemirrors can change the port of mirrors within a single host
        Given a standard local demo cluster is created
        And a hdbmovemirrors directory under '/tmp/hdbmovemirrors' with mode '0700' is created
        And a 'samedir' hdbmovemirrors file is created
        When the user runs hdbmovemirrors
        Then hdbmovemirrors should return a return code of 0
        And verify the database has mirrors
        And all the segments are running
        And the segments are synchronized
        And verify that mirrors are recognized after a restart

    @hdbmovemirrors6
    Scenario: hdbmovemirrors gives a warning when passed identical attributes for new and old mirrors
        Given a standard local demo cluster is created
        And a hdbmovemirrors directory under '/tmp/hdbmovemirrors' with mode '0700' is created
        And a 'identicalAttributes' hdbmovemirrors file is created
        When the user runs hdbmovemirrors
        Then hdbmovemirrors should return a return code of 0
	And hdbmovemirrors should print a "request to move a mirror with identical attributes" warning
	And verify the database has mirrors
        And all the segments are running
        And the segments are synchronized
        And verify that mirrors are recognized after a restart

    @hdbmovemirrors7
    Scenario: tablespaces work
        Given a standard local demo cluster is created
          And a tablespace is created with data
          And a hdbmovemirrors directory under '/tmp/hdbmovemirrors' with mode '0700' is created
          And a 'good' hdbmovemirrors file is created
         When the user runs hdbmovemirrors
         Then hdbmovemirrors should return a return code of 0
          And verify the database has mirrors
          And all the segments are running
          And the segments are synchronized
          And verify that mirrors are recognized after a restart
          And the tablespace is valid

########################### @concourse_cluster tests ###########################
# The @concourse_cluster tag denotes the scenario that requires a remote cluster

    @hdbmovemirrors8
    @concourse_cluster
    Scenario: hdbmovemirrors can change from group mirroring to spread mirroring
        Given verify that mirror segments are in "group" configuration
        And pg_hba file "/home/hdbadmin/gpdata/data0/primary/gpseg0/pg_hba.conf" on host "sdw1" contains only cidr addresses
        And a sample hdbmovemirrors input file is created in "spread" configuration
        When the user runs "hdbmovemirrors --input=/tmp/hdbmovemirrors_input_spread"
        Then hdbmovemirrors should return a return code of 0
        # Verify that mirrors are functional in the new configuration
        Then verify the database has mirrors
        And all the segments are running
        And the segments are synchronized
        And verify that mirror segments are in "spread" configuration
        And verify that mirrors are recognized after a restart
        And pg_hba file "/home/hdbadmin/gpdata/data0/primary/gpseg0/pg_hba.conf" on host "sdw1" contains only cidr addresses
        And the information of a "mirror" segment on a remote host is saved
        When user kills a "mirror" process with the saved information
        And an FTS probe is triggered
        And user can start transactions
        Then the saved "mirror" segment is marked down in config
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        And the information of the corresponding primary segment on a remote host is saved
        When user kills a "primary" process with the saved information
        And user can start transactions
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        When primary and mirror switch to non-preferred roles
        When the user runs "hdbrecoverseg -a -r"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized

    @hdbmovemirrors9
    @concourse_cluster
    Scenario: hdbmovemirrors can change from spread mirroring to group mirroring
        Given verify that mirror segments are in "spread" configuration
        And a sample hdbmovemirrors input file is created in "group" configuration
        When the user runs "hdbmovemirrors --input=/tmp/hdbmovemirrors_input_group --hba-hostnames"
        Then hdbmovemirrors should return a return code of 0
        # Verify that mirrors are functional in the new configuration
        Then verify the database has mirrors
        And all the segments are running
        And the segments are synchronized
        #hdbmovemirrors_input_group moves mirror on sdw3 to sdw2, corresponding primary should now have sdw2 entry
        And pg_hba file "/home/hdbadmin/gpdata/data0/primary/gpseg0/pg_hba.conf" on host "sdw1" contains entries for "sdw2"
        And verify that mirror segments are in "group" configuration
        And verify that mirrors are recognized after a restart
        And the information of a "mirror" segment on a remote host is saved
        When user kills a "mirror" process with the saved information
        And an FTS probe is triggered
        And user can start transactions
        Then the saved "mirror" segment is marked down in config
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        And the information of the corresponding primary segment on a remote host is saved
        When user kills a "primary" process with the saved information
        And user can start transactions
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        When primary and mirror switch to non-preferred roles
        When the user runs "hdbrecoverseg -a -r"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized

    @hdbmovemirrors10
    @concourse_cluster
    Scenario: tablespaces work on a multi-host environment
        Given verify that mirror segments are in "group" configuration
          And a tablespace is created with data
          And a sample hdbmovemirrors input file is created in "spread" configuration
         When the user runs "hdbmovemirrors --input=/tmp/hdbmovemirrors_input_spread"
         Then hdbmovemirrors should return a return code of 0
          And verify the database has mirrors
          And all the segments are running
          And the segments are synchronized
          And verify that mirrors are recognized after a restart
          And the tablespace is valid
         When user stops all primary processes
          And user can start transactions
         Then the tablespace is valid
