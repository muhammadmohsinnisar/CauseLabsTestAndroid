.class public Lcom/sauce/third/IngredientFinder;
.super Ljava/lang/Object;
.source "IngredientFinder.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static decrypt([BLjava/lang/String;)[B
    .locals 3
    .param p0, "encrypted"    # [B
    .param p1, "pass"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 35
    invoke-static {p1}, Lcom/sauce/third/IngredientFinder;->getKey(Ljava/lang/String;)Ljavax/crypto/SecretKey;

    move-result-object v0

    .line 36
    .local v0, "secretKey":Ljavax/crypto/SecretKey;
    const-string v1, "AES/ECB/PKCS5PADDING"

    invoke-static {v1}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v1

    .line 37
    .local v1, "cipher":Ljavax/crypto/Cipher;
    const/4 v2, 0x2

    invoke-virtual {v1, v2, v0}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;)V

    .line 38
    invoke-virtual {v1, p0}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v2

    return-object v2
.end method

.method public static find(Landroid/content/Context;)Ljava/lang/String;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 21
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    const-string v1, "data3"

    invoke-virtual {v0, v1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v0

    .line 22
    .local v0, "is":Ljava/io/InputStream;
    invoke-virtual {v0}, Ljava/io/InputStream;->available()I

    move-result v1

    new-array v1, v1, [B

    .line 23
    .local v1, "bytes":[B
    invoke-virtual {v0, v1}, Ljava/io/InputStream;->read([B)I

    .line 24
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 26
    sget v2, Lcom/sauce/third/R$string;->NaCl:I

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 27
    .local v2, "password":Ljava/lang/String;
    new-instance v3, Ljava/lang/String;

    .line 29
    const/4 v4, 0x0

    invoke-static {v1, v4}, Landroid/util/Base64;->decode([BI)[B

    move-result-object v4

    .line 28
    invoke-static {v4, v2}, Lcom/sauce/third/IngredientFinder;->decrypt([BLjava/lang/String;)[B

    move-result-object v4

    sget-object v5, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v3, v4, v5}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 31
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    .line 27
    return-object v3
.end method

.method public static getKey(Ljava/lang/String;)Ljavax/crypto/SecretKey;
    .locals 4
    .param p0, "myKey"    # Ljava/lang/String;

    .line 42
    const/4 v0, 0x0

    .line 44
    .local v0, "sha":Ljava/security/MessageDigest;
    :try_start_0
    const-string v1, "UTF-8"

    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    .line 45
    .local v1, "key":[B
    const-string v2, "SHA-1"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    move-object v0, v2

    .line 46
    invoke-virtual {v0, v1}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v2

    move-object v1, v2

    .line 47
    const/16 v2, 0x10

    invoke-static {v1, v2}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v2

    move-object v1, v2

    .line 48
    new-instance v2, Ljavax/crypto/spec/SecretKeySpec;

    const-string v3, "AES"

    invoke-direct {v2, v1, v3}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 51
    .end local v1    # "key":[B
    :catch_0
    move-exception v1

    .line 52
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_0

    .line 49
    .end local v1    # "e":Ljava/io/UnsupportedEncodingException;
    :catch_1
    move-exception v1

    .line 50
    .local v1, "e":Ljava/security/NoSuchAlgorithmException;
    invoke-virtual {v1}, Ljava/security/NoSuchAlgorithmException;->printStackTrace()V

    .line 53
    .end local v1    # "e":Ljava/security/NoSuchAlgorithmException;
    nop

    .line 54
    :goto_0
    const/4 v1, 0x0

    return-object v1
.end method
