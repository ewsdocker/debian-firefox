#!/bin/bash
# =========================================================================
# =========================================================================
#
#	lmsInstallFlash-0.0.1.sh
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
# @subpackage lmsInstallFlash-0.0.1.sh
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
#
#		Version 0.0.1 - 2018-11-28.
#
# =========================================================================

ARCH="x86_64"
FLASHPLAYER_NAME="flash_player_npapi_linux.${ARCH}.tar.gz"
FLASHPLAYER_MASTER="https://fpdownload.macromedia.com/pub/flashplayer/masterversion/masterversion.xml"

FIREFOX_FLASH_MODULE="libflashplayer.so"
FIREFOX_FLASH_INSTALL_DIR="/usr/lib/mozilla/plugins"

# =========================================================================
# =========================================================================

# =========================================================================
#
#   lmsconDebug
#		display debug message on the console
#
#	parameters:
#		message = message to display
#	returns:
#		0 = no errors
#		non-zero = error code
#
# =========================================================================
function lmsconDebug()
{
    [[ ${lmscli_optDebug} -ne 0 && ${lmscli_optQuiet} -eq 0 ]] &&
     {
		lmsconDisplay "###########################"
		lmsconDisplay "#"
		lmsconDisplay "#   ${1}"
		lmsconDisplay "#"
		lmsconDisplay "###########################"
	 }
	
	return 0
}

# =========================================================================
#
#   installFlash
#
#   Enter:
#       flashDir = Firefox flash installation directory
#       flashModule = Firefox flash module name
#       playerName = Flash player package name
#       playerMaster = URL to the masterversion xml file
#   Exit:
#       0 = no error
#       non-zero = error code
#
# =========================================================================
function installFlash()
{
    local flashDir="${1}"
    local flashModule=${2}

    local playerName=${3}
    local playerMaster="${4}"
    
    lmsconDebug "installFlash: \"$flash_Dir\" \"$flashModule\" \"$playerName\" \"$playerMaster\""

	[[ -z "${flashDir}" || -z "${flashModule}" ||-z "${playerName}" || -z "${playerMaster}" ]] && return 1

    local currentVersion
    local playerVersion=$(wget -qO- "${playerMaster}" | grep -m1 "NPAPI_linux version" | cut -d \" -f 2 | tr , .)

	lmsconDebug "playerVersion = \"$playerVersion\""

    [[ -z "${playerVersion}" ]] && return 2

    [[ -e "${flashDir}" ]] || mkdir -p "${flashDir}"

    [[ -r "${flashDir}/${flashModule}" ]] &&
     {
        currentVersion=$(grep -z 'FlashPlayer_' ${flashDir}/${flashModule} | cut -d _ -f 2-5 | tr _ .)
		lmsconDebug "currentVersion: $currentVersion"

        [[ "${currentVersion}" = "${playerVersion}" ]] && return 0
     }

	local startDir="${PWD}"

    mkdir /temp
    cd /temp

    wget "https://fpdownload.adobe.com/pub/flashplayer/pdc/${playerVersion}/${playerName}"
    [[ $? -eq 0 ]] || return 3

    tar -xof ${playerName} -C ${flashDir} ${flashModule}
    [[ $? -eq 0 ]] || return 4

	cd "${startDir}"

#	rm -R /temp

    return 0
}

# =========================================================================
