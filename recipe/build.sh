#!/bin/bash

set -ex

# Windows shell doesn't start in the source directory
cd "$SRC_DIR"

make FCOMP=${FC} LDFLAGS="${LDFLAGS} -lm -dynamic"

mkdir -p "${PREFIX}/bin/"
install -m 755 dimad "${PREFIX}/bin"
