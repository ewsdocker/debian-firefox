#!/bin/sh
#
# based on the following solution on StackOverflow.com at
#  https://stackoverflow.com/questions/45696676/set-docker-image-username-at-container-creation-time
#

set -x

LMSUSER_UID=`ls -nd $LMSUSER_HOME | cut -f3 -d' '`
LMSUSER_GID=`ls -nd $LMSUSER_HOME | cut -f4 -d' '`

CUR_UID=`getent passwd $LMSUSER_NAME | cut -f3 -d: || true`
CUR_GID=`getent group $LMSUSER_NAME | cut -f3 -d: || true`

if [ ! -z "$LMSUSER_GID" -a "$LMSUSER_GID" != "$CUR_GID" ]
then
    groupmod -g ${LMSUSER_GID} LMSUSER_NAME
fi

if [ ! -z "$LMSUSER_UID" -a "$LMSUSER_UID" != "$CUR_UID" ]; 
then
	usermod -u ${LMSUSER_UID} LMSUSER_NAME
    find / -uid ${CUR_UID} -mount -exec chown ${LMSUSER_UID}.${LMSUSER_GID} {} \;
fi

exec gosu $LMSUSER_NAME "$@"

# ########################################################################

FROM ewsdocker/debian-firefox:9.5.1
ARG GOSU_VERSION=1.10

#
# https://github.com/tianon/gosu/
#

ENV LMSUSER_NAME="ffuser"
ENV LMSUSER_HOME="/home/$LMSUSER_NAME"

USER root

# ########################################################################

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
     apt-transport-https \
     ca-certificates \
     curl \
     vim \
     wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# ########################################################################

RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && chmod 755 /usr/local/bin/gosu \
 && gosu nobody true

# ########################################################################

COPY scripts/. /

# ########################################################################

RUN useradd -d $LMSUSER_HOME -m $LMSUSER_NAME
WORKDIR $LMSUSER_HOME

# ########################################################################

ENTRYPOINT ["/usr/bin/lms/install-user.sh"]
CMD "firefox $@"
