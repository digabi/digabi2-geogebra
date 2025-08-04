mod? digabi2-companion-app

gh := require("gh")
jq := require("jq")

GEOGEBRA_APPS_BUNDLE_URL := "https://download.geogebra.org/package/geogebra-math-apps-bundle"

build: fetch
    @just digabi2-companion-app build

dev-release version: fetch
    @just digabi2-companion-app dev-release "{{ version }}"

prod-release: fetch
    @just digabi2-companion-app prod-release

submodule-init: fetch
    @just digabi2-companion-app submodule-init

submodule-update: fetch
    @just digabi2-companion-app submodule-update

update-geogebra:
    #!/usr/bin/env bash
    set -euo pipefail

    GEOGEBRA_APPS_BUNDLE_FILE="geogebra-math-apps-bundle.zip"

    wget -O $GEOGEBRA_APPS_BUNDLE_FILE "{{ GEOGEBRA_APPS_BUNDLE_URL }}"
    unzip -o $GEOGEBRA_APPS_BUNDLE_FILE -d ./public
    rm -f $GEOGEBRA_APPS_BUNDLE_FILE

[private]
fetch:
    @{{ gh }} api repos/digabi/digabi2-companion-app-shared/contents/digabi2-companion-app.just | \
    {{ jq }} -r '.download_url' | \
    wget --quiet --input-file - --output-document digabi2-companion-app.just
