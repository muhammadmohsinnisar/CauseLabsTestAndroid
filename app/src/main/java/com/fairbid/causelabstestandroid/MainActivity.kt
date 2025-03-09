package com.fairbid.causelabstestandroid

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import java.io.FileNotFoundException
import java.security.MessageDigest
import java.util.Base64
import javax.crypto.Cipher
import javax.crypto.spec.SecretKeySpec

class MainActivity : AppCompatActivity() {

    private val password: String by lazy { decodePassword() }

    private lateinit var ingredient1TextView: TextView
    private lateinit var ingredient2TextView: TextView
    private lateinit var ingredient3TextView: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initViews()
        displayIngredients()
    }

    private fun initViews() {
        ingredient1TextView = findViewById(R.id.ingredient1TextView)
        ingredient2TextView = findViewById(R.id.ingredient2TextView)
        ingredient3TextView = findViewById(R.id.ingredient3TextView)
    }

    private fun displayIngredients() {
        ingredient1TextView.text = decodeData1()
        ingredient2TextView.text = decryptData2()
        ingredient3TextView.text = decryptData3()
    }

    private fun decodeData1(): String = decodeFile("ingredients/data1")

    private fun decryptData2(): String = decryptFileWithDecryption("ingredients/data2")

    private fun decryptData3(): String = decryptFileWithDecryption("ingredients/data3")

    private fun decryptFileWithDecryption(filePath: String): String =
        try {
            val encryptedData = readBytesFromFile(filePath)
            val decodedBase64 = Base64.getDecoder().decode(encryptedData)
            val decryptedBytes = decryptAesEcbPkcs5Padding(decodedBase64, password)
            String(decryptedBytes, Charsets.UTF_8).trim()
        } catch (e: Exception) {
            "Decryption error: ${e.message}"
        }

    private fun decodeFile(filePath: String): String =
        try {
            val fileData = readBytesFromFile(filePath)
            val trimmedData = if (fileData.isNotEmpty() && fileData.last().toInt() == 10) {
                fileData.copyOfRange(0, fileData.size - 1)
            } else {
                fileData
            }
            val decoded = Base64.getDecoder().decode(trimmedData)
            String(decoded)
        } catch (e: FileNotFoundException) {
            "File not found: ${e.message}"
        } catch (e: IllegalArgumentException) {
            "Base64 decoding error: ${e.message}"
        }

    private fun readBytesFromFile(filePath: String): ByteArray =
        try {
            assets.open(filePath).use { inputStream ->
                val size = inputStream.available()
                val bytes = ByteArray(size)
                inputStream.read(bytes)
                bytes
            }
        } catch (e: Exception) {
            ByteArray(0)
        }

    private fun decryptAesEcbPkcs5Padding(encryptedData: ByteArray, password: String): ByteArray {
        val key = generateKey(password)
        val cipher = Cipher.getInstance("AES/ECB/PKCS5Padding")
        cipher.init(Cipher.DECRYPT_MODE, key)
        return cipher.doFinal(encryptedData)
    }

    private fun generateKey(password: String): SecretKeySpec {
        val digest = MessageDigest.getInstance("SHA-1")
        val keyBytes = digest.digest(password.toByteArray(Charsets.UTF_8)).copyOfRange(0, 16)
        return SecretKeySpec(keyBytes, "AES")
    }

    private fun decodePassword(): String {
        val encodedKey = getString(R.string.encrypted_key)
        return String(Base64.getDecoder().decode(encodedKey))
    }
}