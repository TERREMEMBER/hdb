@hdbinitsystem
Feature: hdbinitsystem tests

    Scenario: hdbinitsystem creates a cluster with data_checksums on
        Given the database is initialized with checksum "on"
        When the user runs "hdbconfig -s data_checksums"
        Then hdbconfig should return a return code of 0
        And hdbconfig should print "Values on all segments are consistent" to stdout
        And hdbconfig should print "Master  value: on" to stdout
        And hdbconfig should print "Segment value: on" to stdout

    Scenario: hdbinitsystem creates a cluster with data_checksums off
        Given the database is initialized with checksum "off"
        When the user runs "hdbconfig -s data_checksums"
        Then hdbconfig should return a return code of 0
        And hdbconfig should print "Values on all segments are consistent" to stdout
        And hdbconfig should print "Master  value: off" to stdout
        And hdbconfig should print "Segment value: off" to stdout

    Scenario: hdbinitsystem creates a cluster when the user confirms the dialog when --ignore-warnings is passed in
        Given create demo cluster config
        When the user runs command "echo y | hdbinitsystem -c ../gpAux/gpdemo/clusterConfigFile --ignore-warnings"
        Then hdbinitsystem should return a return code of 0
        Given the user runs "hdbstate"
        Then hdbstate should return a return code of 0

    Scenario: hdbinitsystem exits with status 1 when the user enters nothing for the confirmation
        Given create demo cluster config
        When the user runs command "echo '' | hdbinitsystem -c ../gpAux/gpdemo/clusterConfigFile" eok
        Then hdbinitsystem should return a return code of 1
        Given the user runs "hdbstate"
        Then hdbstate should return a return code of 2

    Scenario: hdbinitsystem exits with status 1 when the user enters no for the confirmation
        Given create demo cluster config
        When the user runs command "echo no | hdbinitsystem -c ../gpAux/gpdemo/clusterConfigFile" eok
        Then hdbinitsystem should return a return code of 1
        Given the user runs "hdbstate"
        Then hdbstate should return a return code of 2

    Scenario: hdbinitsystem creates a cluster when the user confirms the dialog
        Given create demo cluster config
        # need to remove this log because otherwise SCAN_LOG may pick up a previous error/warning in the log
        And the user runs command "rm -r ~/gpAdminLogs/hdbinitsystem*"
        When the user runs command "echo y | hdbinitsystem -c ../gpAux/gpdemo/clusterConfigFile"
        Then hdbinitsystem should return a return code of 0
        Given the user runs "hdbstate"
        Then hdbstate should return a return code of 0

    Scenario: hdbinitsystem fails with exit code 2 when the functions file is not found
        Given create demo cluster config
           # force a load error when trying to source gp_bash_functions.sh
        When the user runs command "ln -s -f `which hdbinitsystem` /tmp/hdbinitsystem-link; . /tmp/hdbinitsystem-link" eok
        Then hdbinitsystem should return a return code of 2

    Scenario: hdbinitsystem fails with exit code 2 when the functions file is not found when passing the --ignore-warnings flag
        Given create demo cluster config
           # force a load error when trying to source gp_bash_functions.sh
        When the user runs command "ln -s -f `which hdbinitsystem` /tmp/hdbinitsystem-link; . /tmp/hdbinitsystem-link --ignore-warnings" eok
        Then hdbinitsystem should return a return code of 2

    Scenario: hdbinitsystem returns exit code 1 when hdbinitstandby fails
        Given create demo cluster config
           # force hdbinitstandby to fail by specifying a directory that does not exist (hdbinitsystem continues successfully)
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -s localhost -S not-a-real-directory -P 21100 -h ../gpAux/gpdemo/hostfile"
        Then hdbinitsystem should return a return code of 1

    Scenario: hdbinitsystem returns exit code 0 when hdbinitstandby fails when passing the --ignore-warnings flag
       Given create demo cluster config
           # force hdbinitstandby to fail by specifying a directory that does not exist (hdbinitsystem continues successfully)
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -s localhost -S not-a-real-directory -P 21100 -h ../gpAux/gpdemo/hostfile --ignore-warnings"
        Then hdbinitsystem should return a return code of 0

    Scenario: after a failed run of hdbinitsystem, a re-run should return exit status 0 when using --ignore-warnings
        Given create demo cluster config
        # force a failure by passing no args
        When the user runs "hdbinitsystem"
        Then hdbinitsystem should return a return code of 2
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile --ignore-warnings"
        Then hdbinitsystem should return a return code of 0

      Scenario: after hdbinitsystem logs a warning, a re-run should return exit status 0 when using --ignore-warnings
        Given create demo cluster config
        # log a warning
        And the user runs command "echo 'ARRAY_NAME=' >> ../gpAux/gpdemo/clusterConfigFile"
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile --ignore-warnings"
        Then hdbinitsystem should return a return code of 0
        Given create demo cluster config
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile --ignore-warnings"
        Then hdbinitsystem should return a return code of 0

    Scenario: hdbinitsystem should warn but not fail when standby cannot be instantiated when using --ignore-warnings
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the standby is not initialized
        And the user runs command "rm -rf /tmp/hdbinitsystemtest && mkdir /tmp/hdbinitsystemtest"
        # stop db and make sure cluster config exists so that we can manually initialize standby
        And the cluster config is generated with data_checksums "1"
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -s localhost -P 21100 -S /wrong/path -h ../gpAux/gpdemo/hostfile --ignore-warnings"
        Then hdbinitsystem should return a return code of 0
        And hdbinitsystem should not print "To activate the Standby Master Segment in the event of Master" to stdout
        And hdbinitsystem should print "Cluster setup finished, but Standby Master failed to initialize. Review contents of log files for errors." to stdout
        And sql "select * from gp_toolkit.__gp_user_namespaces" is executed in "postgres" db

    Scenario: after a failed run of hdbinitsystem, a re-run should return exit status 1
        Given create demo cluster config
        # force a failure by passing no args
        When the user runs "hdbinitsystem"
        Then hdbinitsystem should return a return code of 2
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile"
        Then hdbinitsystem should return a return code of 1

      Scenario: after hdbinitsystem logs a warning, a re-run should return exit status 1
        Given create demo cluster config
        # log a warning
        And the user runs command "echo 'ARRAY_NAME=' >> ../gpAux/gpdemo/clusterConfigFile"
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile"
        Then hdbinitsystem should return a return code of 1
        Given create demo cluster config
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile"
        Then hdbinitsystem should return a return code of 1

    Scenario: hdbinitsystem should fail when standby cannot be instantiated
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the standby is not initialized
        And the user runs command "rm -rf /tmp/hdbinitsystemtest && mkdir /tmp/hdbinitsystemtest"
        # stop db and make sure cluster config exists so that we can manually initialize standby
        And the cluster config is generated with data_checksums "1"
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -s localhost -P 21100 -S /wrong/path -h ../gpAux/gpdemo/hostfile"
        Then hdbinitsystem should return a return code of 1
        And hdbinitsystem should not print "To activate the Standby Master Segment in the event of Master" to stdout
        And hdbinitsystem should print "Cluster setup finished, but Standby Master failed to initialize. Review contents of log files for errors." to stdout
        And sql "select * from gp_toolkit.__gp_user_namespaces" is executed in "postgres" db

    Scenario: hdbinitsystem generates an output configuration file and then starts cluster with data_checksums on
        Given the cluster config is generated with data_checksums "on"
        When the user runs command "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -O /tmp/output_config_file"
        And hdbinitsystem should return a return code of 0
        Then verify that file "output_config_file" exists under "/tmp"
        And verify that the file "/tmp/output_config_file" contains "HEAP_CHECKSUM=on"
        And the user runs "hdbinitsystem -a -I /tmp/output_config_file -l /tmp/"
        Then hdbinitsystem should return a return code of 0
        When the user runs "hdbconfig -s data_checksums"
        Then hdbconfig should return a return code of 0
        And hdbconfig should print "Values on all segments are consistent" to stdout
        And hdbconfig should print "Master  value: on" to stdout
        And hdbconfig should print "Segment value: on" to stdout

    Scenario: hdbinitsystem generates an output configuration file and then starts cluster with data_checksums off
        Given the cluster config is generated with data_checksums "off"
        When the user runs command "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -O /tmp/output_config_file"
        And hdbinitsystem should return a return code of 0
        Then verify that file "output_config_file" exists under "/tmp"
        And verify that the file "/tmp/output_config_file" contains "HEAP_CHECKSUM=off"
        And the user runs "hdbinitsystem -a -I /tmp/output_config_file -l /tmp/"
        Then hdbinitsystem should return a return code of 0
        When the user runs "hdbconfig -s data_checksums"
        Then hdbconfig should return a return code of 0
        And hdbconfig should print "Values on all segments are consistent" to stdout
        And hdbconfig should print "Master  value: off" to stdout
        And hdbconfig should print "Segment value: off" to stdout

    Scenario: hdbinitsystem should warn but not fail when standby cannot be instantiated
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the standby is not initialized
        And the user runs command "rm -rf $MASTER_DATA_DIRECTORY/newstandby"
        And the user runs command "rm -rf /tmp/hdbinitsystemtest && mkdir /tmp/hdbinitsystemtest"
        And the cluster config is generated with data_checksums "1"
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -l /tmp/hdbinitsystemtest -s localhost -P 21100 -S $MASTER_DATA_DIRECTORY/newstandby -h ../gpAux/gpdemo/hostfile"
        Then hdbinitsystem should return a return code of 0
        And hdbinitsystem should print "Log file scan check passed" to stdout
        And sql "select * from gp_toolkit.__gp_user_namespaces" is executed in "postgres" db

    Scenario: hdbinitsystem creates a cluster in default timezone
        Given the database is not running
        And "TZ" environment variable is not set
        And the system timezone is saved
        And the user runs command "rm -rf ../gpAux/gpdemo/datadirs/*"
        And the user runs command "mkdir ../gpAux/gpdemo/datadirs/qddir; mkdir ../gpAux/gpdemo/datadirs/dbfast1; mkdir ../gpAux/gpdemo/datadirs/dbfast2; mkdir ../gpAux/gpdemo/datadirs/dbfast3"
        And the user runs command "mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror1; mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror2; mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror3"
        And the user runs command "rm -rf /tmp/hdbinitsystemtest && mkdir /tmp/hdbinitsystemtest"
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -l /tmp/hdbinitsystemtest -P 21100 -h ../gpAux/gpdemo/hostfile"
        And hdbinitsystem should return a return code of 0
        Then the database timezone is saved
        And the database timezone matches the system timezone
        And the startup timezone is saved
        And the startup timezone matches the system timezone

    Scenario: hdbinitsystem creates a cluster using TZ
        Given the database is not running
        And the environment variable "TZ" is set to "US/Hawaii"
        And the user runs command "rm -rf ../gpAux/gpdemo/datadirs/*"
        And the user runs command "mkdir ../gpAux/gpdemo/datadirs/qddir; mkdir ../gpAux/gpdemo/datadirs/dbfast1; mkdir ../gpAux/gpdemo/datadirs/dbfast2; mkdir ../gpAux/gpdemo/datadirs/dbfast3"
        And the user runs command "mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror1; mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror2; mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror3"
        And the user runs command "rm -rf /tmp/hdbinitsystemtest && mkdir /tmp/hdbinitsystemtest"
        When the user runs "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -l /tmp/hdbinitsystemtest -P 21100 -h ../gpAux/gpdemo/hostfile"
        And hdbinitsystem should return a return code of 0
        Then the database timezone is saved
        And the database timezone matches "HST"
        And the startup timezone is saved
        And the startup timezone matches "HST"

    Scenario: hdbinitsystem should print FQDN in pg_hba.conf when HBA_HOSTNAMES=1
        Given the cluster config is generated with HBA_HOSTNAMES "1"
        When generate cluster config file "/tmp/output_config_file"
        Then verify that the file "/tmp/output_config_file" contains "HBA_HOSTNAMES=1"
        When initialize a cluster using "/tmp/output_config_file"
        Then verify that the file "../gpAux/gpdemo/datadirs/qddir/demoDataDir-1/pg_hba.conf" contains FQDN only for trusted host
        And verify that the file "../gpAux/gpdemo/datadirs/dbfast1/demoDataDir0/pg_hba.conf" contains FQDN only for trusted host

    Scenario: hdbinitsystem should print CIDR in pg_hba.conf when HBA_HOSTNAMES=0
        Given the cluster config is generated with HBA_HOSTNAMES "0"
        When generate cluster config file "/tmp/output_config_file"
        Then verify that the file "/tmp/output_config_file" contains "HBA_HOSTNAMES=0"
        When initialize a cluster using "/tmp/output_config_file"
        Then verify that the file "../gpAux/gpdemo/datadirs/qddir/demoDataDir-1/pg_hba.conf" contains CIDR only for trusted host
        And verify that the file "../gpAux/gpdemo/datadirs/dbfast1/demoDataDir0/pg_hba.conf" contains CIDR only for trusted host

    Scenario: hdbinitsystem should print FQDN in pg_hba.conf for standby when HBA_HOSTNAMES=1
        Given the database is running
        And all the segments are running
        And the segments are synchronized
        And the standby is not initialized
        And ensure the standby directory does not exist
        And the cluster config is generated with HBA_HOSTNAMES "1"
        When generate cluster config file "/tmp/output_config_file"
        Then verify that the file "/tmp/output_config_file" contains "HBA_HOSTNAMES=1"
        When initialize a cluster with standby using "/tmp/output_config_file"
        Then verify that the file "../gpAux/gpdemo/datadirs/qddir/demoDataDir-1/pg_hba.conf" contains FQDN only for trusted host
        And verify that the file "../gpAux/gpdemo/datadirs/dbfast1/demoDataDir0/pg_hba.conf" contains FQDN only for trusted host
        And verify that the file "../gpAux/gpdemo/datadirs/qddir/demoDataDir-1/newstandby/pg_hba.conf" contains FQDN only for trusted host
# -------------------------------------------------------------------------------------------------

# help test
     Scenario: py help test
        When the user runs command "hdbinitsystem --sdfsdf"
        Then the hdbinitsystem should print "Creates a new inHybrid Database instance" to stdout
        And the hdbinitsystem should print "Supplies all inHybrid configuration information required by this utility." to stdout
        And the hdbinitsystem should print "password to set for inHybrid superuser in database" to stdout
        And the hdbinitsystem should print "the new inHybrid instance. Normally set in hdb_config_file." to stdout
        And the hdbinitsystem should print "inHybrid Database members and segments using the QD_PRIMARY_ARRAY and" to stdout
        And the hdbinitsystem should print "When used with the -O option, hdbinitsystem does not create a new inHybrid" to stdout
        And the hdbinitsystem should print "inHybrid Database members and segments using the QD_PRIMARY_ARRAY and" to stdout
        And the hdbinitsystem should print "postgresql.conf file during inHybrid database initialization." to stdout
# version test
        Scenario: version test
        When the user runs command "hdbinitsystem -v"
        Then the hdbinitsystem should print "hdbinitsystem" to stdout
# init test
     Scenario: init test
        Given create demo cluster config
        Given the database is not running
        And the user runs command "rm -rf ../gpAux/gpdemo/datadirs/*"
        And the user runs command "mkdir ../gpAux/gpdemo/datadirs/qddir; mkdir ../gpAux/gpdemo/datadirs/dbfast1; mkdir ../gpAux/gpdemo/datadirs/dbfast2; mkdir ../gpAux/gpdemo/datadirs/dbfast3"
        And the user runs command "mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror1; mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror2; mkdir ../gpAux/gpdemo/datadirs/dbfast_mirror3"
        And the user runs command "rm -rf /tmp/hdbinitsystemtest && mkdir /tmp/hdbinitsystemtest"
        When the user runs command "hdbinitsystem -a -c ../gpAux/gpdemo/clusterConfigFile -l /tmp/hdbinitsystemtest -P 21100 -h ../gpAux/gpdemo/hostfile"
        Then hdbinitsystem should return a return code of 0
        And the hdbinitsystem should print "Reading inHybrid configuration file clusterConfigFile" to stdout
