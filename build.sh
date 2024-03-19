#!/bin/bash

PLUGIN_NAME="afk-manager"
AFK_DETECTOR="../../afk-detector/scripting/include"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -i $AFK_DETECTOR -o ../plugins/$PLUGIN_NAME.smx
