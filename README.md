## debian-firefox:9.5.0
**Firefox-esr** in a Docker image.

____  

**Pre-built Docker images are available from [ewsdocker/debian-firefox](https://hub.docker.com/r/ewsdocker/debian-firefox).**  

____  
#### NOTE  
**ewsdocker/debian-firefox** is designed to be used on a Linux system configured to support **Docker user namespaces** .  Refer to [ewsdocker Containers and Docker User Namespaces](https://github.com/ewsdocker/ewsdocker.github.io/wiki/UserNS-Overview) for an overview and information on running **ewsdocker/debian-firefox** on a system not configured for **Docker user namespaces**.
____  

**Visit the [ewsdocker/debian-firefox Wiki](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart) for complete documentation of this docker image.**  
____  

#### Installing ewsdocker/debian-firefox  

The following scripts will download the selected **ewsdocker/debian-firefox** image, create a container, setup and populate the directory structures, create the run-time scripts, and install the application's desktop file(s).  

The _default_ values will install all directories and contents in the **docker host** user's home directory (refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#mapping)),  

____  

**ewsdocker/debian-firefox:latest**  
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -e LMSBUILD_VERSION=latest \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-firefox-latest:/root \
               --name=debian-firefox-latest \
           ewsdocker/debian-firefox lms-setup  

____  

**ewsdocker/debian-firefox:9.5.0**  
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-firefox-9.5.0:/root \
               --name=debian-firefox-9.5.0 \
           ewsdocker/debian-firefox:9.5.0 lms-setup  

____  
  
Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#mapping) for a discussion of **lms-setup** and what it does.  

____  

#### Running the installed scripts

After running the above command script, and using the settings indicated, the docker host directories, mapped as shown in the above tables, will be configured as follows:

+ the executable scripts have been copied to **~/bin**;  
+ the application desktop file(s) have been copied to **~/.local/share/applications**, and are availablie in any _task bar_ menu;  
+ the associated **debian-firefox-"version"** execution script(s) (shown below) will be found in **~/.local/bin**, and _should_ be customized with proper local volume names.  

____  

**Execution scripts**  

**ewsdocker/debian-firefox:latest**
  
    docker run -v /etc/localtime:/etc/localtime:ro \
               --device /dev/snd \
               -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
               -v ${HOME}/public_html:/html-source \
               -v ${HOME}/.config/docker/debian-firefox-latest:/root \
               --name=debian-firefox-latest \
           ewsdocker/debian-firefox:latest  

____  

**ewsdocker/debian-firefox:9.5.0**
  
    docker run -v /etc/localtime:/etc/localtime:ro \
               --device /dev/snd \
               -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
               -v ${HOME}/public_html:/html-source \
               -v ${HOME}/.config/docker/debian-firefox-9.5.0:/root \
               --name=debian-firefox-9.5.0 \
           ewsdocker/debian-firefox:9.5.0  

____  
Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#mapping) for a discussion of customizing the executable scripts..  

____  

#### Regarding edge  

For the very brave, if an _edge_ tag is available, these instructions will download, rename and install the _edge_ version.  Good luck.  

____  

**ewsdocker/debian-firefox:edge**  

**edge** is the development tag for the **9.5.1** release tag.

    docker pull ewsdocker/debian-firefox:edge
    docker tag ewsdocker/debian-firefox:edge ewsdocker/debian-firefox:9.5.1
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-firefox-9.5.1:/root \
               --name=debian-firefox-9.5.1 \
           ewsdocker/debian-firefox:9.5.1 lms-setup  

optional step:

    docker rmi ewsdocker/debian-firefox:edge  

To create and run the container, the following should work from the command-line, 

    ~/.local/bin/debian-firefox-9.5.1  

or,

    docker run -v /etc/localtime:/etc/localtime:ro \
           --device /dev/snd \
           -e DISPLAY=unix${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
           -v ${HOME}/public_html:/html-source \
           -v ${HOME}/.config/docker/debian-firefox-9.5.1:/root \
           --name=debian-firefox-9.5.1 \
       ewsdocker/debian-firefox:9.5.1    

____  
#### Persistence  
In order to persist the **debian-firefox** application state, a location on the docker _host_ must be provided to store the necessary information.  This can be accomplished with the following volume option in the run command:

    -v ${HOME}/.config/docker/debian-firefox-"version":/root  

Since the information is stored in the docker _container_ **/root** directory, this statement maps the user's **~/.config/docker/debian-firefox-"version"** docker _host_ directory to the **/root** directory in the docker _container_.  

____  
#### Timestamps  
It is important to keep the time and date on docker _host_ files that have been created and/or modified by the docker _containter_ synchronized with the docker _host_'s settings. This can be accomplished as follows:

    -v /etc/localtime:/etc/localtime:ro  

____  
#### Copyright © 2018. EarthWalk Software.  
**Licensed under the GNU General Public License, GPL-3.0-or-later.**  

This file is part of **ewsdocker/debian-firefox**.  

**ewsdocker/debian-firefox** is free software: you can redistribute 
it and/or modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation, either version 3 of the 
License, or (at your option) any later version.  

**ewsdocker/debian-firefox** is distributed in the hope that it will 
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.  

You should have received a copy of the GNU General Public License
along with **ewsdocker/debian-firefox**.  If not, see 
<http://www.gnu.org/licenses/>.  

____  

**Firefox** is licensed under (tbd)
  
