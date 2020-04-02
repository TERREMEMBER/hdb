#!/usr/bin/env bash

if [ x$1 != x ] ; then
    HDBHOME_PATH=$1
else
    HDBHOME_PATH="\`pwd\`"
fi

if [ "$2" = "ISO" ] ; then
	cat <<-EOF
		if [ "\${BASH_SOURCE:0:1}" == "/" ]
		then
		    HDBHOME=\`dirname "\$BASH_SOURCE"\`
		else
		    HDBHOME=\`pwd\`/\`dirname "\$BASH_SOURCE"\`
		fi
	EOF
else
	cat <<-EOF
		HDBHOME=${HDBHOME_PATH}
	EOF
fi


PLAT=`uname -s`
if [ $? -ne 0 ] ; then
    echo "Error executing uname -s"
    exit 1
fi

cat << EOF

# Replace with symlink path if it is present and correct
if [ -h \${HDBHOME}/../inhybrid-db ]; then
    HDBHOME_BY_SYMLINK=\`(cd \${HDBHOME}/../inhybrid-db/ && pwd -P)\`
    if [ x"\${HDBHOME_BY_SYMLINK}" = x"\${HDBHOME}" ]; then
        HDBHOME=\`(cd \${HDBHOME}/../inhybrid-db/ && pwd -L)\`/.
    fi
    unset HDBHOME_BY_SYMLINK
fi
EOF

cat <<EOF
#setup PYTHONHOME
if [ -x \$HDBHOME/ext/python/bin/python ]; then
    PYTHONHOME="\$HDBHOME/ext/python"
    export PYTHONHOME
fi
EOF

#setup PYTHONPATH
if [ "x${PYTHONPATH}" == "x" ]; then
    PYTHONPATH="\$HDBHOME/lib/python"
else
    PYTHONPATH="\$HDBHOME/lib/python:${PYTHONPATH}"
fi
cat <<EOF
PYTHONPATH=${PYTHONPATH}
EOF

GP_BIN_PATH=\$HDBHOME/bin
GP_LIB_PATH=\$HDBHOME/lib

if [ -n "$PYTHONHOME" ]; then
    GP_BIN_PATH=${GP_BIN_PATH}:\$PYTHONHOME/bin
    GP_LIB_PATH=${GP_LIB_PATH}:\$PYTHONHOME/lib
fi
cat <<EOF
PATH=${GP_BIN_PATH}:\$PATH
EOF

cat <<EOF
LD_LIBRARY_PATH=${GP_LIB_PATH}:\${LD_LIBRARY_PATH-}
export LD_LIBRARY_PATH
EOF

# AIX uses yet another library path variable
# Also, Python on AIX requires special copies of some libraries.  Hence, lib/pware.
if [ "${PLAT}" = "AIX" ]; then
cat <<EOF
PYTHONPATH=\${HDBHOME}/ext/python/lib/python2.7:\${PYTHONPATH}
LIBPATH=\${HDBHOME}/lib/pware:\${HDBHOME}/lib:\${HDBHOME}/ext/python/lib:/usr/lib/threads:\${LIBPATH}
export LIBPATH
GP_LIBPATH_FOR_PYTHON=\${HDBHOME}/lib/pware
export GP_LIBPATH_FOR_PYTHON
EOF
fi

# openssl configuration file path
cat <<EOF
if [ -e \$HDBHOME/etc/openssl.cnf ]; then
OPENSSL_CONF=\$HDBHOME/etc/openssl.cnf
export OPENSSL_CONF
fi
EOF

cat <<EOF
export HDBHOME
export PATH
EOF

cat <<EOF
export PYTHONPATH
EOF

