## debian-firefox  
**Firefox** in a Docker image.  

#### GitHub Current Source is EDGE
The _9.5.2_ version is now under development. It will show itself as _EDGE_ in Docker hub [Tags](https://hub.docker.com/r/ewsdocker/debian-firefox/tags/).  

The _9.5.2_ and _EDGE_ tags are development versions of GitHub source and debian-firefox Docker image, respectively.  

____  
**Pre-built Docker images are available from the [ewsdocker/debian-firefox](https://hub.docker.com/r/ewsdocker/debian-firefox)** repository.  
____  
## Table of Contents

   * [debian-firefox](https://github.com/ewsdocker/debian-firefox/wiki/)  
      * [Newest Version](https://github.com/ewsdocker/debian-firefox/wiki/Home#newest-version)
      * [Overview](https://github.com/ewsdocker/debian-firefox/wiki/Home#overview)  
      * [Latest vs Versioned Release](https://github.com/ewsdocker/debian-firefox/wiki/Home#latest-vs-versioned-release)  
         * [Versioned releases](https://github.com/ewsdocker/debian-firefox/wiki/Home#versioned-releases)  
         * [Latest releases](https://github.com/ewsdocker/debian-firefox/wiki/Home#latest-releases) 
         * [Suggested use](https://github.com/ewsdocker/debian-firefox/wiki/Home#suggested-use)  


   * [Quick Start - latest release](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart)
      * [Installing debian-firefox](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#installing-debian-firefox)
         * [Usage](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#usage)
         * [Environment Variables](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#environment-variables)
         * [Data Volumes](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#data-volumes)
      * [Running debian-firefox](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#running-debian-firefox)
         * [Mapping run-time resources](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#mapping-run-time-resources)  
            * [Mapping Data Volumes](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#mapping-data-volumes)  
         * [Persistence](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#persistence)
         * [Timestamps](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#timestamps)  
         * [X11 Server](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#x11-server)  
         * [UIDs and GIDs](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart##uids-and-gids)  
            * [About user namespaces](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#about-user-namespaces) 
            * [Running outside user namespaces](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#running-outside-user-namespaces)
            * [Specifying UID and GID](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart#specifying-uid-and-gid)  


   * [Quick Start - 9.5.2](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned)
      * [Installing debian-firefox 9.5.2](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#installing-debian-firefox)
         * [Usage](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#usage)
         * [Environment Variables](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#environment-variables)
         * [Data Volumes](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#data-volumes)
      * [Running debian-firefox 9.5.2](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#running-debian-firefox)
         * [Mapping run-time resources](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#mapping-run-time-resources)  
            * [Mapping Data Volumes](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#mapping-data-volumes)  
         * [Persistence](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#persistence)
         * [Timestamps](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#timestamps)  
         * [X11 Server](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#x11-server)  
         * [UIDs and GIDs](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned##uids-and-gids)  
            * [About user namespaces](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#about-user-namespaces) 
            * [Running outside user namespaces](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#running-outside-user-namespaces)
            * [Specifying UID and GID](https://github.com/ewsdocker/debian-firefox/wiki/QuickStart-Versioned#specifying-uid-and-gid)  


   * [Command-line Interface](https://github.com/ewsdocker/debian-firefox/wiki/CommandLineInterface)
      * [Persisting Container Modifications](https://github.com/ewsdocker/debian-firefox/wiki/CommandLineInterface#persisting-container-modifications)  


   * [Bleeding-edge Testing ](https://github.com/ewsdocker/debian-firefox/wiki/EdgeTesting#bleeding-edge-testing)  
      * [Download and Re-tag](https://github.com/ewsdocker/debian-firefox/wiki/EdgeTesting#download-and-re-tag)
      * [Running debian-firefox:9.5.2](https://github.com/ewsdocker/debian-firefox/wiki/EdgeTesting#running-debian-firefox)
   

   * [Flashplayer Support](https://github.com/ewsdocker/debian-firefox/wiki/Flashplayer)
      * [Background](https://github.com/ewsdocker/debian-firefox/wiki/Flashplayer#background)  
      * [Installing Adobe Flashplayer Plugin](https://github.com/ewsdocker/debian-firefox/wiki/Flashplayer#installing-adobe-flashplayer-plugin)  
      * [Updating Flashplayer](https://github.com/ewsdocker/debian-firefox/wiki/Flashplayer#updating-flashplayer)  
      * [Known issues](https://github.com/ewsdocker/debian-firefox/wiki/Flashplayer#known-issues)  
      * [Adobe Software Licensing Agreement](https://github.com/ewsdocker/debian-firefox/wiki/Flashplayer#adobe-software-licensing-agreement)  


   * [Docker Tags](https://github.com/ewsdocker/debian-firefox/wiki/DockerTags)  
      * [Docker Tag History](https://github.com/ewsdocker/debian-firefox/wiki/DockerTags#docker-tag-history)
   

   * [License](https://github.com/ewsdocker/debian-firefox/wiki/License)

