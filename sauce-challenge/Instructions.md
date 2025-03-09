# Sauce Labs Android Coding Challenge
****** Read the instructions carefully. ******

We have a simple Android app (`sauce.apk`) that checks for the ingredients of a Sauce.
Each input field is a task on it's own for this challenge.
Try to find the missing ingredients for the sauce and submit a description of how you were trying to solve it.

*Hint:* a tool like [apktool](https://ibotpeaches.github.io/Apktool/) will help to see how the app is implemented.

Have fun!

**IN YOUR SUBMISSION PLEASE INCLUDE THE DESCRIPTION OF THE APPROACHES YOU TOOK EVEN THOUGH YOU WERE NOT ABLE TO COMPLETE EVERYTHING!**

## Submission format

Please pack all **source** (also for the third task we only need the `src/` folder of the project) and **text** files into an .zip archive to submit it.
Once you have solved all the three challenges, run the app with the correct values, take a screenshot and submit it along with the .zip archive.

## 1. Hidden Ingredient

The first ingredient is in the non-encrypted format and stored inside the .apk. This is fairly easier to find. Lets start looking inside the .apk

## 2. Encrypted Ingredient

The second ingredient was encrypted with a password. Both the password and the encrypted ingredient is stored somewhere inside the .apk

Lets try to find both values and decrypt the data!

The preferred solution here is to submit a short program that performs the decryption of the data, but if time is running short you can use the `openssl` tool: `echo "{BASE_64_INPUT}" | openssl enc {CIPHERNAME} -d -pass 'pass:{PASSWORD}' -md "SHA1" -nosalt -base64` and submit the value for the second ingredient.

## 3. .dex file patching
We would love to see you attempt this challenge and hopefully complete it. The challenge is not only to find the third ingredient, but also to modify the dex code of the input apk.
The third ingredient is again stored encrypted in the app. We have made a mistake and instead of decrypting the ingredient, we are encrypting it again ([Java Cipher doc](https://docs.oracle.com/en/java/javase/16/docs/api/java.base/javax/crypto/Cipher.html#init(int,java.security.Key)))!

There is a boilerplate maven project in `dex-patching` that uses [dexlib2](https://github.com/JesusFreke/smali).
It takes a single .dex file as input, applies the specified rewriting and writes it back to the same file.
(Note: The input file `apk/sauce.apk` is a copy of the `sauce.apk` present in the root folder of the directory).

There are scripts provided to handle unpacking the .apk, running the dex-patching project on all .dex files, and repacking the .apk again, which is explained below how to use it.
It is possible to run those scripts either directly on your machine if you have everything installed, or otherwise there is a Dockerfile that does the same.

### With scripts

You need to have Java 16 installed and the following executables in your `$PATH`:
- mvn
- unzip
- keytool
- zipalign
- apksigner

If that is available, you can run `scripts/patch.sh` for creating a patched .apk file and `scripts/sign.sh` to sign the .apk so it is installable on a device/emulator.
The .apk file will be at `apk/sauce-patched-signed.apk`.

### With Docker

The docker image has all the required dependencies to build and sign the .apk.
It might take a moment to download as the image with the Android SDK is quite large.
You can run the commands below before you start implementing the solution to speed things up.

For running it inside the `dex-patching` directory - 

```
# Builds the Java project of of this directory and patches the .apk
docker build . -t sauce-challenge
# Starts the container and puts the patched file into the 'apk/' directory
docker run -v $(pwd)/apk:/dist sauce-challenge
```

After that you can take the .apk from `apk/sauce-patched-signed.apk`
