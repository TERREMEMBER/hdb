@hdbmapreduce
Feature: hdbmapreduce

    @hdbmapreduce_help
    Scenario: hdbmapreduce help info
    When the user runs "hdbmapreduce -?"
	 Then hdbmapreduce -? should return a return code of 0
	 And hdbmapreduce -? should print "hdbmapreduce - inHybrid Map/Reduce Driver" to stdout
	 And hdbmapreduce -? should print "-x | --explain" to stdout
	 And hdbmapreduce -? should print "--key <name>=<value>" to stdout
     And hdbmapreduce -? should print "database server host or socket directory" to stdout
     And hdbmapreduce -? should print "enable some debugging output" to stdout
    
    @hdbmapreduce_version
    Scenario: hdbmapreduce version info
    When the user runs "hdbmapreduce --version"
	 Then hdbmapreduce --version should return a return code of 0
	 And hdbmapreduce --version should print "hdbmapreduce - inHybrid Map/Reduce Driver 1.00b2" to stdout
 