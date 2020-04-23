@ecpg
Feature: ecpg test

    Scenario: ecpg version test
	When the user runs command "ecpg --version"
	Then ecpg --version should return a return code of 0
	Then ecpg --version should print "ecpg (PostgreSQL 9.4.24) 4.10.0" escaped to stdout

	Scenario: ecpg help test
	When the user runs command "ecpg --help"
	Then ecpg --help should return a return code of 0
	Then ecpg --help should print "ecpg is the PostgreSQL embedded SQL preprocessor for C programs." to stdout
    Then ecpg --help should print "ecpg [OPTION]... FILE..." escaped to stdout
	Then ecpg --help should print "search DIRECTORY for include files" to stdout
	Then ecpg --help should print "Report bugs to <bugs@inspur.com>." to stdout