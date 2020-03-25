@gpstart
Feature: gpstart behave tests

    @concourse_cluster
    @demo_cluster
    Scenario: hdbstart correctly identifies down segments
        Given the database is running
          And a mirror has crashed
          And the database is not running
         When the user runs "hdbstart -a"
	 Then hdbstart should return a return code of 0
          And hdbstart should print "Skipping startup of segment marked down in configuration" to stdout
	  And hdbstart should print "HDB Catalog Version:" to stdout
	  And hdbstart should print "HDB Binary Version: " to stdout
	  And hdbstart should print "Obtaining HDB Master catalog information" to stdout
          And hdbstart should print "Skipped segment starts \(segments are marked down in configuration\) += 1" to stdout
          And hdbstart should print "Successfully started [0-9]+ of [0-9]+ segment instances, skipped 1 other segments" to stdout
	  And hdbstart should print "Number of segments not attempted to start: 1" to stdout
    
     @concourse_cluster
     @demo_cluster
     Scenario: The number of segments to start in parallel
	 Given the database is running
	   And a mirror has crashed
	   And the database is not running
	  When the user runs "hdbstart -aB 2"
	  Then hdbstart should return a return code of 0
	   And hdbstart should print "Skipping startup of segment marked down in configuration" to stdout
	   And hdbstart should print "HDB Catalog Version:" to stdout
	   And hdbstart should print "HDB Binary Version: " to stdout
	   And hdbstart should print "Obtaining HDB Master catalog information" to stdout
	   And hdbstart should print "Skipped segment starts \(segments are marked down in configuration\) += 1" to stdout
	   And hdbstart should print "Successfully started [0-9]+ of [0-9]+ segment instances, skipped 1 other segments" to stdout
	   And hdbstart should print "Number of segments not attempted to start: 1" to stdout
    
     @concourse_cluster
     @demo_cluster
     Scenario: Optional. The master host data directory.
	 Given the database is running
	 And a mirror has crashed
	 And the database is not running
	When the user runs "hdbstart -ad $MASTER_DATA_DIRECTORY"
	Then hdbstart should return a return code of 0
	 And hdbstart should print "Skipping startup of segment marked down in configuration" to stdout
	 And hdbstart should print "HDB Catalog Version:" to stdout
	 And hdbstart should print "HDB Binary Version: " to stdout
	 And hdbstart should print "Obtaining HDB Master catalog information" to stdout
	 And hdbstart should print "Skipped segment starts \(segments are marked down in configuration\) += 1" to stdout
	 And hdbstart should print "Successfully started [0-9]+ of [0-9]+ segment instances, skipped 1 other segments" to stdout
	 And hdbstart should print "Number of segments not attempted to start: 1" to stdout

     @concourse_cluster
     @demo_cluster
     Scenario: The directory to write the log file. Defaults to ~/gpAdminLogs
         Given the database is running
           And a mirror has crashed
           And the database is not running
          When the user runs "hdbstart -al ./"
          Then hdbstart should return a return code of 0
           And hdbstart should print "HDB Catalog Version:" to stdout
           And hdbstart should print "HDB Binary Version: " to stdout
	   And hdbstart should print "Obtaining HDB Master catalog information" to stdout
	   And hdbstart should print "Skipped segment starts \(segments are marked down in configuration\) += 1" to stdout
	   And hdbstart should print "Successfully started [0-9]+ of [0-9]+ segment instances, skipped 1 other segments" to stdout						
	   And hdbstart should print "Number of segments not attempted to start: 1" to stdout

     @concourse_cluster
     @demo_cluster
     Scenario: Starts the master instance only, which may be useful for maintenance tasks.
         Given the database is running
           And a mirror has crashed
           And the database is not running
	   When the user runs "hdbstart -a"
	   # When the user runs "hdbstart -am"
          Then hdbstart should return a return code of 0
           And hdbstart should print "HDB Catalog Version:" to stdout
           And hdbstart should print "HDB Binary Version: " to stdout
           And hdbstart should print "Obtaining HDB Master catalog information" to stdout
           And hdbstart should print "Skipped segment starts \(segments are marked down in configuration\) += 1" to stdout 
	   And hdbstart should print "Successfully started [0-9]+ of [0-9]+ segment instances, skipped 1 other segments" to stdout
	   And hdbstart should print "Number of segments not attempted to start: 1" to stdout

     @concourse_cluster
     @demo_cluster
     Scenario: The directory to write the log file.
         Given the database is running
           And a mirror has crashed
	   And the database is not running
	   When the user runs "hdbstart -aq"
	   Then hdbstart should return a return code of 0

     @restart
     @concourse_cluster
     @demo_cluster
     Scenario: Starts Database in restricted mode
	Given the database is running
	And a mirror has crashed
	And the database is not running
	When the user runs "hdbstart -aR"
	Then hdbstart should return a return code of 0
	And hdbstart should print "Skipping startup of segment marked down in configuration" to stdout
	And hdbstart should print "HDB Catalog Version:" to stdout
	And hdbstart should print "HDB Binary Version: " to stdout
	And hdbstart should print "Obtaining HDB Master catalog information" to stdout
	And hdbstart should print "Skipped segment starts \(segments are marked down in configuration\) += 1" to stdout
	And hdbstart should print "Successfully started [0-9]+ of [0-9]+ segment instances, skipped 1 other segments" to stdout
	And hdbstart should print "Number of segments not attempted to start: 1" to stdout

     @concourse_cluster
     @demo_cluster
     Scenario: Specifies a timeout in seconds to wait for a segment instance to start up.
	Given the database is running               
	And a mirror has crashed                               
	And the database is not running 
	When the user runs "hdbstart -at 200"
	Then hdbstart should return a return code of 0
	And hdbstart should print "Skipping startup of segment marked down in configuration" to stdout
	And hdbstart should print "HDB Catalog Version:" to stdout
	And hdbstart should print "HDB Binary Version: " to stdout
	And hdbstart should print "Obtaining HDB Master catalog information" to stdout
	And hdbstart should print "Skipped segment starts \(segments are marked down in configuration\) += 1" to stdout
	And hdbstart should print "Successfully started [0-9]+ of [0-9]+ segment instances, skipped 1 other segments" to stdout
	And hdbstart should print "Number of segments not attempted to start: 1" to stdout

     @concourse_cluster
     @demo_cluster       
	Scenario: Optional. Do not start the standby master host. The default is to start the standby master host and synchronization process.
	    Given the database is running                           
	    And a mirror has crashed                                                          
	    And the database is not running     
	    When the user runs "hdbstart -ay "
	    Then hdbstart should return a return code of 0                                   
	    And hdbstart should print "Skipping startup of segment marked down in configuration" to stdout                                                  
	    And hdbstart should print "HDB Catalog Version:" to stdout                         
	    And hdbstart should print "HDB Binary Version: " to stdout  
	    And hdbstart should print "Obtaining HDB Master catalog information" to stdout  
	    And hdbstart should print "Skipped segment starts \(segments are marked down in configuration\) += 1" to stdout                                                                   
	    And hdbstart should print "Successfully started [0-9]+ of [0-9]+ segment instances, skipped 1 other segments" to stdout  
	    And hdbstart should print "Number of segments not attempted to start: 1" to stdout

      @concourse_cluster
      @demo_cluster       
      Scenario: 
	  Given the database is running
	    And a mirror has crashed
            And the database is not running
	   When the user runs "hdbstart --version"
           Then hdbstart should return a return code of 0
	    And hdbstart should print "hdbstart version" to stdout

     @starthelp
     @concourse_cluster
     @demo_cluster
     Scenario: Optional. The master host data directory.
	 Given the database is running
           And a mirror has crashed
	   And the database is not running
          When the user runs "hdbstart --help"
          Then hdbstart should return a return code of 0
	  And hdbstart should print "hdbstart" to stdout
	   And hdbstart should print "Starts a inHybrid Database system." to stdout
		
     @startv
     @concourse_cluster
     @demo_cluster
     Scenario: Optional. The master host data directory.
	Given the database is running
	  And a mirror has crashed
          And the database is not running
         When the user runs "hdbstart -v -a"
         Then hdbstart should return a return code of 0
          And hdbstart should print "Starting hdbstart with args: -v" to stdout
          And hdbstart should print "Checking that current user can use HTAP binaries" to stdout
          And hdbstart should print "HDB Binary Version" to stdout
	  And hdbstart should print "HDB Catalog Version" to stdout
          And hdbstart should print "Obtaining HDB Master catalog information" to stdout 
	  And hdbstart should print "Starting hdbstop with args" to stdout
          And hdbstart should print "HDB Version" to stdout
          And hdbstart should print "hdbarray does have mirrors" to stdout
