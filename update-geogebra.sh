#!/usr/bin/env bash

set -euo pipefail

GEOGEBRA_APPS_BUNDLE_URL="https://download.geogebra.org/package/geogebra-math-apps-bundle"
GEOGEBRA_APPS_BUNDLE_FILE="geogebra-math-apps-bundle.zip"

wget -O $GEOGEBRA_APPS_BUNDLE_FILE "$GEOGEBRA_APPS_BUNDLE_URL"
unzip -o $GEOGEBRA_APPS_BUNDLE_FILE -d ./public
rm -f $GEOGEBRA_APPS_BUNDLE_FILE
