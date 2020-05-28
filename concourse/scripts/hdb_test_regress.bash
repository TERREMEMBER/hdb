#!/bin/bash -l
set -ex

PWD="$(pwd)"

function compile_hdb(){
  cd gpdb_src/
  ./configure --prefix=/usr/local/greenplum-db --enable-orca --with-python --with-libxml --enable-debug --with-includes=/gpEnv/gporca_home/include:/gpEnv/gpos_home/include:/gpEnv/gp-xerces_home/include --with-libraries=/gpEnv/gporca_home/lib:/gpEnv/gp-xerces_home/lib && make -j32 && make install
  cd gpcontrib/gp_inject_fault/
  make && make install
  cd ../gp_debug_numsegments/
  make && make install  
  cd ../..
}

function make_cluster(){
  service ssh start
  rm /tmp/.s.PGSQL.600* 
  chown -R hdbadmin:hdbadmin ${PWD}/../gpdb_src/
  chown -R hdbadmin:hdbadmin /usr/local/greenplum-db
  pushd ${PWD}/gpAux/gpdemo
  su hdbadmin -c "source /usr/local/greenplum-db/inhybrid_path.sh; make cluster"
  popd
}

function run_test_regress(){
  su hdbadmin -c "source ${PWD}/gpAux/gpdemo/gpdemo-env.sh; source /usr/local/greenplum-db/inhybrid_path.sh; hdbconfig -c gp_enable_query_metrics -v on; echo y | hdbstop -r; hdbstate; make installcheck-world"
}

function _main() {
  compile_hdb
  make_cluster
  run_test_regress
}

_main ""
