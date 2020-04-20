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
###############################dropdb###########################################
our $dropdb_help = "dropdb removes a PostgreSQL database.\
\
Usage:\
  dropdb [OPTION]... DBNAME\
\
Options:\
  -e, --echo                show the commands being sent to the server\
  -i, --interactive         prompt before deleting anything\
  -V, --version             output version information, then exit\
  --if-exists               don't report error if database doesn't exist\
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
Report bugs to <bugs\@inspur.com>.\n";
our $dropdb_version = "dropdb (inHybrid Database) 9.4.24\n";
###############################createuser###########################################
our $createuser_help = "createuser creates a new PostgreSQL role.\
\
Usage:\
  createuser [OPTION]... [ROLENAME]\
\
Options:\
  -c, --connection-limit=N  connection limit for role (default: no limit)\
  -d, --createdb            role can create new databases\
  -D, --no-createdb         role cannot create databases (default)\
  -e, --echo                show the commands being sent to the server\
  -E, --encrypted           encrypt stored password\
  -g, --role=ROLE           new role will be a member of this role\
  -i, --inherit             role inherits privileges of roles it is a\
                            member of (default)\
  -I, --no-inherit          role does not inherit privileges\
  -l, --login               role can login (default)\
  -L, --no-login            role cannot login\
  -N, --unencrypted         do not encrypt stored password\
  -P, --pwprompt            assign a password to new role\
  -r, --createrole          role can create new roles\
  -R, --no-createrole       role cannot create roles (default)\
  -s, --superuser           role will be superuser\
  -S, --no-superuser        role will not be superuser (default)\
  -V, --version             output version information, then exit\
  --interactive             prompt for missing role name and attributes rather\
                            than using defaults\
  --replication             role can initiate replication\
  --no-replication          role cannot initiate replication\
  -?, --help                show this help, then exit\
\
Connection options:\
  -h, --host=HOSTNAME       database server host or socket directory\
  -p, --port=PORT           database server port\
  -U, --username=USERNAME   user name to connect as (not the one to create)\
  -w, --no-password         never prompt for password\
  -W, --password            force password prompt\
\
Report bugs to <bugs\@inspur.com>.\n";
our $createuser_version = "createuser (inHybrid Database) 9.4.24\n";
###############################dropuser###########################################
our $dropuser_help = "dropuser removes a PostgreSQL role.\
\
Usage:\
  dropuser [OPTION]... [ROLENAME]\
\
Options:\
  -e, --echo                show the commands being sent to the server\
  -i, --interactive         prompt before deleting anything, and prompt for\
                            role name if not specified\
  -V, --version             output version information, then exit\
  --if-exists               don't report error if user doesn't exist\
  -?, --help                show this help, then exit\
\
Connection options:\
  -h, --host=HOSTNAME       database server host or socket directory\
  -p, --port=PORT           database server port\
  -U, --username=USERNAME   user name to connect as (not the one to drop)\
  -w, --no-password         never prompt for password\
  -W, --password            force password prompt\
\
Report bugs to <bugs\@inspur.com>.\n";
our $dropuser_version = "dropuser (inHybrid Database) 9.4.24\n";
###############################createlang###########################################
our $createlang_help = "createlang installs a procedural language into a PostgreSQL database.\
\
Usage:\
  createlang [OPTION]... LANGNAME [DBNAME]\
\
Options:\
  -d, --dbname=DBNAME       database to install language in\
  -e, --echo                show the commands being sent to the server\
  -l, --list                show a list of currently installed languages\
  -V, --version             output version information, then exit\
  -?, --help                show this help, then exit\
\
Connection options:\
  -h, --host=HOSTNAME       database server host or socket directory\
  -p, --port=PORT           database server port\
  -U, --username=USERNAME   user name to connect as\
  -w, --no-password         never prompt for password\
  -W, --password            force password prompt\
\
Report bugs to <bugs\@inspur.com>.\n";
our $createlang_version = "createlang (inHybrid Database) 9.4.24\n";
###############################droplang###########################################
our $droplang_help = "droplang removes a procedural language from a database.\
\
Usage:
  droplang [OPTION]... LANGNAME [DBNAME]\
\
Options:\
  -d, --dbname=DBNAME       database from which to remove the language\
  -e, --echo                show the commands being sent to the server\
  -l, --list                show a list of currently installed languages\
  -V, --version             output version information, then exit\
  -?, --help                show this help, then exit\
\
Connection options:\
  -h, --host=HOSTNAME       database server host or socket directory\
  -p, --port=PORT           database server port\
  -U, --username=USERNAME   user name to connect as\
  -w, --no-password         never prompt for password\
  -W, --password            force password prompt\
\
Report bugs to <bugs\@inspur.com>.\n";
our $droplang_version = "droplang (inHybrid Database) 9.4.24\n";
###############################pg_isready###########################################
our $pg_isready_help = "pg_isready issues a connection check to a PostgreSQL database.\
\
Usage:\
  pg_isready [OPTION]...\
\
Options:\
  -d, --dbname=DBNAME      database name\
  -q, --quiet              run quietly\
  -V, --version            output version information, then exit\
  -?, --help               show this help, then exit\
\
Connection options:\
  -h, --host=HOSTNAME      database server host or socket directory\
  -p, --port=PORT          database server port\
  -t, --timeout=SECS       seconds to wait when attempting connection, 0 disables (default: 3)\
  -U, --username=USERNAME  user name to connect as\
\
Report bugs to <pgsql-bugs\@inspur.com>.\n";
our $pg_isready_version = "pg_isready (inHybrid Database) 9.4.24\n";
###############################reindexdb###########################################
our $reindexdb_help = "reindexdb reindexes a PostgreSQL database.\
\
Usage:\
  reindexdb [OPTION]... [DBNAME]\
\
Options:\
  -a, --all                 reindex all databases\
  -d, --dbname=DBNAME       database to reindex\
  -e, --echo                show the commands being sent to the server\
  -i, --index=INDEX         recreate specific index(es) only\
  -q, --quiet               don't write any messages\
  -s, --system              reindex system catalogs\
  -t, --table=TABLE         reindex specific table(s) only\
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
Read the description of the SQL command REINDEX for details.\
\
Report bugs to <bugs\@inspur.com>.\n";
our $reindexdb_version = "reindexdb (inHybrid Database) 9.4.24\n";
###############################vacuumdb###########################################
our $vacuumdb_help = "vacuumdb cleans and analyzes a PostgreSQL database.\
\
Usage:\
  vacuumdb [OPTION]... [DBNAME]\
\
Options:\
  -a, --all                       vacuum all databases\
  -d, --dbname=DBNAME             database to vacuum\
  -e, --echo                      show the commands being sent to the server\
  -f, --full                      do full vacuuming\
  -F, --freeze                    freeze row transaction information\
  -q, --quiet                     don't write any messages\
  -t, --table='TABLE[(COLUMNS)]'  vacuum specific table(s) only\
  -v, --verbose                   write a lot of output\
  -V, --version                   output version information, then exit\
  -z, --analyze                   update optimizer statistics\
  -Z, --analyze-only              only update optimizer statistics\
      --analyze-in-stages         only update optimizer statistics, in multiple\
                                  stages for faster results\
  -?, --help                      show this help, then exit\
\
Connection options:\
  -h, --host=HOSTNAME       database server host or socket directory\
  -p, --port=PORT           database server port\
  -U, --username=USERNAME   user name to connect as\
  -w, --no-password         never prompt for password\
  -W, --password            force password prompt\
  --maintenance-db=DBNAME   alternate maintenance database\
\
Read the description of the SQL command VACUUM for details.\
\
Report bugs to <bugs\@inspur.com>.\n";
our $vacuumdb_version = "vacuumdb (inHybrid Database) 9.4.24\n";
#############################pg_config############################################
our $pg_config_help = "\
pg_config provides information about the installed version of PostgreSQL.\
\
Usage:\
  pg_config [OPTION]...\
\
Options:\
  --bindir              show location of user executables\
  --docdir              show location of documentation files\
  --htmldir             show location of HTML documentation files\
  --includedir          show location of C header files of the client\
                        interfaces\
  --pkgincludedir       show location of other C header files\
  --includedir-server   show location of C header files for the server\
  --libdir              show location of object code libraries\
  --pkglibdir           show location of dynamically loadable modules\
  --localedir           show location of locale support files\
  --mandir              show location of manual pages\
  --sharedir            show location of architecture-independent support files\
  --sysconfdir          show location of system-wide configuration files\
  --pgxs                show location of extension makefile\
  --configure           show options given to \"configure\" script when\
                        PostgreSQL was built\
  --cc                  show CC value used when PostgreSQL was built\
  --cppflags            show CPPFLAGS value used when PostgreSQL was built\
  --cflags              show CFLAGS value used when PostgreSQL was built\
  --cflags_sl           show CFLAGS_SL value used when PostgreSQL was built\
  --ldflags             show LDFLAGS value used when PostgreSQL was built\
  --ldflags_ex          show LDFLAGS_EX value used when PostgreSQL was built\
  --ldflags_sl          show LDFLAGS_SL value used when PostgreSQL was built\
  --libs                show LIBS value used when PostgreSQL was built\
  --version             show the PostgreSQL version\
  -?, --help            show this help, then exit\
\
With no arguments, all known items are shown.\
\
Report bugs to <bugs\@inspur.com>.\n";
our $pg_config_version = "PostgreSQL 9.4.24\n";
#############################help_info:two-dimensional array#######################
our @help_info=(
["clusterdb", $clusterdb_help],
["createdb", $createdb_help],
["dropdb", $dropdb_help],
["createuser", $createuser_help],
["dropuser", $dropuser_help],
["createlang", $createlang_help],
["droplang", $droplang_help],
["pg_isready", $pg_isready_help],
["reindexdb", $reindexdb_help],
["vacuumdb", $vacuumdb_help],
["pg_config",$pg_config_help]
);
#############################version_info:two-dimensional array####################
our @version_info=(
["clusterdb", $clusterdb_version],
["createdb", $createdb_version],
["dropdb", $dropdb_version],
["createuser", $createuser_version],
["dropuser", $dropuser_version],
["createlang", $createlang_version],
["droplang", $droplang_version],
["pg_isready", $pg_isready_version],
["reindexdb", $reindexdb_version],
["vacuumdb", $vacuumdb_version],
["pg_config",$pg_config_version]
);
