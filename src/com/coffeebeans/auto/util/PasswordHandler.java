package com.coffeebeans.auto.util;

import java.io.UnsupportedEncodingException;

import javax.xml.bind.DatatypeConverter;

public class PasswordHandler {

	public static String encrypt(String str) {

		try {
			byte[] message = str.getBytes("UTF-8");
			String encoded = DatatypeConverter.printBase64Binary(message);
			return encoded;
		} catch (UnsupportedEncodingException e) {
		}
		return null;
	}

	public static String decrypt(String str) {
		try {
			byte[] decoded = DatatypeConverter.parseBase64Binary(str);
			String decodedVal = new String(decoded, "UTF-8");
			return decodedVal;
		} catch (UnsupportedEncodingException e) {
		}
		return null;
	}

	public static void main(String[] args) {
		System.out.println("Before encryption " + encrypt("sample"));
		System.out.println("After decryption " + decrypt("decrpted"));
	}
}
