FROM centos:centos7

ADD ./gpEnv /usr/local/gpEnv
 
RUN /bin/bash -c 'echo -e "/usr/local/gpEnv/gpos_home/lib\n/usr/local/gpEnv/gp-xerces_home/lib\n/usr/local/gpEnv/gporca_home/lib\n/usr/local/gpEnv/apr_home/lib\n/usr/local/gpEnv/apr_util_home/lib\n/usr/local/gpEnv/sigar_home/lib" >/etc/ld.so.conf' && \
    cp /usr/local/gpEnv/apr_util_home/bin/apu-1-config /usr/bin/ && \
    ldconfig

# Install some basic utilities and build tools
RUN yum makecache && \
    rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 && \
    yum -y install epel-release java-1.8.0-openjdk-devel && \
    yum -y install git iproute net-tools openssh-server rsync sudo time vim wget unzip && \
    yum -y install ant-junit autoconf bison cmake3 make flex gperf indent jq libtool && \
    yum clean all

# install all software we need
RUN yum makecache && \
    yum -y install python2-pip && \
    yum -y install python-devel python-psutil python-setuptools && \
    yum -y install apr-devel bzip2-devel expat-devel libcurl-devel && \
    yum -y install libevent-devel libuuid-devel libxml2-devel libyaml-devel libzstd-devel && \
    yum -y install openssl-devel pam-devel readline-devel snappy-devel && \
    yum -y install apache-ivy libicu perl-ExtUtils-Embed perl-Env perl-JSON && \
    pip install psi lockfile && \
    yum clean all

# setup ssh configuration
RUN ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 0600 /root/.ssh/authorized_keys && \
    echo -e "password\npassword" | passwd 2> /dev/null && \
    { ssh-keyscan localhost; ssh-keyscan 0.0.0.0; } >> /root/.ssh/known_hosts && \
    ssh-keygen -f /etc/ssh/ssh_host_key -N '' -t rsa1 && \
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa && \
    sed -i -e 's|Defaults    requiretty|#Defaults    requiretty|' /etc/sudoers && \
    sed -ri 's/UsePAM yes/UsePAM no/g;s/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -ri 's@^HostKey /etc/ssh/ssh_host_ecdsa_key$@#&@;s@^HostKey /etc/ssh/ssh_host_ed25519_key$@#&@' /etc/ssh/sshd_config

# newer version of gcc and run environment for gpdb
RUN yum -y install centos-release-scl && \
    yum -y install --nogpgcheck devtoolset-8-gcc devtoolset-8-gcc-c++ && yum clean all && \
    ln -s /usr/bin/cmake3 /usr/bin/cmake && \
    echo -e 'source /opt/rh/devtoolset-8/enable' >> /opt/gcc_env.sh && \
    echo -e 'source /opt/gcc_env.sh' >> /root/.bashrc && \
    echo -e '#!/bin/sh' >> /etc/profile.d/jdk_home.sh && \
    echo -e 'export JAVA_HOME=/etc/alternatives/java_sdk' >> /etc/profile.d/jdk_home.sh && \
    echo -e 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/jdk_home.sh


# setup curl and maven
RUN yum install -y curl maven && yum clean all

# create user hdbadmin since HDB cannot run under root
RUN groupadd -g 1000 hdbadmin && useradd -u 1000 -g 1000 hdbadmin && \
    echo "hdbadmin  ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/hdbadmin && \
    groupadd supergroup && usermod -a -G supergroup hdbadmin && \
    mkdir /home/hdbadmin/.ssh && \
    ssh-keygen -t rsa -N "" -f /home/hdbadmin/.ssh/id_rsa && \
    cat /home/hdbadmin/.ssh/id_rsa.pub >> /home/hdbadmin/.ssh/authorized_keys && \
    chmod 0600 /home/hdbadmin/.ssh/authorized_keys && \
    echo -e "password\npassword" | passwd hdbadmin 2> /dev/null && \
    { ssh-keyscan localhost; ssh-keyscan 0.0.0.0; } >> /home/hdbadmin/.ssh/known_hosts && \
    chown -R hdbadmin:hdbadmin /home/hdbadmin/.ssh && \
    echo -e 'source /opt/gcc_env.sh' >> /home/hdbadmin/.bashrc

