# GeoGebra
Dockerized GeoGebra

## Development

The development flow is roughly as follows

1. Make your changes
2. To test your changes, rebuild and tag the docker image by running `docker build -t "863419159770.dkr.ecr.eu-north-1.amazonaws.com/geogebra:v$(npm pkg get version | tr -d \")" .`
3. Restart the digabi2 docker compose to make sure that the new image is used.

## Development release

To release a new development version of GeoGebra, run `./dev-release.sh <major|minor|patch|<semver>>`. This will create a new git tag, and build and push a Docker image with that tag into our private ECR. Building and pushing to ECR happens in Github Actions. You can view the workflow progress [here](https://github.com/digabi/abitti2-geogebra/actions/workflows/dev-release.yml). Once built and pushed, you can update the GeoGebra version `apps-dev.json` in the `digabi2` repository to point to the new tag.

## Release

To promote a development version of the image to production (i.e. release it to our public ECR) run `./release.sh`. Choose the tag you want to promote to production, which will trigger a Github Actions workflow. The workflow will push the corresponding private image to our public ECR. You can view the workflow progress [here](https://github.com/digabi/abitti2-geogebra/actions/workflows/manual-prod-release.yml). After this has completed, update the GeoGebra version in `apps-prod.json` in the `digabi2` repository to point to the newly released image tag.
