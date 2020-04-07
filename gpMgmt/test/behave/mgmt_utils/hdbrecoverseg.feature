@hdbrecoverseg
Feature: hdbrecoverseg tests
    
    @recover1
    Scenario: incremental recovery works with tablespaces
        Given the database is running
          And a tablespace is created with data
          And user stops all primary processes
          And user can start transactions
         When the user runs "hdbrecoverseg -a"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid

        Given another tablespace is created with data
         When the user runs "hdbrecoverseg -ra"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
          And the other tablespace is valid
  
    @recover2
    Scenario: full recovery works with tablespaces
        Given the database is running
          And a tablespace is created with data
          And user stops all primary processes
          And user can start transactions
         When the user runs "hdbrecoverseg -a -F"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid

        Given another tablespace is created with data
         When the user runs "hdbrecoverseg -ra"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
          And the other tablespace is valid
    
    @recover3
    Scenario: hdbrecoverseg should not output bootstrap error on success
        Given the database is running
        And user stops all primary processes
        And user can start transactions
        When the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Running pg_rewind on required mirrors" to stdout
        And hdbrecoverseg should not print "Unhandled exception in thread started by <bound method Worker.__bootstrap" to stdout
        And the segments are synchronized
        When the user runs "hdbrecoverseg -ra"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should not print "Unhandled exception in thread started by <bound method Worker.__bootstrap" to stdout

    @recover4
    Scenario: hdbrecoverseg displays pg_basebackup progress to the user
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And user stops all mirror processes
        When user can start transactions
        And the user runs "hdbrecoverseg -F -a -s"
        Then hdbrecoverseg should return a return code of 0
        #And hdbrecoverseg should print "pg_basebackup: base backup completed" to stdout for each mirror
        And gpAdminLogs directory has no "pg_basebackup*" files
        And all the segments are running
        And the segments are synchronized

    @recover5
    Scenario: hdbrecoverseg does not display pg_basebackup progress to the user when --no-progress option is specified
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And user stops all mirror processes
        When user can start transactions
        And the user runs "hdbrecoverseg -F -a --no-progress"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should not print "pg_basebackup: base backup completed" to stdout
        And gpAdminLogs directory has no "pg_basebackup*" files
        And all the segments are running
        And the segments are synchronized

    @recover6
    Scenario: When hdbrecoverseg incremental recovery uses pg_rewind to recover and an existing postmaster.pid on the killed primary segment corresponds to a non postgres process
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the "primary" segment information is saved
        When the postmaster.pid file on "primary" segment is saved
        And user stops all primary processes
        When user can start transactions
        And the background pid is killed on "primary" segment
        And we run a sample background script to generate a pid on "primary" segment
        And we generate the postmaster.pid file with the background pid on "primary" segment
        And the user runs "hdbrecoverseg -a"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Running pg_rewind on required mirrors" to stdout
        And hdbrecoverseg should not print "Unhandled exception in thread started by <bound method Worker.__bootstrap" to stdout
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -ra"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should not print "Unhandled exception in thread started by <bound method Worker.__bootstrap" to stdout
        And the segments are synchronized
        And the backup pid file is deleted on "primary" segment
        And the background pid is killed on "primary" segment

    @recover7
    Scenario: Pid does not correspond to any running process
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the "primary" segment information is saved
        When the postmaster.pid file on "primary" segment is saved
        And user stops all primary processes
        When user can start transactions
        And we generate the postmaster.pid file with a non running pid on the same "primary" segment
        And the user runs "hdbrecoverseg -a"
        And hdbrecoverseg should print "Running pg_rewind on required mirrors" to stdout
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should not print "Unhandled exception in thread started by <bound method Worker.__bootstrap" to stdout
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -ra"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should not print "Unhandled exception in thread started by <bound method Worker.__bootstrap" to stdout
        And the segments are synchronized
        And the backup pid file is deleted on "primary" segment

    @recover8
    Scenario: pg_isready functions on recovered segments
        Given the database is running
          And all the segments are running
          And the segments are synchronized
         When user stops all primary processes
          And user can start transactions

         When the user runs "hdbrecoverseg -a"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized

         When the user runs "hdbrecoverseg -ar"
         Then hdbrecoverseg should return a return code of 0
          And all the segments are running
          And the segments are synchronized
          And pg_isready reports all primaries are accepting connections


########################### @concourse_cluster tests ###########################
# The @concourse_cluster tag denotes the scenario that requires a remote cluster

    @recover9
    @concourse_cluster
    Scenario: hdbrecoverseg behave test requires a cluster with at least 2 hosts
        Given the database is running
        Given database "gptest" exists
        And the information of a "mirror" segment on a remote host is saved

    @recover10
    @concourse_cluster
    Scenario: When hdbrecoverseg full recovery is executed and an existing postmaster.pid on the killed primary segment corresponds to a non postgres process
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the "primary" segment information is saved
        When the postmaster.pid file on "primary" segment is saved
        And user stops all primary processes
        When user can start transactions
        And the background pid is killed on "primary" segment
        And we run a sample background script to generate a pid on "primary" segment
        And we generate the postmaster.pid file with the background pid on "primary" segment
        And the user runs "hdbrecoverseg -F -a"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should not print "Unhandled exception in thread started by <bound method Worker.__bootstrap" to stdout
        And hdbrecoverseg should print "Skipping to stop segment.* on host.* since it is not a postgres process" to stdout
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -ra"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should not print "Unhandled exception in thread started by <bound method Worker.__bootstrap" to stdout
        And the segments are synchronized
        And the backup pid file is deleted on "primary" segment
        And the background pid is killed on "primary" segment

    @recover11
    @concourse_cluster
    Scenario: hdbrecoverseg full recovery testing
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the information of a "mirror" segment on a remote host is saved
        When user kills a "mirror" process with the saved information
        And user can start transactions
        Then the saved "mirror" segment is marked down in config
        When the user runs "hdbrecoverseg -F -a"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should not print "Running pg_rewind on required mirrors" to stdout
        And all the segments are running
        And the segments are synchronized

    @recover12
    @concourse_cluster
    Scenario: hdbrecoverseg with -i and -o option
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the information of a "mirror" segment on a remote host is saved
        When user kills a "mirror" process with the saved information
        And user can start transactions
        Then the saved "mirror" segment is marked down in config
        When the user runs "hdbrecoverseg -o failedSegmentFile"
        Then hdbrecoverseg should return a return code of 0
        Then hdbrecoverseg should print "Configuration file output to failedSegmentFile successfully" to stdout
        When the user runs "hdbrecoverseg -i failedSegmentFile -a"
        Then hdbrecoverseg should return a return code of 0
        Then hdbrecoverseg should print "1 segment\(s\) to recover" to stdout
        And all the segments are running
        And the segments are synchronized

    @recover13
    @concourse_cluster
    Scenario: hdbrecoverseg should not throw exception for empty input file
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the information of a "mirror" segment on a remote host is saved
        When user kills a "mirror" process with the saved information
        And user can start transactions
        Then the saved "mirror" segment is marked down in config
        When the user runs command "touch /tmp/empty_file"
        When the user runs "hdbrecoverseg -i /tmp/empty_file -a"
        Then hdbrecoverseg should return a return code of 0
        Then hdbrecoverseg should print "No segments to recover" to stdout
        When the user runs "hdbrecoverseg -a -F"
        Then all the segments are running
        And the segments are synchronized

    @recover14
    @concourse_cluster
    Scenario: hdbrecoverseg should use the same setting for data_checksums for a full recovery
        Given the database is running
        And results of the sql "show data_checksums" db "template1" are stored in the context
        # cause a full recovery AFTER a failure on a remote primary
        And all the segments are running
        And the segments are synchronized
        And the information of a "mirror" segment on a remote host is saved
        And the information of the corresponding primary segment on a remote host is saved
        When user kills a "primary" process with the saved information
        And user can start transactions
        Then the saved "primary" segment is marked down in config
        When the user runs "hdbrecoverseg -F -a"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Heap checksum setting is consistent between master and the segments that are candidates for recoverseg" to stdout
        When the user runs "hdbrecoverseg -ra"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Heap checksum setting is consistent between master and the segments that are candidates for recoverseg" to stdout
        And all the segments are running
        And the segments are synchronized
        # validate the the new segment has the correct setting by getting admin connection to that segment
        Then the saved primary segment reports the same value for sql "show data_checksums" db "template1" as was saved

    @recover15
    @concourse_cluster
    Scenario: incremental recovery works with tablespaces on a multi-host environment
        Given the database is running
          And a tablespace is created with data
          And user stops all primary processes
          And user can start transactions
         When the user runs "hdbrecoverseg -a"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid

        Given another tablespace is created with data
         When the user runs "hdbrecoverseg -ra"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
          And the other tablespace is valid

    @recover16
    @concourse_cluster
    Scenario: full recovery works with tablespaces on a multi-host environment
        Given the database is running
          And a tablespace is created with data
          And user stops all primary processes
          And user can start transactions
         When the user runs "hdbrecoverseg -a -F"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid

        Given another tablespace is created with data
         When the user runs "hdbrecoverseg -ra"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
          And the other tablespace is valid

    @recoverseg_a	
    Scenario: Do not prompt the user for confirmation
        Given the database is running
          And a tablespace is created with data
          And user stops all primary processes
          And user can start transactions
         When the user runs "hdbrecoverseg -a"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
	  And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
	  And hdbrecoverseg should print "local inHybrid Version" to stdout
	  And hdbrecoverseg should print "master inHybrid Version" to stdout

        Given another tablespace is created with data
         When the user runs "hdbrecoverseg -ra"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
          And the other tablespace is valid
	      And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
	      And hdbrecoverseg should print "local inHybrid Version" to stdout
          And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_F	  
    Scenario: Perform a full copy of the active segment instance in order to recover the failed
segment.
        Given the database is running
          And a tablespace is created with data
          And user stops all primary processes
          And user can start transactions
         When the user runs "hdbrecoverseg -a -F"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
	  And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
          And hdbrecoverseg should print "local inHybrid Version" to stdout
	  And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_d	
    Scenario: Optional. The master host data directory
        Given the database is running
          And a tablespace is created with data
          And user stops all primary processes
          And user can start transactions
         When the user runs "hdbrecoverseg -a -d $MASTER_DATA_DIRECTORY"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
	  And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
	  And hdbrecoverseg should print "local inHybrid Version" to stdout
	  And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_l	
    Scenario: The directory to write the log file. Defaults to ~/gpAdminLogs.
        Given the database is running
          And a tablespace is created with data
          And user stops all primary processes
          And user can start transactions
         When the user runs "hdbrecoverseg -a -l ~/gpAdminLogs"
         Then hdbrecoverseg should return a return code of 0
          And the segments are synchronized
          And the tablespace is valid
	      And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
	      And hdbrecoverseg should print "local inHybrid Version" to stdout
	      And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_o
    @concourse_cluster
    Scenario: Specifies a file name and location to output a sample recovery configuration file.
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -o failedSegmentFile"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
        And hdbrecoverseg should print "local inHybrid Version" to stdout
        And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_p
    @concourse_cluster
    Scenario: Specifies a spare host outside of the currently configured Database array on which to recover invalid segments
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -p localhost"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
        And hdbrecoverseg should print "local inHybrid Version" to stdout
        And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_B
    @concourse_cluster
    Scenario: The number of segments to recover in parallel
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -B 2"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
        And hdbrecoverseg should print "local inHybrid Version" to stdout
        And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_r
    @concourse_cluster
    Scenario: After a segment recovery, segment instances may not be returned to the preferred role that they were given at system initialization time
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -ar"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
        And hdbrecoverseg should print "local inHybrid Version" to stdout
        And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_s
    @concourse_cluster
    Scenario: Show pg_basebackup progress sequentially instead of in-place
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -s"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
        And hdbrecoverseg should print "local inHybrid Version" to stdout
        And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_noprogress
    @concourse_cluster
    Scenario: Suppresses progress reports from the pg_basebackup utility
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg --no-progress"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
        And hdbrecoverseg should print "local inHybrid Version" to stdout
        And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_v
    @concourse_cluster
    Scenario: Sets logging output to verbose
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg -v"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "Starting hdbrecoverseg with args" to stdout
        And hdbrecoverseg should print "local inHybrid Version" to stdout
        And hdbrecoverseg should print "master inHybrid Version" to stdout

    @recoverseg_version
    @concourse_cluster
    Scenario: Displays the version of this utility
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg --version"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "hdbrecoverseg version" to stdout

    @recoverseg_help
    @concourse_cluster
    Scenario: Displays the online help
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        When the user runs "hdbrecoverseg --help"
        Then hdbrecoverseg should return a return code of 0
        And hdbrecoverseg should print "hdbrecoverseg" to stdout

