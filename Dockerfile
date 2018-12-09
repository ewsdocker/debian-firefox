# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for Firefox in a Debian docker image.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.5.2
# @copyright © 2017, 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package debian-firefox
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017, 2018. EarthWalk Software
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
FROM ewsdocker/debian-openjre:9.5.9-gtk3

MAINTAINER Jay Wheeler <EarthWalkSoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================

ENV LMSOPT_QUIET=0

# =========================================================================
#
# wget http://ftp.mozilla.org/pub/firefox/releases/62.0.3/linux-x86_64/en-US/firefox-62.0.3.tar.bz2
#
# =========================================================================

ENV FIREFOX_NAME="Firefox"

ENV FIREFOX_RELEASE="63" 
ENV FIREFOX_VERS="0.3"
ENV FIREFOX_PKG="firefox-${FIREFOX_RELEASE}.${FIREFOX_VERS}.tar.bz2" 

ENV FIREFOX_HOST=http://alpine-nginx-pkgcache
#ENV FIREFOX_HOST="http://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_RELEASE}.${FIREFOX_VERS}/linux-x86_64/en-US"

ENV FIREFOX_URL="${FIREFOX_HOST}/${FIREFOX_PKG}"

# =========================================================================

ENV LMSBUILD_VERSION="9.5.2" 
ENV LMSBUILD_NAME="debian-firefox" 
ENV LMSBUILD_REPO=ewsdocker 
ENV LMSBUILD_REGISTRY="" 

ENV LMSBUILD_PARENT="debian-openjre:9.5.9-gtk3"
ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="${LMSBUILD_PARENT}, ${FIREFOX_NAME} ${FIREFOX_RELEASE}.${FIREFOX_VERS}"

# =========================================================================

RUN apt-get -y update \
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
 && cd /opt \
 && wget ${FIREFOX_URL} \
 && tar -xvf ${FIREFOX_PKG} \
 && rm ${FIREFOX_PKG} \  
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt 

# =========================================================================

COPY scripts/. /

# =========================================================================

RUN chmod +x /usr/local/bin/* \
 && ln -s /usr/bin/lms/install-flashplayer.sh /usr/bin/lmsInstallFlash \
 && chmod 775 /usr/bin/lms/install-flashplayer.sh \
 && chmod 600 /usr/local/share/applications/${LMSBUILD_NAME}-${LMSBUILD_VERSION}.desktop \
 && chmod 600 /usr/local/share/applications/${LMSBUILD_NAME}.desktop \  
 && ln -s /opt/firefox/firefox /usr/bin/firefox \
 && chmod 775 /opt/firefox/firefox 

# =========================================================================

VOLUME /Downloads
VOLUME /source

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["firefox"]
