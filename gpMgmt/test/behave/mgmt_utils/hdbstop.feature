@hdbstop
Feature: hdbstop behave tests

    @concourse_cluster
    @demo_cluster
    Scenario: hdbstop succeeds
        Given the database is running
         When the user runs "hdbstop -a"
	 Then hdbstop should return a return code of 0
	 And hdbstop should print "Starting hdbstop with args:" to stdout
	 And hdbstop should print "Obtaining HDB Master catalog information" to stdout
	 And hdbstop should print "HDB Version:" to stdout

    @concourse_cluster
    @demo_cluster
    Scenario: when there are user connections hdbstop waits to shutdown until user switches to fast mode
        Given the database is running
          And the user asynchronously runs "psql postgres" and the process is saved
         When the user runs hdbstop -a -t 4 --skipvalidation and selects f
          And hdbstop should print "'\(s\)mart_mode', '\(f\)ast_mode', '\(i\)mmediate_mode'" to stdout
         Then hdbstop should return a return code of 0

    @concourse_cluster
    @demo_cluster
    Scenario: when there are user connections hdbstop waits to shutdown until user connections are disconnected
        Given the database is running
          And the user asynchronously runs "psql postgres" and the process is saved
          And the user asynchronously sets up to end that process in 6 seconds
         When the user runs hdbstop -a -t 2 --skipvalidation and selects s
          And hdbstop should print "There were 1 user connections at the start of the shutdown" to stdout
          And hdbstop should print "'\(s\)mart_mode', '\(f\)ast_mode', '\(i\)mmediate_mode'" to stdout
         Then hdbstop should return a return code of 0

    @concourse_cluster
    @demo_cluster
    Scenario: The number of segments to stop in parallel
	Given the database is running
         When the user runs "hdbstop -aB 32"
	 Then hdbstop should return a return code of 0
	  And hdbstop should print "Starting hdbstop with args:" to stdout
	  And hdbstop should print "Obtaining HDB Master catalog information" to stdout
	  And hdbstop should print "HDB Version:" to stdout

    @concourse_cluster
    @demo_cluster
    Scenario: The master host data directory.
	Given the database is running
         When the user runs "hdbstop -ad $MASTER_DATA_DIRECTORY"
	 Then hdbstop should return a return code of 0
	  And hdbstop should print "Starting hdbstop with args:" to stdout
	  And hdbstop should print "Obtaining HDB Master catalog information" to stdout
	  And hdbstop should print "HDB Version:" to stdout

    @concourse_cluster
    @demo_cluster
    Scenario: The directory to write the log file.   
	Given the database is running
	 When the user runs "hdbstop -al ./"   
	 Then hdbstop should return a return code of 0       
	  And hdbstop should print "Starting hdbstop with args:" to stdout                     
	  And hdbstop should print "Obtaining HDB Master catalog information" to stdout       
	  And hdbstop should print "HDB Version:" to stdout     

    @concourse_cluster
    @demo_cluster
	Scenario: Shuts down a master instance that was started in maintenance mode.
        Given the database is running 
	When the user runs "hdbstop -am"                             
	Then hdbstop should return a return code of 0
	And hdbstop should print "Starting hdbstop with args:" to stdout                       
	And hdbstop should print "Obtaining HDB Master catalog information" to stdout         
	And hdbstop should print "HDB Version:" to stdout            

    @concourse_cluster
    @demo_cluster
    Scenario: Fast shut down. Any transactions in progress are interrupted and rolled back.    
        Given the database is running        
	 When the user runs "hdbstop -aM fast"                                         
	 Then hdbstop should return a return code of 0      
	 And hdbstop should print "Starting hdbstop with args:" to stdout   
	 And hdbstop should print "Obtaining HDB Master catalog information" to stdout 
	 And hdbstop should print "HDB Version:" to stdout 

    @concourse_cluster
    @demo_cluster
    Scenario: Immediate shut down.
	Given the database is running       
	When the user runs "hdbstop -aM immediate"         
	Then hdbstop should return a return code of 0        
	And hdbstop should print "Starting hdbstop with args:" to stdout                       
	And hdbstop should print "Obtaining HDB Master catalog information" to stdout          
	And hdbstop should print "HDB Version:" to stdout         

    @concourse_cluster
    @demo_cluster
    Scenario: Smart shut down. 
	Given the database is running            
	When the user runs "hdbstop -aM smart"                                     
	Then hdbstop should return a return code of 0       
	And hdbstop should print "Starting hdbstop with args:" to stdout     
	And hdbstop should print "Obtaining HDB Master catalog information" to stdout   
	And hdbstop should print "HDB Version:" to stdout      

    @concourse_cluster
    @demo_cluster
    Scenario: Run in quiet mode.     
	Given the database is running         
	When the user runs "hdbstop -aq"       
	Then hdbstop should return a return code of 0        
    
    @base
    @concourse_cluster
    @demo_cluster
    Scenario: Restart after shutdown is complete.
	Given the database is running          
	#When the user runs "hdbstop -r"                                         
	When the user runs "hdbstop -a"
	Then hdbstop should return a return code of 0
       	 And hdbstop should print "Starting hdbstop with args:" to stdout        
	 And hdbstop should print "Obtaining HDB Master catalog information" to stdout  
	 And hdbstop should print "HDB Version:" to stdout            

    @concourse_cluster
    @demo_cluster
    Scenario: Specifies a timeout threshold (in seconds) to wait for a segment instance to shutdown. 
	Given the database is running  
	When the user runs "hdbstop -at 320"       
	Then hdbstop should return a return code of 0            
	And hdbstop should print "Starting hdbstop with args:" to stdout      
	And hdbstop should print "Obtaining HDB Master catalog information" to stdout     
	And hdbstop should print "HDB Version:" to stdout    

    @concourse_cluster
    @demo_cluster
	Scenario: This option reloads the pg_hba.conf files of the master and segments and the runtime parameters of the postgresql.conf files but does not shutdown the inHybrid Database array.
	Given the database is running    
	#When the user runs "hdbstop -au"                                         
	When the user runs "hdbstop -a"
	Then hdbstop should return a return code of 0       
	And hdbstop should print "Starting hdbstop with args:" to stdout      
	And hdbstop should print "Obtaining HDB Master catalog information" to stdout  
	And hdbstop should print "HDB Version:" to stdout      

    @concourse_cluster
    @demo_cluster
    Scenario: Do not stop the standby master process.
	Given the database is running    
	When the user runs "hdbstop -ay"  
	Then hdbstop should return a return code of 0    
	And hdbstop should print "Starting hdbstop with args:" to stdout      
	And hdbstop should print "Obtaining HDB Master catalog information" to stdout
	And hdbstop should print "HDB Version:" to stdout          
    
    @stopv
    @concourse_cluster
    @demo_cluster
    Scenario: Optional. The master host data directory.
	Given the database is running
         When the user runs "hdbstop -v -a"
         Then hdbstop should return a return code of 0
          And hdbstop should print "Starting hdbstop with args: -v" to stdout
          And hdbstop should print "Checking that current user can use HTAP binaries" to stdout
	  And hdbstop should print "Obtaining HDB Master catalog information" to stdout
	  And hdbstop should print "HDB Version" to stdout
	  And hdbstop should print "No leftover hdbmmon process found" to stdout
	
    @version
    @concourse_cluster
    @demo_cluster
    Scenario: Displays the version of this utility.
       Given the database is running
         And a mirror has crashed
         And the database is not running
	 When the user runs "hdbstart --version"
         Then hdbstart should return a return code of 0
	 And hdbstart should print "hdbstart version" to stdout

    @stophelp
    @concourse_cluster
    @demo_cluster
    Scenario: Displays the online help.
        Given the database is running
	  And a mirror has crashed
	  And the database is not running
	  When the user runs "hdbstop --help"
	  Then hdbstop should return a return code of 0
	  And hdbstart should print "inHybrid" to stdout				
	  And hdbstop should print "hdbstop" to stdout
	  And hdbstop should print "hdbstop --version" to stdout
