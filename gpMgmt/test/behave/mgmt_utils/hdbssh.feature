@hdbssh
Feature: hdbssh behave tests

    Scenario: hdbssh -d and -t options
        When the user runs "hdbssh -v -h localhost hostname"
        Then hdbssh should return a return code of 0
        And hdbssh should print "delaybeforesend 0.05 and prompt_validation_timeout 1.0" to stdout
        When the user runs "hdbssh -v -h localhost -d 0.051 -t 1.01 hostname"
        Then hdbssh should return a return code of 0
        And hdbssh should print "Skip parsing hdbssh.conf" to stdout
        When the user runs "hdbssh -v -h localhost -d -1 hostname"
        Then hdbssh should return a return code of 1
        And hdbssh should print "delaybeforesend cannot be negative" to stdout
        When the user runs "hdbssh -v -h localhost -t 0 hostname"
        Then hdbssh should return a return code of 1
        And hdbssh should print "prompt_validation_timeout cannot be negative or zero" to stdout

    Scenario: hdbssh exceptions
        When the user runs "hdbssh -h xfoobarx hostname"
        Then hdbssh should return a return code of 0
        And hdbssh should print "Could not acquire connection" to stdout
        When the user runs "hdbssh -h localhost -d 0 -t 0.000001 hostname"
        Then hdbssh should return a return code of 0
        And hdbssh should print "unable to login to localhost" to stdout
        And hdbssh should print "could not synchronize with original prompt" to stdout

    Scenario: hdbssh succeeds when network has latency
        When the user runs command "sudo tc qdisc add dev lo root netem delay 4000ms"
        Then sudo should return a return code of 0
        When the user runs "hdbssh -h localhost echo 'hello I am testing'"
        Then hdbssh should return a return code of 0
        And hdbssh should print "hello I am testing" to stdout
        # We depend on environment.py#after_scenario() to delete the artificial latency
