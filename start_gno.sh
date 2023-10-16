#!/bin/bash

if [ -z "$CHAINID" ]; then
  echo "gnoland start"
else
  echo "gnoland start -chainid $CHAINID"
fi
