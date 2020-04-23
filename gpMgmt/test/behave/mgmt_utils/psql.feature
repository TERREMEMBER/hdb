@psql
Feature: psql test

    Scenario: psql version test
	When the user runs command "psql --version"
	Then psql --version should return a return code of 0
	Then psql --version should print "psql (PostgreSQL) 9.4.24" escaped to stdout

	Scenario: psql help test
	When the user runs command "psql --help"
	Then psql --help should return a return code of 0
	Then psql --help should print "psql is the PostgreSQL interactive terminal (inHybrid version)." escaped to stdout
    Then psql --help should print "psql [OPTION]... [DBNAME [USERNAME]]" escaped to stdout
	Then psql --help should print "Report bugs to <bugs@inspur.com>." to stdout

    Scenario: psql copyright test
	Given a standard local demo cluster is running
	When the user runs command "psql -c \\copyright -p 6000 -d postgres"
	Then psql should return a return code of 0
	Then psql should print "inHybrid Database version of PostgreSQL Database Management System" to stdout
    Then psql should print "Portions Copyright (c) 2020-Present Inspur Software Technology co.LTD" escaped to stdout
	Then psql should print "This software is based on Postgres95" to stdout