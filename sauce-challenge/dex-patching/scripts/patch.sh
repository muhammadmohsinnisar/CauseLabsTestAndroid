#!/bin/bash

echo "Packaging .jar"
mvn -q package
echo "Exctracting apk"
unzip -d apk/extracted apk/sauce.apk > /dev/null
echo "Find .dex files and apply patch"
find ./apk/extracted -name "*.dex" -exec java -jar target/dex-challenge-1.0-shaded.jar {} \;
echo "Packaging patched files"
(cd apk/extracted; zip -r ../sauce-patched.apk ./ > /dev/null)
rm -rf apk/extracted