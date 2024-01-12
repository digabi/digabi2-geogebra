geogebra_bundle=geogebra-math-apps-bundle-5-2-820-0.zip

public/GeoGebra/deployggb.js:
	mkdir -p cache
	curl -O --output-dir cache https://download.geogebra.org/installers/5.2/$(geogebra_bundle)
	rm -rf public/GeoGebra
	sha512sum -c sha512sum.txt
	unzip -o cache/$(geogebra_bundle) -d public
