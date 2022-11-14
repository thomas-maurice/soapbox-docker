#!/bin/bash

docker run --net host -e MIX_ENV=prod \
    -v "$(pwd)/"prod.secret.exs:/opt/pleroma/config/prod.secret.exs \
    -v "$(pwd)/uploads":/opt/pleroma/uploads \
    mauricethomas/soapbox-docker
