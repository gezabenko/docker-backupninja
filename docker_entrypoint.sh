#!/bin/bash

DIR=/docker_entrypoint.d

if [[ -d "$DIR" ]]
then
  /bin/run-parts --verbose "$DIR"
fi

exec "$@"
