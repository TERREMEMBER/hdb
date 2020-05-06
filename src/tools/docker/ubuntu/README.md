DockerFile in HDB adds some dependent packages:
		apr_home,
		apr_util_home,
		gporca_home,
		gpos_home,
		gp-xerces_home,
		sigar_home.
Before running Dockerfile, please make sure to download gpEnv. 
GpEnv contains the above dependencies.
#TODO Dependency packages need to find a suitable resource management 
# method to manage
When we compile the HDB, we can use the parameters directly:
		--enable-orca,
		--with-python,
		--with-libxml,
		--enable-debug,
		--enable-gpperfmon.

In the Dockerfile of gpdb, it only meets the tool dependency of 
compiling HDB. The generated image and container need to be prepared 
for the environment.
