@hdbload
Feature: hdbload tests

    Scenario: hdbload data test
        Given the database is running
	And the user runs command "cp ./bin/gpload_test/hdbload/test.csv /tmp/test.csv"
	And the user runs command "dropdb testdb ; createdb testdb"
	And the user runs command "psql -f ./bin/gpload_test/hdbload/test.sql -d testdb -h mdw -p 6000"
	And the user runs command "hdbload -f ./bin/gpload_test/hdbload/hdbload.yml"
	And the user runs command "psql -c 'SELECT * FROM test' -d testdb -h mdw -p 6000"
	Then psql should print "id |  name" escaped to stdout
        And psql should print "5 | aaaaaa" escaped to stdout
	And psql should print "6 | bbbbb" escaped to stdout
	And psql should print "7 | cccccc" escaped to stdout
	And psql should print "8 | ddddd" escaped to stdout
