# GeoGebra

Dockerized GeoGebra.

## Development

GeoGebra source code has been obtained from https://download.geogebra.org/package/geogebra-math-apps-bundle, linked at https://geogebra.github.io/docs/reference/en/GeoGebra_Apps_Embedding. It does not seem to be available on Git and can therefore not be submoduled.

```bash
# Pull in latest GeoGebra
just update-geogebra

# Build image locally
just build

# Create development release
just dev-release <major/minor/patch/<semver>>

# Promote release to production
just prod-release
```
