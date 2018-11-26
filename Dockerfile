# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for Firefox in a Debian docker image.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.5.1
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

ENV FIREFOX_VER="60.3.0"

# =========================================================================

ENV LMSBUILD_VERSION="9.5.1" 
ENV LMSBUILD_NAME="debian-firefox" 
ENV LMSBUILD_REPO=ewsdocker 
ENV LMSBUILD_REGISTRY="" 

ENV LMSBUILD_PARENT="debian-openjre:9.5.9-gtk3"
ENV LMSBUILD_DOCKER="ewsdocker/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="${LMSBUILD_PARENT}, Firefox-esr ${FIREFOX_VER}"

# =========================================================================

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install firefox-esr \
                       xdg-utils \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt 

# =========================================================================

COPY scripts/. /

RUN chmod +x /usr/local/bin/* \
 && chmod 600 /usr/local/share/applications/${LMSBUILD_NAME}-${LMSBUILD_VERSION}.desktop \
 && chmod 600 /usr/local/share/applications/${LMSBUILD_NAME}.desktop

# =========================================================================

VOLUME /Downloads
VOLUME /source

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["firefox"]
