package com.easycab.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.xml.bind.DatatypeConverter;

public class Hasher {

    public static String hash(String data)
            throws
            NoSuchAlgorithmException {

        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
        messageDigest.update(data.getBytes());
        byte[] digest = messageDigest.digest();
        return DatatypeConverter
                .printHexBinary(digest).toUpperCase();
    }

    /**
     * Verifies if the hash of the data matches the storedHash
     *
     * @param data
     * @param storedHash
     * @return boolean
     */
    public static boolean verify(String data, String storedHash) {
        try {
            return hash(data).equals(storedHash);
        } catch (NoSuchAlgorithmException ex) {
            return false;
        }
    }
}
