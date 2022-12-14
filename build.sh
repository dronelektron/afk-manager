#!/bin/bash

PLUGIN_NAME="afk-manager"

cd scripting
spcomp $PLUGIN_NAME.sp -o ../plugins/$PLUGIN_NAME.smx
