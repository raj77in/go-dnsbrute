#!/bin/bash - 
#===============================================================================
#
#          FILE: build.sh
# 
#         USAGE: ./build.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal
#  ORGANIZATION: 
#       CREATED: 11/30/2024 17:31
#      REVISION:  ---
#===============================================================================

# Platforms to compile for
PLATFORMS=("linux:amd64" "linux:arm64" "darwin:amd64" "darwin:arm64" "windows:amd64")

# Program name
APP_NAME="go-dnsbrute"

# Compile for each platform
for PLATFORM in "${PLATFORMS[@]}"
do
    OS=${PLATFORM%:*}
    ARCH=${PLATFORM#*:}
    OUTPUT="${APP_NAME}-${OS}-${ARCH}"

    # Add .exe extension for Windows
    if [ "$OS" == "windows" ]; then
        OUTPUT+=".exe"
    fi

    echo "Compiling for $OS/$ARCH..."
    GOOS=$OS GOARCH=$ARCH go build -o $OUTPUT main.go
done

echo "Compilation complete!"


