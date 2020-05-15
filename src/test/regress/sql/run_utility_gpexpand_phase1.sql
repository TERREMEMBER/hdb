-- start_matchsubs
-- m/^\S+ (.*):.*:.*-(\[\S+\]):-/
-- s/^\S+ (.*):.*:.*-(\[\S+\]):-/TIMESTAMP $1:HOST:USER-$2:-/
-- end_matchsubs

\! echo 'EXPANSION_PREPARE_STARTED:<path> to inputfile' > $MASTER_DATA_DIRECTORY/gpexpand.status
\! hdbcheckcat
\! hdbconfig -r gp_debug_linger
-- most hdbpkg actions should be disallowed while hdbexpand is in progress
\! hdbpkg --query no-such-package
-- the only exception is 'build' which has no interaction with the cluster
\! hdbpkg --build no-such-package
\! rm $MASTER_DATA_DIRECTORY/gpexpand.status
