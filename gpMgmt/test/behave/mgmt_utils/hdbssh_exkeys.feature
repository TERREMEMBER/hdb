@hdbssh-exkeys
Feature: hdbssh-exkeys behave tests

    @concourse_cluster
    Scenario: fail sensibly if 1-N is not in place
        Given the hdbssh-exkeys master host is set to "mdw"
          And the hdbssh-exkeys segment host is set to "sdw1,sdw2,sdw3"
          And the local SSH configuration is backed up and removed
         When hdbssh-exkeys is run
         Then hdbssh-exkeys should return a return code of 1
          And hdbssh-exkeys writes "[ERROR]: Failed to ssh to sdw" to stderr
          And hdbssh-exkeys writes "[ERROR]: Expected passwordless ssh to host sdw" to stderr

    @concourse_cluster
    Scenario: N-to-N exchange works
        Given the hdbssh-exkeys master host is set to "mdw"
          And the hdbssh-exkeys segment host is set to "sdw1,sdw2,sdw3"
          And all SSH configurations are backed up and stripped
          And the segments can only be accessed using the master key
          And there is no duplication in the "authorized_keys" files
         Then all hosts "cannot" reach each other or themselves automatically

         When hdbssh-exkeys is run successfully
         Then all hosts "can" reach each other or themselves automatically

         # run it again to make sure that hdbssh-exkeys is idempotent
         When hdbssh-exkeys is run successfully
         Then all hosts "can" reach each other or themselves automatically
          And there is no duplication in the "known_hosts" files
          And there is no duplication in the "authorized_keys" files

    @concourse_cluster
    Scenario: additional hosts may be added after initial run
        Given the hdbssh-exkeys master host is set to "mdw"
          And the hdbssh-exkeys segment host is set to "sdw1,sdw2,sdw3"
          And all SSH configurations are backed up and stripped
          And the segments can only be accessed using the master key
          And there is no duplication in the "authorized_keys" files
         Then all hosts "cannot" reach each other or themselves automatically

         When hdbssh-exkeys is run successfully on hosts "sdw1,sdw2"
        Given the hdbssh-exkeys segment host is set to "sdw1,sdw2"
         Then all hosts "can" reach each other or themselves automatically

         When hdbssh-exkeys is run successfully on additional hosts "sdw3"
        Given the hdbssh-exkeys segment host is set to "sdw1,sdw2,sdw3"
         Then all hosts "can" reach each other or themselves automatically
          And there is no duplication in the "known_hosts" files
          And there is no duplication in the "authorized_keys" files

    @concourse_cluster
    Scenario: hostfiles are accepted as well
        Given the hdbssh-exkeys master host is set to "mdw"
          And the hdbssh-exkeys segment host is set to "sdw1,sdw2,sdw3"
          And all SSH configurations are backed up and stripped
          And the segments can only be accessed using the master key
          And there is no duplication in the "authorized_keys" files
         Then all hosts "cannot" reach each other or themselves automatically

         When hdbssh-exkeys is run successfully with a hostfile
         Then all hosts "can" reach each other or themselves automatically

    @skip
    @concourse_cluster
    Scenario: IPv6 addresses are accepted
        Given the hdbssh-exkeys master host is set to "mdw"
          And the hdbssh-exkeys segment host is set to "sdw1,sdw2,sdw3"
          And all SSH configurations are backed up and stripped
          And the segments can only be accessed using the master key
          And there is no duplication in the "authorized_keys" files
         Then all hosts "cannot" reach each other or themselves automatically

         When hdbssh-exkeys is run successfully with IPv6 addresses
         Then all hosts "can" reach each other or themselves automatically
