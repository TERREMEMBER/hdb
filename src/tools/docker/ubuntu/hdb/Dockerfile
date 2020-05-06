ARG BASE_IMAGE=ubuntu:18.04
 
FROM ${BASE_IMAGE}
 
ARG DEBIAN_FRONTEND=noninteractive

ADD ./gpEnv /usr/local/gpEnv
 
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bac && \
    /bin/bash -c 'echo -e "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse\ndeb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse\ndeb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse\ndeb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse\ndeb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse\ndeb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse\ndeb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse\ndeb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse\ndeb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse\ndeb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse" > /etc/apt/sources.list' && \
    apt-get update -y && \
   /bin/bash -c 'echo -e "include /etc/ld.so.conf.d/*.conf\n/usr/local/gpEnv/gpos_home/lib\n/usr/local/gpEnv/gp-xerces_home/lib\n/usr/local/gpEnv/gporca_home/lib\n/usr/local/gpEnv/apr_home/lib\n/usr/local/gpEnv/apr_util_home/lib\n/usr/local/gpEnv/sigar_home/lib" >/etc/ld.so.conf' && \
    cp /usr/local/gpEnv/apr_util_home/bin/apu-1-config /usr/bin/ && \
    /sbin/ldconfig -v && \
    apt-get install -y --no-install-recommends apt-utils software-properties-common && \
    apt-get install -y --no-install-recommends openjdk-8-jdk && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends gcc-6 g++-6 cmake && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
    update-alternatives --config gcc && \
    gcc --version && g++ --version && \
    apt-get install -y --no-install-recommends ant \
    bison \
    build-essential \
    ccache \
    curl \
    dirmngr \
    flex \
    git-core \
    iputils-ping \
    iproute2 \
    jq \
    libapr1-dev \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libevent-dev \
    libkrb5-dev \
    libpam-dev \
    libperl-dev \
    libreadline-dev \
    libssl-dev \
    libxml2-dev \
    libyaml-dev \
    libzstd1-dev \
    locales \
    maven \
    net-tools \
    ninja-build \
    openssh-server \
    pkg-config \
    python-dev \
    python-lockfile \
    python-pip \
    python-psutil \
    python-setuptools \
    less \
    rsync \
    ssh \
    sudo \
    time \
    unzip \
    vim \
    wget \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* && \
    pip install behave~=1.2.6 -i https://pypi.tuna.tsinghua.edu.cn/simple
    # setup ssh configuration
RUN locale-gen en_US.UTF-8 && \
    ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 0600 /root/.ssh/authorized_keys && \
    echo "root:password" | chpasswd 2> /dev/null && \
    #
    sed -i -e 's|Defaults    requiretty|#Defaults    requiretty|' /etc/sudoers && \
    sed -ri 's/UsePAM yes/UsePAM no/g;s/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -ri 's@^HostKey /etc/ssh/ssh_host_ecdsa_key$@#&@;s@^HostKey /etc/ssh/ssh_host_ed25519_key$@#&@' /etc/ssh/sshd_config && \
    service ssh start && \
    { ssh-keyscan localhost; ssh-keyscan 0.0.0.0; } >> /root/.ssh/known_hosts && \
    # create user gpadmin since GPDB cannot run under root
    groupadd -g 1000 hdbadmin && useradd -u 1000 -g 1000 hdbadmin -s /bin/bash && \
    echo "hdbadmin  ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/hdbadmin && \
    groupadd supergroup && usermod -a -G supergroup hdbadmin && \
    mkdir -p /home/hdbadmin/.ssh && \
    ssh-keygen -t rsa -N "" -f /home/hdbadmin/.ssh/id_rsa && \
    cat /home/hdbadmin/.ssh/id_rsa.pub >> /home/hdbadmin/.ssh/authorized_keys && \
    chmod 0600 /home/hdbadmin/.ssh/authorized_keys && \
    echo "hdbadmin:password" | chpasswd 2> /dev/null && \
    { ssh-keyscan localhost; ssh-keyscan 0.0.0.0; } >> /home/hdbadmin/.ssh/known_hosts && \
    chown -R hdbadmin:hdbadmin /home/hdbadmin && \
    mkdir /usr/local/greenplum-db-devel && \
    chown -R hdbadmin:hdbadmin /usr/local/
