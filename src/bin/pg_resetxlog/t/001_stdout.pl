use strict;
use warnings;
use TestLib;
use Test::More tests => 6;

program_help_ok('pg_resetxlog');
program_version_ok('pg_resetxlog');
