# Note: these tests require the rpm binary to be installed
@hdbpkg
Feature: hdbpkg tests

    Scenario: hdbpkg environment does not have any hdbpkg
        Given the database is running
        And database "gptest" exists
        Then the user runs "hdbpkg --remove sample"

    Scenario: hdbpkg -u should prompt user when package is updated with -a option
        Given the database is running
        When the user runs "hdbpkg -u foo.hdbpkg -a"
        Then hdbpkg should return a return code of 2
        And hdbpkg should print "WARNING: The process of updating a package includes removing all" to stdout
        And hdbpkg should print "previous versions of the system objects related to the package. For" to stdout
        And hdbpkg should print "example, previous versions of shared libraries are removed." to stdout
        And hdbpkg should print "After the update process, a database function will fail when it is" to stdout
        And hdbpkg should print "called if the function references a package file that has been removed." to stdout
        And hdbpkg should print "Cannot find package foo.hdbpkg" to stdout
        And hdbpkg should not print "Do you still want to continue ?" to stdout

    Scenario: hdbpkg -u should prompt user when package is updated with yes as input
        Given the database is running
        When the user runs "hdbpkg -u foo.hdbpkg < test/behave/mgmt_utils/steps/data/yes.txt"
        Then hdbpkg should return a return code of 2
        And hdbpkg should print "WARNING: The process of updating a package includes removing all" to stdout
        And hdbpkg should print "previous versions of the system objects related to the package. For" to stdout
        And hdbpkg should print "example, previous versions of shared libraries are removed." to stdout
        And hdbpkg should print "After the update process, a database function will fail when it is" to stdout
        And hdbpkg should print "called if the function references a package file that has been removed." to stdout
        And hdbpkg should print "Cannot find package foo.hdbpkg" to stdout
        And hdbpkg should not print "Skipping update of hdbpkg based on user input" to stdout
        And hdbpkg should print "Do you still want to continue ?" to stdout

    Scenario: hdbpkg -u should prompt user when package is updated with no as input
        Given the database is running
        When the user runs "hdbpkg -u foo.hdbpkg < test/behave/mgmt_utils/steps/data/no.txt"
        Then hdbpkg should return a return code of 0
        And hdbpkg should print "WARNING: The process of updating a package includes removing all" to stdout
        And hdbpkg should print "previous versions of the system objects related to the package. For" to stdout
        And hdbpkg should print "example, previous versions of shared libraries are removed." to stdout
        And hdbpkg should print "After the update process, a database function will fail when it is" to stdout
        And hdbpkg should print "called if the function references a package file that has been removed." to stdout
        And hdbpkg should print "Skipping update of hdbpkg based on user input" to stdout
        And hdbpkg should print "Do you still want to continue ?" to stdout

    Scenario: hdbpkg --query --all when nothing is installed should report nothing installed
        Given the database is running
        When the user runs "hdbpkg --query --all"
        Then hdbpkg should return a return code of 0
        And hdbpkg should print "Starting hdbpkg with args: --query --all" to stdout

    Scenario: hdbpkg --remove should report failure when the package is not installed
        Given the database is running
        When the user runs "hdbpkg --remove sample"
        Then hdbpkg should return a return code of 2
        And hdbpkg should print "Package sample has not been installed" to stdout

    Scenario: hdbpkg -?
        When the user runs "hdbpkg -?"
        Then hdbpkg should return a return code of 0
        Then hdbpkg should print "COMMAND NAME: hdbpkg" to stdout
        Then hdbpkg should print "inHybrid Database" to stdout
        Then hdbpkg should print "--migrate <HDBHOME_1> <HDBHOME_2>" to stdout
        Then hdbpkg should print "inHybrid Package Manager" to stdout
        Then hdbpkg should print "/usr/local/inhybrid-db-1.0.0" to stdout
        Then hdbpkg should print "HDBHOME_2 must match" to stdout
	Then hdbpkg should print "the $HDBHOME from which" escaped to stdout

    Scenario: hdbpkg --version
        When the user runs "hdbpkg --version"
        Then hdbpkg should return a return code of 0
        Then hdbpkg should print "hdbpkg version" to stdout


########################### @concourse_cluster tests ###########################
# The @concourse_cluster tag denotes the scenario that requires a remote cluster

    @concourse_cluster
    Scenario: hdbpkg --install should report success because the package is not yet installed
        Given the database is running
        When the user runs "hdbpkg --install test/behave/mgmt_utils/steps/data/sample.hdbpkg"
        Then hdbpkg should return a return code of 0
        And hdbpkg should print "This is a sample message shown after successful installation" to stdout
        And hdbpkg should print "Completed local installation of sample" to stdout
        And "sample" hdbpkg files exist on all hosts

    @concourse_cluster
    Scenario: hdbpkg --install should report failure because the package is already installed
        Given the database is running
        When the user runs "hdbpkg --install test/behave/mgmt_utils/steps/data/sample.hdbpkg"
        Then hdbpkg should return a return code of 2
        And hdbpkg should print "sample.hdbpkg is already installed." to stdout

    @concourse_cluster
    Scenario: hdbpkg --remove should report success when the package is already installed
        Given the database is running
        When the user runs "hdbpkg --remove sample"
        Then hdbpkg should return a return code of 0
        And hdbpkg should print "Uninstalling package sample.hdbpkg" to stdout
        And hdbpkg should print "Completed local uninstallation of sample.hdbpkg" to stdout
        And hdbpkg should print "sample.hdbpkg successfully uninstalled" to stdout
        And "sample" hdbpkg files do not exist on any hosts

    @concourse_cluster
    Scenario: hdbpkg --query should report installed packages
        Given the database is running
        # to be idempotent, potentially reinstalling if the above test just ran,
        # which will result in an error result code, so don't check result code of install
        When the user runs "hdbpkg --install test/behave/mgmt_utils/steps/data/sample.hdbpkg"
        When the user runs "hdbpkg --query --all"
        Then hdbpkg should return a return code of 0
        And hdbpkg should print "Starting hdbpkg with args: --query --all" to stdout
        And hdbpkg should print "sample" to stdout

    @concourse_cluster
    Scenario: hdbpkg --clean (which should be named "sync") should install to the segment host that lacks a hdbpkg found elsewhere
        Given the database is running
        When the user runs "hdbpkg --install test/behave/mgmt_utils/steps/data/sample.hdbpkg"
        And hdbpkg "sample" is removed from a segment host
        And the user runs "hdbpkg --clean"
        Then hdbpkg should return a return code of 0
        And hdbpkg should print "The following packages will be installed on .*: sample.hdbpkg" to stdout
        And "sample" hdbpkg files exist on all hosts

    @concourse_cluster
    Scenario: hdbpkg --clean (which should be named "sync") should remove on all segment hosts when hdbpkg does not exist in master
        Given the database is running
        When the user runs "hdbpkg --install test/behave/mgmt_utils/steps/data/sample.hdbpkg"
        And hdbpkg "sample" is removed from master host
        And the user runs "hdbpkg --clean"
        Then hdbpkg should return a return code of 0
        And hdbpkg should print "The following packages will be uninstalled on .*: sample.hdbpkg" to stdout
        And "sample" hdbpkg files do not exist on any hosts

    @concourse_cluster
    Scenario: hdbpkg --migrate copies all packages from master to all segment hosts
        Given the database is running
        And the user runs "hdbpkg -r sample"
        And a hdbhome copy is created at /tmp/hdbpkg_migrate on all hosts
        When a user runs "MASTER_DATA_DIRECTORY=$MASTER_DATA_DIRECTORY hdbpkg -r sample" with hdbhome "/tmp/hdbpkg_migrate"
        And "sample" hdbpkg files do not exist on any hosts
        When a user runs "MASTER_DATA_DIRECTORY=$MASTER_DATA_DIRECTORY hdbpkg --install $(pwd)/test/behave/mgmt_utils/steps/data/sample.hdbpkg" with hdbhome "/tmp/hdbpkg_migrate"
        Then hdbpkg should return a return code of 0
        And "sample" hdbpkg files do not exist on any hosts
        And the user runs "hdbstop -a && hdbstart -a -m"
        When the user runs "hdbpkg --migrate /tmp/hdbpkg_migrate $HDBHOME"
        Then hdbpkg should return a return code of 0
        And hdbpkg should print "Installing sample.hdbpkg locally" to stdout
        And hdbpkg should print "The following packages will be installed on .*: sample.hdbpkg" to stdout
        And hdbpkg should print "Successfully cleaned the cluster" to stdout
        And hdbpkg should print "The package migration has completed" to stdout
        And the user runs "hdbstop -ar"
        And "sample" hdbpkg files exist on all hosts
