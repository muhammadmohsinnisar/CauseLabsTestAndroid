#!/bin/bash

zipalign -f 4 apk/sauce-patched.apk apk/sauce-patched-aligned.apk
if [ ! -f apk/debug.keystore ]; then
  echo "generating new keystore"
  keytool -genkey -v -keystore apk/debug.keystore -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000 -dname "cn=Unknown, ou=Unknown, o=Unknown, c=Unknown"
fi
apksigner sign --ks apk/debug.keystore --ks-pass pass:android --in apk/sauce-patched-aligned.apk --out apk/sauce-patched-signed.apk