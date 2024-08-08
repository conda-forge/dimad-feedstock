#!/bin/bash

set -ex

# Windows shell doesn't start in the source directory
cd "$SRC_DIR"

if [[ $(uname) == "Linux" || $(uname) == "Darwin" ]] && [[ "${GFORTRAN}" != "gfortran" ]]; then
  ln -s "${GFORTRAN}" "${BUILD_PREFIX}/bin/gfortran"
fi

if [[ "$target_platform" == osx-arm64 ]]; then
  gfortran -g -std=legacy -c dimad.f
  # TODO this needs fixing in dimad - LDFLAGS aren't making their way through
  # and -L $PREFIX/lib for libgfortran is not found. This appears to only be
  # an issue when cross-compiling for osx-arm64 for some reason:
  gfortran -g -std=legacy -o dimad dimad.o -lm -dynamic $LDFLAGS
else
  make
fi

mkdir -p "${PREFIX}/bin/"
cp ./dimad "${PREFIX}/bin"
ls -la "${PREFIX}/bin"
