@hdbcheckperf
Feature: hdbcheckperf behave tests

    Scenario: hdbcheckperf -?
        #Given the database is not running
        When the user runs "hdbcheckperf -?"
	    Then hdbcheckperf should return a return code of 0
        Then hdbcheckperf should print "COMMAND NAME: hdbcheckperf" to stdout
        Then hdbcheckperf should print "{-f <hostfile_hdbcheckperf> | -h <hostname> [-h <hostname> ...]}" to stdout
        Then hdbcheckperf should print "The hdbcheckperf utility starts a session on the specified hosts" to stdout
        Then hdbcheckperf should print "Before using hdbcheckperf, you must have a trusted host setup" to stdout
        Then hdbcheckperf should print "-f <hostfile_hdbcheckperf>" to stdout
        Then hdbcheckperf should print "-f <hostfile_hdbchecknet>" to stdout
        Then hdbcheckperf should print "$ hdbcheckperf -f hostfile_hdbchecknet_ic2 -r N --netperf -d /tmp" escaped to stdout
        Then hdbcheckperf should print "hdbssh, hdbscp" to stdout



    Scenario: hdbcheckperf --version
        #Given the database is not running
        When the user runs "hdbcheckperf --version"
	    Then hdbcheckperf should return a return code of 0
        Then hdbcheckperf should print "hdbcheckperf version" to stdout
    
    Scenario: hdbcheckperf functional test
        #Given the database is not running
        When the user runs "hdbcheckperf -d test_dir -h 127.0.0.1 -r dsn -B 32K -S 10MB -D -V --duration 15s"
	    Then hdbcheckperf should return a return code of 0
        Then hdbcheckperf should print "hdbssh" to stdout
        Then hdbcheckperf should print "hdbscp" to stdout
        Then hdbcheckperf should print "hdbcheckperf_$USER" escaped to stdout
        Then hdbcheckperf should print "disk write bandwidth" to stdout
        Then hdbcheckperf should print "disk read bandwidth" to stdout
        Then hdbcheckperf should print "stream bandwidth" to stdout
