package model;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {
    public static void send(String from, String password, String to, String subject, String message){
        //Put properties of SMTP Server
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");    
        props.put("mail.smtp.socketFactory.port", "465");    
        props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");    
        props.put("mail.smtp.auth", "true");    
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.ssl.enable", "true");
        
        //Get Session
        Session session = Session.getInstance
        (
            props,    
            new javax.mail.Authenticator() {    
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {    
                 return new PasswordAuthentication(from,password);  
                }    
            }
        );    
        
        try {
            MimeMessage email = new MimeMessage(session);
            email.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            email.setSubject(subject);
            email.setText(message);
            //Send email
            Transport.send(email);
            System.out.println("Email sent successfully.");
        } catch (MessagingException e) {
            System.err.println("Error sending email. " + e.getMessage());
        }
    }
    public static void sendHtml(String from, String password, String to, String subject, String html){
        //Put properties of SMTP Server
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");    
        props.put("mail.smtp.socketFactory.port", "465");    
        props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");    
        props.put("mail.smtp.auth", "true");    
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.ssl.enable", "true");
        
        //Get Session
        Session session = Session.getInstance
        (
            props,    
            new javax.mail.Authenticator() {    
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {    
                 return new PasswordAuthentication(from,password);  
                }    
            }
        );    
        
        try {
            MimeMessage email = new MimeMessage(session);
            email.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            email.setSubject(subject);
            email.setContent(html,"text/html");
            //Send email
            Transport.send(email);
            System.out.println("Email sent successfully.");
        } catch (MessagingException e) {
            System.err.println("Error sending email. " + e.getMessage());
        }
    }
}
