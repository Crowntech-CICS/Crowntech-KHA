package model;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.*;

public class Encryption {

    public static String encrypt(String strToEncrypt, String key, String cipherVal) {
        String encryptedString = null;
        try {
            byte[] key2 = key.getBytes();
            Cipher cipher = Cipher.getInstance(cipherVal);
            final SecretKeySpec secretKey = new SecretKeySpec(key2, "AES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            encryptedString = Base64.encodeBase64String(cipher.doFinal(strToEncrypt.getBytes()));
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return encryptedString;
    }

    public static String decrypt(String codeDecrypt, String key, String cipherVal) {
        String decryptedString = null;
        try {
            byte[] key2 = key.getBytes();
            Cipher cipher = Cipher.getInstance(cipherVal);
            final SecretKeySpec secretKey = new SecretKeySpec(key2, "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            decryptedString = new String(cipher.doFinal(Base64.decodeBase64(codeDecrypt)));
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return decryptedString;
    }
}
