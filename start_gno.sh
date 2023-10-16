#!/bin/bash

if [ -z "$CHAINID" ]; then
  gnoland start
else
  gnoland start -chainid $CHAINID
fi
