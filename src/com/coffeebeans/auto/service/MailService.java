package com.coffeebeans.auto.service;

public interface MailService {

	void sendNotification(String iSubject, String[] iToEmail, String iBody);
}
