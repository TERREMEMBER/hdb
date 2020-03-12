package Commoninfo;
use warnings;
use strict;
#################################clusterdb###########################################
our $clusterdb_help = "clusterdb clusters all previously clustered tables in a database.\
\
Usage:\
  clusterdb [OPTION]... [DBNAME]\
\
Options:\
  -a, --all                 cluster all databases\
  -d, --dbname=DBNAME       database to cluster\
  -e, --echo                show the commands being sent to the server\
  -q, --quiet               don't write any messages\
  -t, --table=TABLE         cluster specific table(s) only\
  -v, --verbose             write a lot of output\
  -V, --version             output version information, then exit\
  -?, --help                show this help, then exit\
\
Connection options:\
  -h, --host=HOSTNAME       database server host or socket directory\
  -p, --port=PORT           database server port\
  -U, --username=USERNAME   user name to connect as\
  -w, --no-password         never prompt for password\
  -W, --password            force password prompt\
  --maintenance-db=DBNAME   alternate maintenance database\
\
Read the description of the SQL command CLUSTER for details.\
\
Report bugs to <bugs\@greenplum.org>.";
our $clusterdb_version = "clusterdb (Greenplum Database) 9.4.24";

###############################createuser###########################################
###############################createlang###########################################

#############################help_info:two-dimensional array#######################
our @help_info=(
["clusterdb", $clusterdb_help],
["createuser", "createuser help info"],
["createlang", "createlang help info"],
);
#############################version_info:two-dimensional array####################
our @version_info=(
["clusterdb", $clusterdb_version],
["createuser", "createuser help info"],
["createlang", "createlang help info"],
);
