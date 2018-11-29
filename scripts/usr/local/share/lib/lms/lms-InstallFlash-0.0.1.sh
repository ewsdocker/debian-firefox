#!/bin/bash
# =========================================================================
# =========================================================================
#
#	lms-installFlash-0.0.1.sh
#	  library script to install/upgrade the Adobe flashplayer
#
#   adapted from
#     Adobe Flash Player installer/updater for Mozilla Firefox. 
#     Please visit the project's website at: 
#       https://github.com/cybernova/fireflashupdate
#
#     Licensed under the GNU General Public License, GPL-3.0-or-later.
#     Copyright (C) 2018 Andrea Dari (andreadari@protonmail.com)                                    
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-firefox
# @subpackage lms-installFlash-0.0.1.sh
#
# =========================================================================
#
#	Copyright © 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-firefox.
#
#   ewsdocker/debian-firefox is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-firefox is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-firefox.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================

# =========================================================================
#
#   installFlash
#
#   Enter:
#       none
#   Exit:
#       0 = no error
#       non-zero = error code
#
# =========================================================================
function installFlash()
{
    FIREFOX_FLASH_INSTALL_DIR=${FIREFOX_FLASH_INSTALL_DIR:-/usr/lib/mozilla/plugins}
    ARCH=x86_64

    VERSION=$(wget -qO- https://fpdownload.macromedia.com/pub/flashplayer/masterversion/masterversion.xml | grep -m1 "NPAPI_linux version" | cut -d \" -f 2 | tr , .)

    [[ -z "$VERSION" ]] && return 1

#    if [ ! -e "$FIREFOX_FLASH_INSTALL_DIR" ]; then
#        mkdir -p "$FIREFOX_FLASH_INSTALL_DIR"
#    fi
    [[ -e "$FIREFOX_FLASH_INSTALL_DIR" ]] || mkdir -p "$FIREFOX_FLASH_INSTALL_DIR"

    [[ -r "$FIREFOX_FLASH_INSTALL_DIR/libflashplayer.so" ]] &&
     {
        CUR_VER=$(grep -z 'FlashPlayer_' $FIREFOX_FLASH_INSTALL_DIR/libflashplayer.so | cut -d _ -f 2-5 | tr _ .)
        [[ "$CUR_VER" = "$VERSION" ]] && return 0
     }

    mkdir /temp
    cd /temp

    wget "https://fpdownload.adobe.com/pub/flashplayer/pdc/$VERSION/flash_player_npapi_linux.${ARCH}.tar.gz"
    [[ $? -eq 0 ]] || return 2

    tar -xof flash_player_npapi_linux.${ARCH}.tar.gz -C $FIREFOX_FLASH_INSTALL_DIR libflashplayer.so
    [[ $? -eq 0 ]] || return 3

    rm flash_player_npapi_linux.${ARCH}.tar.gz

    return 0
}

