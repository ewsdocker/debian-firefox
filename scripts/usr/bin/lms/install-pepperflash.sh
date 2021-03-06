#!/bin/bash
# =========================================================================
# =========================================================================
#
#	install-pepperflash.sh
#	  Run a library script to install/upgrade the current flashplayer
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-firefox
# @subpackage install-pepperflash.sh.sh
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
#		Version 0.0.1 - December 3, 2018.
#
# =========================================================================
# =========================================================================

# =========================================================================
#
#   Global variables
#
# =========================================================================

declare status=0
declare flashTemp="/flashtemp"
declare startDir

# =========================================================================
#
#   External libraries - must be loaded prior to calling subroutines
#
# =========================================================================

. /usr/local/lib/lms/lmsconDisplay-0.0.1.bash
. /usr/local/lib/lms/lmsInstallPepperflash-0.0.1.sh

# =========================================================================
#
#	Start application here
#
# =========================================================================

lmscli_optQuiet=${LMSOPT_QUIET}

startDir="${PWD}"

mkdir ${flashTemp}
cd ${flashTemp}

installPepperflash "${flashplayerFolder}" "${flashplayerModule}" "${flashplayerName}" "${flashplayerMaster}"
status=$?

lmsconDisplay "**********************************************"
lmsconDisplay ""

case ${status} in

	0)  lmsconDisplay "Flash player ${flashplayerName} was successfully installed."
	   	;;
	    
	1)  lmsconDisplay "Missing required parameter."
	    ;;
	    
	2)	lmsconDisplay "Cannot get current player version."
		;;
		
	3)  lmsconDisplay "Unable to read player master URL: ${flashplayerMaster}"
		;;
		
	4)	lmsconDisplay "Unable to read archive file: ${flashplayerName}"
		;;
		
	*)  lmsconDisplay "An unknown error (${status}) has occurred."
	    status=5
		;;
esac

# =========================================================================

cd "${startDir}"
rm -R ${flashTemp}

# =========================================================================
#
#	Application exit
#
# =========================================================================

exit ${status}

