package com.coffeebeans.auto.service.impl;

import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.coffeebeans.auto.service.MailService;

@Service("MailService")
public class MailServiceImpl implements MailService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MailServiceImpl.class);

	@Value("${mail.user}")
	private String mailUser;
	
	@Value("${mail.password}")
	private String mailPassword;
	
	public void sendNotification(String iSubject, String[] iToEmail, String iBody) {

		String from = "explorechanges@gmail.com";
		final String username = mailUser;
		final String password = mailPassword;

		String host = "smtp.gmail.com";
		Properties props = new Properties();
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "587");
		props.put("mail.debug", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.EnableSSL.enable", "true");

		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.setProperty("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.port", "465");
		props.setProperty("mail.smtp.socketFactory.port", "465");

		// Get the Session object.
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			// Create a default MimeMessage object.
			Message message = new MimeMessage(session);

			// Set From: header field of the header.
			message.setFrom(new InternetAddress(from));

			InternetAddress[] sendTo = new InternetAddress[iToEmail.length];
			for (int i = 0; i <iToEmail.length; i++) {
				System.out.println("Send to:" + iToEmail[i]);
				sendTo[i] = new InternetAddress(iToEmail[i]);
			}
			
			// Set To: header field of the header.
			message.setRecipients(Message.RecipientType.TO, sendTo);

			// Set Subject: header field
			message.setSubject(iSubject);
			StringBuffer msg = new StringBuffer();
			msg.append(
					"<html><body><div style=\"background-color:#3f51b5f2; height:50px;\"><span style=\"float:right;margin-top:1%; margin-right:1%; font-size:25px; color:white;\"><strong><em> Coffeebeans</em></strong></span></div><div style=\"background-color:#00c4ff78; margin-bottom:5px;\">");
			msg.append("<br>" + iBody);
			msg.append(
					"</div><div style=\"background-color:#3f51b5f2; height:40px;\"><strong><span style=\"float:left; color:white; margin-top:5px;\">Thanks,<br>Coffeebeans Team</span></strong></div></body></html>");

			message.setContent(msg.toString(), "text/html; charset=utf-8");
			// Send message
			Transport.send(message);

			LOGGER.info("Sent message successfully with subject...." + iSubject + " to :" + iToEmail);

		} catch (MessagingException e) {
			LOGGER.error("Exception occurred while sending mail to the recipient for subject...." + iSubject + " to :" + iToEmail + " ERROR:" + e.getMessage());
		}

	}
}
