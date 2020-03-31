@hdbinitstandby
Feature: Tests for hdbinitstandby feature

    Scenario: hdbinitstandby with -n option (manually start standby master)
        Given the database is running
        And the standby is not initialized
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And verify the standby master entries in catalog
        And the user runs hdbinitstandby with options "-n"
        And hdbinitstandby should print "Standy master is already up and running" to stdout
        When the standby master goes down
        And the user runs hdbinitstandby with options "-n"
        Then hdbinitstandby should return a return code of 0
        And verify the standby master entries in catalog
        And hdbinitstandby should print "Successfully started standby master" to stdout

    Scenario: hdbinitstandby fails if given same host and port as master segment
        Given the database is running
        And the standby is not initialized
        When the user initializes a standby on the same host as master with same port
        Then hdbinitstandby should return a return code of 2
        And hdbinitstandby should print "cannot create standby on the same host and port" to stdout

    Scenario: hdbinitstandby fails if given same host and datadir as master segment
        Given the database is running
        And the standby is not initialized
        When the user initializes a standby on the same host as master and the same data directory
        Then hdbinitstandby should return a return code of 2
        And hdbinitstandby should print "master data directory exists" to stdout
        And hdbinitstandby should print "use -S and -P to specify a new data directory and port" to stdout

    Scenario: hdbinitstandby exclude dirs
        Given the database is running
        And the standby is not initialized
        And the file "pg_log/testfile" exists under master data directory
        And the file "db_dumps/testfile" exists under master data directory
        And the file "gpperfmon/data/testfile" exists under master data directory
        And the file "gpperfmon/logs/testfile" exists under master data directory
        And the file "promote/testfile" exists under master data directory
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And verify the standby master entries in catalog
        And the file "pg_log/testfile" does not exist under standby master data directory
        And the file "db_dumps/testfile" does not exist under standby master data directory
        And the file "gpperfmon/data/testfile" does not exist under standby master data directory
        And the file "gpperfmon/logs/testfile" does not exist under standby master data directory
        And the file "promote/testfile" does not exist under standby master data directory
        ## maybe clean up the directories created in the master data directory

    Scenario: hdbstate -f shows standby master information after running hdbinitstandby
        Given the database is running
        And the standby is not initialized
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And verify the standby master entries in catalog
        Then the user runs command "hdbstate -f"
        And verify hdbstate with options "-f" output is correct

    Scenario: hdbinitstandby should not throw stacktrace when $GPHOME/share directory is non-writable
        Given the database is running
        And the standby is not initialized
        And "$GPHOME/share" has its permissions set to "555"
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And hdbinitstandby should not print "Traceback" to stdout
        And rely on environment.py to restore path permissions

    Scenario: hdbinitstandby creates the standby with default data_checksums on
        Given the database is running
        And the standby is not initialized
        When the user runs "hdbconfig -s data_checksums"
        Then hdbconfig should return a return code of 0
        Then hdbconfig should print "Values on all segments are consistent" to stdout
        Then hdbconfig should print "Master  value: on" to stdout
        Then hdbconfig should print "Segment value: on" to stdout
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And hdbinitstandby should not print "Traceback" to stdout
        When the user runs pg_controldata against the standby data directory
        Then pg_controldata should print "Data page checksum version:           1" to stdout

    Scenario: hdbinitstandby creates the standby with default data_checksums off
        Given the database is initialized with checksum "off"
        And the standby is not initialized
        When the user runs "hdbconfig -s data_checksums"
        Then hdbconfig should return a return code of 0
        And hdbconfig should print "Values on all segments are consistent" to stdout
        And hdbconfig should print "Master  value: off" to stdout
        And hdbconfig should print "Segment value: off" to stdout
        And the user runs hdbinitstandby with options " "
        Then hdbinitstandby should return a return code of 0
        And hdbinitstandby should not print "Traceback" to stdout
        When the user runs pg_controldata against the standby data directory
	Then pg_controldata should print "Data page checksum version:           0" to stdout

# word test--------------------------------------------------------------------------------------------------   
    Scenario: hdbinitstandby version
	When the user runs command "hdbinitstandby -v"
        Then hdbinitstandby should print "hdbinitstandby" to stdout

    Scenario: hdbinitstandby help
        When the user runs command "hdbinitstandby -?"
        Then hdbinitstandby should print "Adds and/or initializes a standby master host for a inHybrid Database system." to stdout
        And hdbinitstandby should print "hdbinitstandby { -s <standby_hostname> [-P <port>] | -r | -n }" to stdout
        And hdbinitstandby should print "The hdbinitstandby utility adds a backup," to stdout
        And hdbinitstandby should print "inHybrid Database master to allow" to stdout
        And hdbinitstandby should print "the installed inHybrid Database software that is used as a" to stdout
        And hdbinitstandby should print "hdbinitsystem, hdbaddmirrors, hdbactivatestandby " to stdout

    Scenario: hdbinitstandby initialized word test
        Given the database is running
        And the standby is not initialized
        When the user runs command "hdbinitstandby -s mdw -P 10999 -S /tmp/teststandby -a"
        Then hdbinitstandby should return a return code of 0
        And hdbinitstandby should print "inHybrid standby master initialization parameters" to stdout
        And hdbinitstandby should print "inHybrid master hostname" to stdout
        And hdbinitstandby should print "inHybrid master data directory" to stdout
        And hdbinitstandby should print "inHybrid master port" to stdout
        And hdbinitstandby should print "inHybrid standby master hostname" to stdout
        And hdbinitstandby should print "inHybrid standby master port" to stdout
        And hdbinitstandby should print "inHybrid standby master data directory" to stdout
        And hdbinitstandby should print "inHybrid update system catalog" to stdout
        And the user runs command "hdbinitstandby -ra"
