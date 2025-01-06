#!/bin/bash
#Setup Ambiente
mkdir files
#Scarica Paper
#wget -O paper.jar https://api.papermc.io/v2/projects/paper/versions/1.20.4/builds/416/downloads/paper-1.20.4-416.jar
#wget -O paper.jar https://api.papermc.io/v2/projects/paper/versions/1.21.3/builds/82/downloads/paper-1.21.3-82.jar
wget -O paper.jar https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/132/downloads/paper-1.21.1-132.jar
mv paper.jar files/paper.jar