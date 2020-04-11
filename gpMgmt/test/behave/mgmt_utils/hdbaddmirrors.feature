@hdbaddmirrors
Feature: Tests for hdbaddmirrors

    Scenario: tablespaces work
        Given the cluster is generated with "3" primaries only
          And a tablespace is created with data
         When hdbaddmirrors adds 3 mirrors
          And an FTS probe is triggered
          And the segments are synchronized
         Then verify the database has mirrors
          And the tablespace is valid

         When user stops all primary processes
          And user can start transactions
         Then the tablespace is valid
#-----------------
#version test
    Scenario: hdbaddmirror version test
         When the user runs command "hdbaddmirror --version"
         Then the hdbreload should print "hdbaddmirrors version 1.0.0" escaped to stdout
########################### @concourse_cluster tests ###########################
# The @concourse_cluster tag denotes the scenario that requires a remote cluster

    @concourse_cluster
    Scenario: hdbrecoverseg works correctly on a newly added mirror with HBA_HOSTNAMES=0
        Given a working directory of the test as '/tmp/gpaddmirrors'
        And the database is not running
        And with HBA_HOSTNAMES "0" a cluster is created with no mirrors on "mdw" and "sdw1, sdw2"
        And pg_hba file "/tmp/gpaddmirrors/data/primary/gpseg0/pg_hba.conf" on host "sdw1" contains only cidr addresses
        And hdbaddmirrors adds mirrors
        And pg_hba file "/tmp/gpaddmirrors/data/primary/gpseg0/pg_hba.conf" on host "sdw1" contains only cidr addresses
        And pg_hba file "/tmp/gpaddmirrors/data/primary/gpseg0/pg_hba.conf" on host "sdw1" contains entries for "samehost"
        Then verify the database has mirrors
        And the information of a "mirror" segment on a remote host is saved
        When user kills a "mirror" process with the saved information
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        Given a preferred primary has failed
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        When primary and mirror switch to non-preferred roles
        When the user runs "hdbrecoverseg -a -r"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        And the user runs "hdbstop -aqM fast"

    @concourse_cluster
    Scenario: hdbrecoverseg works correctly on a newly added mirror with HBA_HOSTNAMES=1
        Given a working directory of the test as '/tmp/gpaddmirrors'
        And the database is not running
        And with HBA_HOSTNAMES "1" a cluster is created with no mirrors on "mdw" and "sdw1, sdw2"
        And pg_hba file "/tmp/gpaddmirrors/data/primary/gpseg0/pg_hba.conf" on host "sdw1" contains entries for "mdw, sdw1"
        And hdbaddmirrors adds mirrors with options "--hba-hostnames"
        And pg_hba file "/tmp/gpaddmirrors/data/primary/gpseg0/pg_hba.conf" on host "sdw1" contains entries for "mdw, sdw1, sdw2, samehost"
        Then verify the database has mirrors
        And the information of a "mirror" segment on a remote host is saved
        When user kills a "mirror" process with the saved information
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        Given a preferred primary has failed
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        When primary and mirror switch to non-preferred roles
        When the user runs "hdbrecoverseg -a -r"
        Then hdbrecoverseg should return a return code of 0
        And all the segments are running
        And the segments are synchronized
        And the user runs "hdbstop -aqM fast"

    @concourse_cluster
    Scenario: hdbaddmirrors puts mirrors on the same hosts when there is a standby configured
        Given a working directory of the test as '/tmp/gpaddmirrors'
        And the database is not running
        And a cluster is created with no mirrors on "mdw" and "sdw1, sdw2, sdw3"
        And hdbaddmirrors adds mirrors
        Then verify the database has mirrors
        And save the gparray to context
        And the database is not running
        And a cluster is created with no mirrors on "mdw" and "sdw1, sdw2, sdw3"
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And hdbaddmirrors adds mirrors
        Then mirror hostlist matches the one saved in context
        And the user runs "hdbstop -aqM fast"

    @concourse_cluster
    Scenario: hdbaddmirrors puts mirrors on different host
        Given a working directory of the test as '/tmp/gpaddmirrors'
        And the database is not running
        And a cluster is created with no mirrors on "mdw" and "sdw1, sdw2, sdw3"
        And hdbaddmirrors adds mirrors in spread configuration
        Then verify that mirror segments are in "spread" configuration
        And the user runs "hdbstop -aqM fast"

    @concourse_cluster
    Scenario: hdbaddmirrors with a default master data directory
        Given a working directory of the test as '/tmp/gpaddmirrors'
        And the database is not running
        And a cluster is created with no mirrors on "mdw" and "sdw1"
        And hdbaddmirrors adds mirrors
        Then verify the database has mirrors
        And the user runs "hdbstop -aqM fast"

    @concourse_cluster
    Scenario: hdbaddmirrors with a given master data directory [-d <master datadir>]
        Given a working directory of the test as '/tmp/gpaddmirrors'
        And the database is not running
        And a cluster is created with no mirrors on "mdw" and "sdw1"
        And hdbaddmirrors adds mirrors with temporary data dir
        Then verify the database has mirrors
        And the user runs "hdbstop -aqM fast"

    @concourse_cluster
    Scenario: hdbaddmirrors mirrors are recognized after a cluster restart
        Given a working directory of the test as '/tmp/gpaddmirrors'
        And the database is not running
        And a cluster is created with no mirrors on "mdw" and "sdw1"
        When hdbaddmirrors adds mirrors
        Then verify the database has mirrors
        When an FTS probe is triggered
        And the user runs "hdbstop -a"
        And wait until the process "hdbstop" goes down
        And the user runs "hdbstart -a"
        And wait until the process "hdbstart" goes down
        Then all the segments are running
        And the segments are synchronized
        And the user runs "hdbstop -aqM fast"

    @concourse_cluster
    Scenario: hdbaddmirrors when the primaries have data
        Given a working directory of the test as '/tmp/gpaddmirrors'
        And the database is not running
        And a cluster is created with no mirrors on "mdw" and "sdw1"
        And database "gptest" exists
        And there is a "heap" table "public.heap_table" in "gptest" with "100" rows
        And there is a "ao" table "public.ao_table" in "gptest" with "100" rows
        And there is a "co" table "public.co_table" in "gptest" with "100" rows
        And hdbaddmirrors adds mirrors with temporary data dir
        And an FTS probe is triggered
        And the segments are synchronized
        When user stops all primary processes
        And user can start transactions
        Then verify that there is a "heap" table "public.heap_table" in "gptest" with "100" rows
        Then verify that there is a "ao" table "public.ao_table" in "gptest" with "100" rows
        Then verify that there is a "co" table "public.co_table" in "gptest" with "100" rows
        And the user runs "hdbstop -aqM fast"

    @concourse_cluster
    Scenario: tablespaces work on a multi-host environment
        Given a working directory of the test as '/tmp/gpaddmirrors'
          And the database is not running
          And a cluster is created with no mirrors on "mdw" and "sdw1"
          And a tablespace is created with data
         When hdbaddmirrors adds mirrors
         Then verify the database has mirrors

         When an FTS probe is triggered
          And the segments are synchronized
         Then the tablespace is valid

         When user stops all primary processes
          And user can start transactions
         Then the tablespace is valid
