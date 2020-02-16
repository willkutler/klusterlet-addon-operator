#!/bin/bash -e

export GO111MODULE=off

# Build tools

if ! which operator-sdk > /dev/null; then
    OPERATOR_SDK_VER=v0.9.0
    curr_dir=$(pwd)
    echo ">>> Installing Operator SDK"
    echo ">>> >>> Downloading source code"
    set +e
    # cannot use 'set -e' because this command always fails after project has been cloned down for some reason
    go get -d github.com/operator-framework/operator-sdk
    set -e
    cd $GOPATH/src/github.com/operator-framework/operator-sdk
    echo ">>> >>> Checking out $OPERATOR_SDK_VER"
    git checkout $OPERATOR_SDK_VER
    echo ">>> >>> Running make tidy"
    go version
    GO111MODULE=on make tidy
    echo ">>> >>> Running make install"
    GO111MODULE=on make install
    echo ">>> Done installing Operator SDK"
    operator-sdk version
    cd $curr_dir
fi
