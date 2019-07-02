# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for Firefox in a Debian docker image.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.7.0
# @copyright © 2017-2019. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package debian-firefox
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017-2019. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-firefox.
#
#   ewsdocker/debian-libreoffice is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-libreoffice is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-libreoffice.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================

ARG ARG_NAME="lms-library"
ARG ARG_LIBRARY="0.1.2"

#ARG ARG_SOURCE=http://alpine-nginx-pkgcache

# ========================================================================================

ARG ARGBUILD_REGISTRY=""
ARG ARGBUILD_REPO=ewsdocker

ARG ARGBUILD_NAME="debian-firefox" 
ARG ARGBUILD_VERSION="9.7.0"
ARG ARGBUILD_VERS_EXT=""

ARG ARGBUILD_TEMPLATE="gui"

ARG ARGBUILD_CATEGORIES="Network"
ARG ARGBUILD_DESKTOP_NAME="Firefox"
ARG ARGBUILD_ICON="Firefox-esrSmall.png"

# ========================================================================================

ARG ARGOPT_QUIET=0

# ========================================================================================

ARG ARG_FROM_REPO="ewsdocker/debian-openjre"
ARG ARG_FROM_VERS="9.7.0"
ARG ARG_FROM_EXT="-gtk3"

ARG ARG_FROM_PARENT="${ARG_FROM_REPO}:${ARG_FROM_VERS}${ARG_FROM_EXT}"

FROM ${ARG_FROM_PARENT}

MAINTAINER Jay Wheeler <ewsdocker@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
 
# ========================================================================================
# ========================================================================================

# ========================================================================================
#
#   Re-declare build-args, but don't change any assignments 
#       (makes the settings available inside the build)
#
# ========================================================================================

ARG ARG_NAME
ARG ARG_LIBRARY

ARG ARG_SOURCE

ARG ARGBUILD_REGISTRY
ARG ARGBUILD_REPO

ARG ARGBUILD_NAME 
ARG ARGBUILD_VERSION
ARG ARGBUILD_VERS_EXT

ARG ARGBUILD_TEMPLATE
ARG ARGBUILD_CATEGORIES
ARG ARGBUILD_DESKTOP_NAME
ARG ARGBUILD_ICON

ARG ARG_FROM_REPO
ARG ARG_FROM_VERS
ARG ARG_FROM_EXT
ARG ARG_FROM_PARENT

ARG ARGOPT_QUIET

# =========================================================================
#
# wget http://ftp.mozilla.org/pub/firefox/releases/65.0.1/linux-x86_64/en-US/firefox-65.0.1.tar.bz2
#
# =========================================================================

ENV FIREFOX_NAME="Firefox"

ENV FIREFOX_RELEASE="65" 
ENV FIREFOX_VERS="0.1"
ENV FIREFOX_PKG="firefox-${FIREFOX_RELEASE}.${FIREFOX_VERS}.tar.bz2" 

ENV FIREFOX_HOST=${ARG_SOURCE:-"http://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_RELEASE}.${FIREFOX_VERS}/linux-x86_64/en-US"}

ENV FIREFOX_URL="${FIREFOX_HOST}/${FIREFOX_PKG}"

# ========================================================================================
# ========================================================================================
#
# https://github.com/ewsdocker/lms-utilities/releases/download/lms-utilities-0.1.2/lms-library-0.1.2.tar.gz
#
# ========================================================================================
# ========================================================================================

ENV \
    \
    LMS_BASE="/usr/local" \
    LMS_HOME= \
    LMS_CONF= \
    \
    \
    LMSBUILD_REGISTRY=${ARGBUILD_REGISTRY} \
    LMSBUILD_REPO=${ARGBUILD_REPO} \
    \
	\
    LMSBUILD_NAME=${ARGBUILD_NAME} \
    LMSBUILD_VERSION=${ARGBUILD_VERSION} \
    LMSBUILD_VERS_EXT=${ARGBUILD_VERS_EXT} \
    LMSBUILD_TEMPLATE=${ARGBUILD_TEMPLATE:-"run"} \
    LMSBUILD_DESKTOP_CATEGORIES=${ARGBUILD_CATEGORIES} \
    LMSBUILD_DESKTOP_NAME=${ARGBUILD_DESKTOP_NAME} \
    LMSBUILD_ICON=${ARGBUILD_ICON}   

ENV LMSBUILD_PARENT=${ARG_FROM_PARENT:-"debian-openjre:9.7.0-gtk3"} 

ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}${LMSBUILD_VERS_EXT}" \
    LMSBUILD_BASE="${ARG_FROM_PARENT}:${ARG_FROM_VERS}${ARG_FROM_EXT}" \
    LMSBUILD_PACKAGE="${LMSBUILD_PARENT}, ${FIREFOX_NAME} ${FIREFOX_RELEASE}.${FIREFOX_VERS}"

# ========================================================================================

ENV PKG_VERS="${ARG_LIBRARY}" 

ENV PKG_HOST=${ARG_SOURCE:-"https://github.com/ewsdocker/lms-utilities/releases/download/lms-library-${PKG_VERS}"} \
    PKG_NAME="lms-library-${PKG_VERS}.tar.gz" 

ENV PKG_URL="${PKG_HOST}/${PKG_NAME}"

# =========================================================================

ENV LMSOPT_QUIET=${ARGOPT_QUIET:-"0"}

# =========================================================================

VOLUME /Downloads
VOLUME /source

# =========================================================================

COPY scripts/. /

# =========================================================================

RUN \
 \
 # =========================================================================
 #
 #   Install support libraries and applications
 #
 # =========================================================================
 \
     apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install \
               alsa-utils \
               bzip2 \
               gvfs-bin \
               libnspr4 \
               libnss3 \
               libasound2 \
               libasound2-data \
               libavcodec-extra57 \
               libavutil55 \
               libc6 \ 
               libcairo2 \
               libcanberra0 \
               libevent-2.0-5 \
               libevent-pthreads-2.0-5 \
               libfreetype6 \
               libgcc1 \
               libgl1 \
               libgl1-mesa-glx \
               libglib2.0-0 \
               libgtk2.0-0 \
               libpango-1.0-0 \
               libpangocairo-1.0-0 \
               libpangoft2-1.0-0 \
               libpulse0 \
               libssl1.1 \
               libstdc++6 \
               libv4l-0 \
               libva-x11-1 \
               libva1 \
               libvdpau1 \
               libx11-6 \
               libx11-protocol-perl \
               libxcursor1 \
               libxrandr2 \
               libxrender1 \
               pulseaudio \
               x11-utils \
               x11-xserver-utils \
               xdg-utils \
 && apt-get clean all \
 \
 # =========================================================================
 #
 #   Download the latest Firefox
 #
 # =========================================================================
 \
 && cd /opt \
 && wget ${FIREFOX_URL} \
 && tar -xvf ${FIREFOX_PKG} \
 && rm ${FIREFOX_PKG} \  
 \
 # =========================================================================
 #
 #   Setup firefox to run from cli
 #
 # =========================================================================
 \
 && ln -s /opt/firefox/firefox /usr/bin/firefox \
 && chmod 775 /opt/firefox/firefox \
 \
 # =========================================================================
 #
 #   download and install lms-library
 #
 # =========================================================================
 \
 && cd / \
 && wget "${PKG_URL}" \
 && tar -xvf "${PKG_NAME}" \
 && rm "${PKG_NAME}" \
 \
 # =========================================================================
 #
 #   create empty directories (COPY does not create empty folders!)
 #
 # =========================================================================
 \
 && mkdir -p /usr/local/share/applications \
 && mkdir -p /usr/local/bin \
 && mkdir -p /usr/bin/lms \
 \
 # =========================================================================
 #
 #   Setup flashplayer installer 
 #       - must not be added before the container runs for 1st time.
 #
 # =========================================================================
 \
 && ln -s /usr/bin/lms/install-flashplayer.sh /usr/bin/lmsInstallFlash \
 && chmod +x /usr/bin/lms/*.sh \
 \
 # =========================================================================
 #
 #   Register Firefox
 #
 # =========================================================================
 \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt 

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["firefox"]
