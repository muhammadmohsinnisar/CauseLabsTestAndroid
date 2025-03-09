**Contents:**
* Includes all source code files for the Android application.
* Includes the src/ folder of the dex-patching project.
* Detailed description of the approaches taken for each challenge.
* A screenshot of the Android application displaying all three correct ingredients after successful completion of the first two challenges.

**Approach:**

* Use apkTools to unpack the apk.
* Open sauce in android studio for better readability but used subtime text for fixing the smali code.

**Data1 decrypted into raisin:**

* I started by installing and running the sauce.apk on my device. I observed the app's user interface, noticing the input fields for the ingredients and the initial interaction gave you a sense of the app's purpose and the challenge at hand.
* I used apktool d to decompile the APK, revealing its internal structure.
* I began exploring the decompiled resources, starting with the AndroidManifest.xml and the res/ folder.
* I looked through the res/values/strings.xml file, which contained the app's text strings.
* I found a secret key in strings.xml which was named NaCl. I realised that the key had some purpose.
* Then I found a subfolder, which contained data1, data2, and data3. I realised that these must be related to what I am looking for as I observed that it contained a string of seemingly random characters.
* It was in my head something encoded/encrypted data.
* To verify if the string was simply base64 encoded, I used a base64 command.
* The decoded output was the string "raisins".
* I entered "raisins" into the first ingredient input field in the app. The app accepted the input, confirming that "raisins" was the correct first ingredient.

**Data2 encryption:**

* I checked com.sauce.second.IngredientFinder.smali code was analyzed, revealing that data2 is encrypted using AES/ECB/PKCS5Padding.
* The decryption key is derived from the string NaCL which I found by searching for the “key” keyword in the strings.xml by taking the first 16 bytes of its SHA-1 hash.
* For this I used a kotlin method which reads the encrypted data from the specified file path, decodes the data using Base64, calls the decryptAesEcbPkcs5Padding()[method in kotlin class, generic method from stackoverflow] method to decrypt the data, Converts the decrypted bytes to a UTF-8 string.
* I decrypted the decoded data using AES/ECB/PKCS5Padding with a password.
* I relied on analyzing the app's code to understand the decryption process. And found the decryption key directly within the app's source code.

**Data3 encryption:**

* I could see that the third ingredient involved patching the .dex file to correct an encryption/decryption error.
* It was quite straightforward to read that the cipher was encrypting instead of decrypting.
* So the solution was to modify the decrypt() method in the Smali code to change const/4 v2, 0x1 to const/4 v2, 0x2.
* And then I ran the patch.sh script and subsequently decompiled the resulting patched APK.
* However, to my surprise, I discovered that my manual Smali code changes were absent in the decompiled patched APK.
* Through investigation, I realized that the patch.sh script was designed to operate on the original sauce.apk file, effectively overwriting any manual modifications I had made in the decompiled folder.
* This was a big issue as I was confused why my changes were not there, and I wasted time until I realized what was happening.
* I recognized the limitations of the patch.sh script for my specific needs, so I decided to abandon the automated approach.
* I opted for a manual Smali patching strategy, leveraging apktool for rebuilding the APK.
* I already identified the Cipher.init() call within the Smali code, which was incorrectly set to encryption mode (Cipher.ENCRYPT_MODE).
* I manually edited the Smali code to change the Cipher.init() call to decryption mode (Cipher.DECRYPT_MODE) simply using a text viewer and saved the modified Smali file.
* Then used apktool b to rebuild the APK with the patched Smali code.
* And used the sign.sh script to sign the apk.
* After installing the patched APK, I attempted to decrypt the third ingredient.
* I used the same decryption approach as with the second ingredient method and used the password found in the source code.
* Despite my patching efforts, the decryption did not produce the expected result.
* Although the encryption to decryption mode was corrected, it is possible other issues remained that prevented the correct decryption.
* I recognized that I was unable to fully solve the third ingredient challenge.
* I concluded that there were still issues preventing successful decryption, even after correcting the encryption/decryption mode.
* I documented my attempts and challenges in my submission, as requested by the instructions.
