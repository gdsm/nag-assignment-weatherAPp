#!/bin/bash

#set -xo pipefail
#
#export PATH="~/.rbenv/shims:$PATH"
#
#OUTDIR=output

# Creating new simulator with a unique name
#SIMULATOR_NAME=$(uuidgen)
#SIMULATOR_UUID=$(xcrun simctl create "${SIMULATOR_NAME}" 'iPhone 14')

#rm -rf "$OUTDIR"

# Any args passed to this script will be passed along to xcodebuild
xcodebuild test \
    -scheme WeatherAppTests\
    -workspace WeatherApp.xcworkspace\
    -destination "platform=iOS Simulator,name=${SIMULATOR_NAME}"\
    -test-timeouts-enabled YES\
    -maximum-test-execution-time-allowance 30\
    -derivedDataPath derivedData
#    -resultBundlePath "$OUTDIR" \
    "$@" \
    | tee testlog
RESULT=$?

#./scripts/xcresult2junit.rb "$OUTDIR" > "$OUTDIR"/report.junit

# Deleting newly created simulator
#xcrun simctl delete "${SIMULATOR_UUID}"

exit $RESULT
