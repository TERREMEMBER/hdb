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
Report bugs to <bugs\@inspur.com>.\n";
our $clusterdb_version = "clusterdb (inHybrid Database) 9.4.24\n";



###############################createdb###########################################
our $createdb_help = "createdb creates a PostgreSQL database.\
\
Usage:\
  createdb [OPTION]... [DBNAME] [DESCRIPTION]\
\
Options:\
  -D, --tablespace=TABLESPACE  default tablespace for the database\
  -e, --echo                   show the commands being sent to the server\
  -E, --encoding=ENCODING      encoding for the database\
  -l, --locale=LOCALE          locale settings for the database\
      --lc-collate=LOCALE      LC_COLLATE setting for the database\
      --lc-ctype=LOCALE        LC_CTYPE setting for the database\
  -O, --owner=OWNER            database user to own the new database\
  -T, --template=TEMPLATE      template database to copy\
  -V, --version                output version information, then exit\
  -?, --help                   show this help, then exit\
\
Connection options:\
  -h, --host=HOSTNAME          database server host or socket directory\
  -p, --port=PORT              database server port\
  -U, --username=USERNAME      user name to connect as\
  -w, --no-password            never prompt for password\
  -W, --password               force password prompt\
  --maintenance-db=DBNAME      alternate maintenance database\
\
By default, a database with the same name as the current user is created.\
\
Report bugs to <bugs\@inspur.com>.\n";
our $createdb_version = "createdb (inHybrid Database) 9.4.24\n";
###############################createlang###########################################

#############################help_info:two-dimensional array#######################
our @help_info=(
["clusterdb", $clusterdb_help],
["createdb", $createdb_help],
["createlang", "createlang help info"],
);
#############################version_info:two-dimensional array####################
our @version_info=(
["clusterdb", $clusterdb_version],
["createdb", $createdb_version],
["createlang", "createlang help info"],
);
