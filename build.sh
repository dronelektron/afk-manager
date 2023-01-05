#!/bin/bash

PLUGIN_NAME="afk-manager"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -i ../../afk-detector/scripting/include -o ../plugins/$PLUGIN_NAME.smx
