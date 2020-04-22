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
#############################pg_rewind############################################
our $pg_rewind_help = "pg_rewind resynchronizes a PostgreSQL cluster with another copy of the cluster.\
\
Usage:\
  pg_rewind [OPTION]...\
\
Options:\
  -D, --target-pgdata=DIRECTORY  existing data directory to modify\
      --source-pgdata=DIRECTORY  source data directory to synchronize with\
      --source-server=CONNSTR    source server to synchronize with\
  -R, --write-recovery-conf      write recovery.conf after backup\
  -S, --slot=SLOTNAME            replication slot to use\
  -n, --dry-run                  stop before modifying anything\
  -P, --progress                 write progress messages\
      --debug                    write a lot of debug messages\
  -V, --version                  output version information, then exit\
  -?, --help                     show this help, then exit\
\
Report bugs to <pgsql-bugs\@postgresql.org>.\n";
our $pg_rewind_version = "pg_rewind (inHybrid Database) 9.4.24\n";
#############################initdb############################################
our $initdb_help = "initdb initializes a PostgreSQL database cluster.

Usage:
  initdb [OPTION]... [DATADIR]

Options:
  -A, --auth=METHOD         default authentication method for local connections
      --auth-host=METHOD    default authentication method for local TCP/IP connections
      --auth-local=METHOD   default authentication method for local-socket connections
 [-D, --pgdata=]DATADIR     location for this database cluster
  -E, --encoding=ENCODING   set default encoding for new databases
      --locale=LOCALE       set default locale for new databases
      --lc-collate=, --lc-ctype=, --lc-messages=LOCALE
      --lc-monetary=, --lc-numeric=, --lc-time=LOCALE
                            set default locale in the respective category for
                            new databases (default taken from environment)
      --no-locale           equivalent to --locale=C
      --pwfile=FILE         read password for the new superuser from file
  -T, --text-search-config=CFG
                            default text search configuration
  -U, --username=NAME       database superuser name
  -W, --pwprompt            prompt for a password for the new superuser
  -X, --xlogdir=XLOGDIR     location for the transaction log directory

Shared memory allocation:
  --max_connections=MAX-CONNECT  maximum number of allowed connections
  --shared_buffers=NBUFFERS number of shared buffers; or, amount of memory for
                            shared buffers if kB/MB/GB suffix is appended

Less commonly used options:
  -d, --debug               generate lots of debugging output
  -k, --data-checksums      use data page checksums
  -L DIRECTORY              where to find the input files
  -n, --noclean             do not clean up after errors
  -N, --nosync              do not wait for changes to be written safely to disk
  -s, --show                show internal settings
  -S, --sync-only           only sync data directory
  -m, --formirror           only create data needed to start the backend in mirror mode

Other options:
  -V, --version             output version information, then exit
      --hdb-version          output inHybrid version information, then exit
  -?, --help                show this help, then exit

If the data directory is not specified, the environment variable PGDATA
is used.

Report bugs to <bugs\@inspur.com>.\n";
our $initdb_version = "initdb (inHybrid Database) 9.4.24\n";
#############################pg_basebackup############################################
our $pg_basebackup_help = "pg_basebackup takes a base backup of a running PostgreSQL server.

Usage:
  pg_basebackup [OPTION]...

Options controlling the output:
  -D, --pgdata=DIRECTORY receive base backup into directory
  -F, --format=p|t       output format (plain (default), tar (Unsupported in GPDB))
  -r, --max-rate=RATE    maximum transfer rate to transfer data directory
                         (in kB/s, or use suffix \"k\" or \"M\")
  -R, --write-recovery-conf
                         write recovery.conf after backup
  -S, --slot=SLOTNAME    replication slot to use
  -T, --tablespace-mapping=OLDDIR=NEWDIR
                         relocate tablespace in OLDDIR to NEWDIR
  -x, --xlog             include required WAL files in backup (fetch mode)
  -X, --xlog-method=fetch|stream
                         include required WAL files with specified method
      --xlogdir=XLOGDIR  location for the transaction log directory
  -z, --gzip             compress tar output
  -Z, --compress=0-9     compress tar output with given compression level
  --target-gp-dbid       create tablespace subdirectories with given dbid

General options:
  -c, --checkpoint=fast|spread
                         set fast or spread checkpointing
  -l, --label=LABEL      set backup label
  -P, --progress         show progress information
  -v, --verbose          output verbose messages
  -V, --version          output version information, then exit
  -?, --help             show this help, then exit

Connection options:
  -d, --dbname=CONNSTR   connection string
  -h, --host=HOSTNAME    database server host or socket directory
  -p, --port=PORT        database server port number
  -s, --status-interval=INTERVAL
                         time between status packets sent to server (in seconds)
  -U, --username=NAME    connect as specified database user
  -w, --no-password      never prompt for password
  -W, --password         force password prompt (should happen automatically)
  -E, --exclude          exclude path names

Report bugs to <bugs\@inspur.com>.\n";
our $pg_basebackup_version = "pg_basebackup (PostgreSQL) 9.4.24\n";
#############################pg_receivexlog############################################
our $pg_receivexlog_help = "pg_receivexlog receives PostgreSQL streaming transaction logs.

Usage:
  pg_receivexlog [OPTION]...

Options:
  -D, --directory=DIR    receive transaction log files into this directory
  -n, --no-loop          do not loop on connection lost
  -s, --status-interval=SECS
                         time between status packets sent to server (default: 10)
  -S, --slot=SLOTNAME    replication slot to use
  -v, --verbose          output verbose messages
  -V, --version          output version information, then exit
  -?, --help             show this help, then exit

Connection options:
  -d, --dbname=CONNSTR   connection string
  -h, --host=HOSTNAME    database server host or socket directory
  -p, --port=PORT        database server port number
  -U, --username=NAME    connect as specified database user
  -w, --no-password      never prompt for password
  -W, --password         force password prompt (should happen automatically)

Report bugs to <bugs\@inspur.com>.\n";
our $pg_receivexlog_version = "pg_receivexlog (PostgreSQL) 9.4.24\n";
#############################pg_ctl############################################
our $pg_ctl_help = "pg_ctl is a utility to initialize, start, stop, or control a PostgreSQL server.

Usage:
  pg_ctl init[db]               [-D DATADIR] [-s] [-o \"OPTIONS\"]
  pg_ctl start   [-w] [-t SECS] [-D DATADIR] [-s] [-l FILENAME] [-o \"OPTIONS\"]
  pg_ctl stop    [-W] [-t SECS] [-D DATADIR] [-s] [-m SHUTDOWN-MODE]
  pg_ctl restart [-w] [-t SECS] [-D DATADIR] [-s] [-m SHUTDOWN-MODE]
                 [-o \"OPTIONS\"]
  pg_ctl reload  [-D DATADIR] [-s]
  pg_ctl status  [-D DATADIR]
  pg_ctl promote [-D DATADIR] [-s]
  pg_ctl kill    SIGNALNAME PID

Common options:
  -D, --pgdata=DATADIR   location of the database storage area
  -s, --silent           only print errors, no informational messages
  -t, --timeout=SECS     seconds to wait when using -w option
  -V, --version          output version information, then exit
  -w                     wait until operation completes
  -W                     do not wait until operation completes
  -?, --help             show this help, then exit
  --hdb-version           output inHybrid version information, then exit
(The default is to wait for shutdown, but not for start or restart.)

If the -D option is omitted, the environment variable PGDATA is used.

Options for start or restart:
  -c, --core-files       allow postgres to produce core files
  -l, --log=FILENAME     write (or append) server log to FILENAME
  -o OPTIONS             command line options to pass to postgres
                         (PostgreSQL server executable) or initdb
  -p PATH-TO-POSTGRES    normally not necessary

Options for stop or restart:
  -m, --mode=MODE        MODE can be \"smart\", \"fast\", or \"immediate\"

Shutdown modes are:
  smart       quit after all clients have disconnected
  fast        quit directly, with proper shutdown
  immediate   quit without complete shutdown; will lead to recovery on restart

Allowed signal names for kill:
  ABRT HUP INT QUIT TERM USR1 USR2

Report bugs to <bugs\@inspur.com>.\n";
our $pg_ctl_version = "pg_ctl (inHybrid Database) 9.4.24\n";
#############################pg_controldata############################################
our $pg_controldata_help = "pg_controldata displays control information of a PostgreSQL database cluster.

Usage:
  pg_controldata [OPTION] [DATADIR]

Options:
  -V, --version  output version information, then exit
  -?, --help     show this help, then exit
  --hdb-version   output inHybrid version information, then exit

If no data directory (DATADIR) is specified, the environment variable PGDATA
is used.

Report bugs to <bugs\@inspur.com>.\n";
our $pg_controldata_version = "pg_controldata (inHybrid Database) 9.4.24\n";
#############################pg_resetxlog############################################
our $pg_resetxlog_help = "pg_resetxlog resets the PostgreSQL transaction log.

Usage:
  pg_resetxlog [OPTION]... DATADIR

Options:
  -e XIDEPOCH      set next transaction ID epoch
  -f               force update to be done
  -k data_checksum_version     set data_checksum_version
  -l XLOGFILE      force minimum WAL starting location for new transaction log
  -m MXID,MXID     set next and oldest multitransaction ID
  -n               no update, just show what would be done (for testing)
  -o OID           set next OID
  -r RELFILENODE  set next RELFILENODE
  -O OFFSET        set next multitransaction offset
  -V, --version    output version information, then exit
  -x XID           set next transaction ID
  --system-identifier=ID
                   set database system identifier
  -?, --help       show this help, then exit
  --hdb-version    output inHybrid version information, then exit

Report bugs to <bugs\@inspur.com>.\n";
our $pg_resetxlog_version = "pg_resetxlog (inHybrid Database) 9.4.24\n";
#############################postgres############################################
our $postgres_help = "postgres is the PostgreSQL server.

Usage:
  postgres [OPTION]...

Options:
  -B NBUFFERS        number of shared buffers
  -c NAME=VALUE      set run-time parameter
  -C NAME            print value of run-time parameter, then exit
  -d 1-5             debugging level
  -D DATADIR         database directory
  -e                 use European date input format (DMY)
  -F                 turn fsync off
  -h HOSTNAME        host name or IP address to listen on
  -i                 enable TCP/IP connections
  -k DIRECTORY       Unix-domain socket location
  -N MAX-CONNECT     maximum number of allowed connections
  -o OPTIONS         pass \"OPTIONS\" to each server process (obsolete)
  -p PORT            port number to listen on
  -s                 show statistics after each query
  -S WORK-MEM        set amount of memory for sorts (in kB)
  -V, --version      output version information, then exit
  --NAME=VALUE       set run-time parameter
  --describe-config  describe configuration parameters, then exit
  -?, --help         show this help, then exit
  --hdb-version       output inHybrid version information, then exit
  --catalog-version  output the catalog version, then exit

Developer options:
  -f s|i|n|m|h       forbid use of some plan types
  -n                 do not reinitialize shared memory after abnormal exit
  -O                 allow system table structure changes
  -P                 disable system indexes
  -t pa|pl|ex        show timings after each query
  -T                 send SIGSTOP to all backend processes if one dies
  -W NUM             wait NUM seconds to allow attach from a debugger

Options for maintenance mode:
  -m              start the system in maintenance mode

Options for upgrade mode:
  -U              start the system in upgrade mode

Options for single-user mode:
  --single           selects single-user mode (must be first argument)
  DBNAME             database name (defaults to user name)
  -d 0-5             override debugging level
  -E                 echo statement before execution
  -j                 do not use newline as interactive query delimiter
  -r FILENAME        send stdout and stderr to given file

Options for bootstrapping mode:
  --boot             selects bootstrapping mode (must be first argument)
  DBNAME             database name (mandatory argument in bootstrapping mode)
  -r FILENAME        send stdout and stderr to given file
  -x NUM             internal use

Please read the documentation for the complete list of run-time
configuration settings and how to set them on the command line or in
the configuration file.

Report bugs to <bugs\@inspur.com>.\n";
our $postgres_version = "postgres (inHybrid Database) 9.4.24\n";
#############################pg_upgrade############################################
our $pg_upgrade_help = "pg_upgrade upgrades a inHybrid cluster to a different major version.

Usage:
  pg_upgrade [OPTION]...

Options:
  -b, --old-bindir=BINDIR       old cluster executable directory
  -B, --new-bindir=BINDIR       new cluster executable directory
  -c, --check                   check clusters only, don't change any data
  -d, --old-datadir=DATADIR     old cluster data directory
  -D, --new-datadir=DATADIR     new cluster data directory
  -j, --jobs                    number of simultaneous processes or threads to use
  -k, --link                    link instead of copying files to new cluster
  -o, --old-options=OPTIONS     old cluster options to pass to the server
  -O, --new-options=OPTIONS     new cluster options to pass to the server
  -p, --old-port=PORT           old cluster port number (default 50432)
  -P, --new-port=PORT           new cluster port number (default 50432)
  -r, --retain                  retain SQL and log files after success
  -s, --socketdir=DIR           socket directory to use (default CWD)
  -U, --username=NAME           cluster superuser (default \"hdbadmin\")
  -v, --verbose                 enable verbose internal logging
  -V, --version                 display version information, then exit
      --mode=TYPE               designate node type to upgrade, \"segment\" or \"dispatcher\" (default \"segment\")
      --progress                enable progress reporting
      --remove-checksum         remove data checksums when creating new cluster
      --add-checksum            add data checksumming to the new cluster
      --old-gp-dbid             inHybrid database id of the old segment
      --new-gp-dbid             inHybrid database id of the new segment
      --old-tablespaces-file    file containing the tablespaces from an old gpdb five cluster
  -?, --help                    show this help, then exit

Before running pg_upgrade you must:
  create a new database cluster (using the new version of initdb)
  shutdown the postmaster servicing the old cluster
  shutdown the postmaster servicing the new cluster

When you run pg_upgrade, you must provide the following information:
  the data directory for the old cluster  (-d DATADIR)
  the data directory for the new cluster  (-D DATADIR)
  the \"bin\" directory for the old version (-b BINDIR)
  the \"bin\" directory for the new version (-B BINDIR)

For example:
  pg_upgrade -d oldCluster/data -D newCluster/data -b oldCluster/bin -B newCluster/bin
or
  \$ export PGDATAOLD=oldCluster/data
  \$ export PGDATANEW=newCluster/data
  \$ export PGBINOLD=oldCluster/bin
  \$ export PGBINNEW=newCluster/bin
  \$ pg_upgrade

Report bugs to <bugs\@inspur.com>.\n";
our $pg_upgrade_version = "pg_upgrade (PostgreSQL) 9.4.24\n";
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
["pg_config", $pg_config_help],
["pg_rewind", $pg_rewind_help],
["initdb", $initdb_help],
["pg_basebackup", $pg_basebackup_help],
["pg_receivexlog", $pg_receivexlog_help],
["pg_ctl", $pg_ctl_help],
["pg_controldata", $pg_controldata_help],
["pg_resetxlog", $pg_resetxlog_help],
["postgres", $postgres_help],
["pg_upgrade", $pg_upgrade_help]
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
["pg_config", $pg_config_version],
["pg_rewind", $pg_rewind_version],
["initdb", $initdb_version],
["pg_basebackup", $pg_basebackup_version],
["pg_receivexlog", $pg_receivexlog_version],
["pg_ctl", $pg_ctl_version],
["pg_controldata", $pg_controldata_version],
["pg_resetxlog", $pg_resetxlog_version],
["postgres", $postgres_version],
["pg_upgrade", $pg_upgrade_version]
);
