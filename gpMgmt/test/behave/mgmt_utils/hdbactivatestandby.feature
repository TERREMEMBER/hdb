@hdbactivatestandby
Feature: hdbactivatestandby

    Scenario: hdbactivatestandby works
        Given the database is running
        And the standby is not initialized
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And verify the standby master entries in catalog
        When there is a "heap" table "foobar" in "postgres" with data
        And the master goes down
        And the user runs hdbactivatestandby with options " "
        Then hdbactivatestandby should return a return code of 0
        And verify the standby master is now acting as master
        And verify that table "foobar" in "postgres" has "2190" rows
        And verify that hdbstart on original master fails due to lower Timeline ID
        And clean up and revert back to original master

    Scenario: hdbactivatestandby -f forces standby master to start
        Given the database is running
        And the standby is not initialized
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And verify the standby master entries in catalog
        When there is a "heap" table "foobar" in "postgres" with data
        And the master goes down
        And the standby master goes down
        And the user runs hdbactivatestandby with options " "
        Then hdbactivatestandby should return a return code of 2
        And the user runs hdbactivatestandby with options "-f"
        Then hdbactivatestandby should return a return code of 0
        And verify the standby master is now acting as master
        And verify that table "foobar" in "postgres" has "2190" rows
        And verify that hdbstart on original master fails due to lower Timeline ID
        And clean up and revert back to original master

    Scenario: hdbactivatestandby should fail when given invalid data directory
        Given the database is running
        And the standby is not initialized
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And verify the standby master entries in catalog
        And the user runs hdbactivatestandby with options "-d invalid_directory"
        Then hdbactivatestandby should return a return code of 2

    Scenario: hdbstate after running hdbactivatestandby works
        Given the database is running
        And the standby is not initialized
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And verify the standby master entries in catalog
        And the master goes down
        And the user runs hdbactivatestandby with options " "
        Then hdbactivatestandby should return a return code of 0
        And verify the standby master is now acting as master
        Then the user runs command "hdbstate -s" from standby master
        And verify hdbstate with options "-s" output is correct
        Then the user runs command "hdbstate -Q" from standby master
        And verify hdbstate with options "-Q" output is correct
        Then the user runs command "hdbstate -m" from standby master
	And verify hdbstate with options "-m" output is correct
        And clean up and revert back to original master

    Scenario: tablespaces work
        Given the database is running
          And the standby is not initialized
          And a tablespace is created with data
         When the user runs hdbinitstandby with options " "
         Then hdbinitstandby should return a return code of 0
          And verify the standby master entries in catalog

         When the master goes down
         Then the user runs hdbactivatestandby with options " "
          And hdbactivatestandby should return a return code of 0
          And verify the standby master is now acting as master
          And the tablespace is valid on the standby master
          And clean up and revert back to original master
#---------------
    Scenario: test version
	When the user runs command "hdbactivatestandby --version"
	Then hdbactivatestandby should print "hdbactivatestandby version 1.0.0" escaped to stdout
	#	And hdbactivatestandby should print "inHybrid" to stdout

########################### @concourse_cluster tests ###########################
# The @concourse_cluster tag denotes the scenario that requires a remote cluster

    @concourse_cluster
    Scenario: tablespaces work on a multi-host environment
        Given the database is running
          And the standby is not initialized
          And a tablespace is created with data
         When the user runs hdbinitstandby with options " "
         Then hdbinitstandby should return a return code of 0
          And verify the standby master entries in catalog

         When the master goes down
         Then the user runs hdbactivatestandby with options " "
          And hdbactivatestandby should return a return code of 0
          And verify the standby master is now acting as master
          And the tablespace is valid on the standby master
          And clean up and revert back to original master
