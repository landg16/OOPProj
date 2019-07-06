package Objects;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class User {

    private String FirstName;
    private String LastName;
    private String NickName;
    private String Email;
    private String Password;

    public static String hexToString(byte[] bytes) {
        StringBuffer buff = new StringBuffer();
        for (int i = 0; i < bytes.length; i++) {
            int val = bytes[i];
            val = val & 0xff;  // remove higher bits, sign
            if (val < 16) buff.append('0'); // leading 0
            buff.append(Integer.toString(val, 16));
        }
        return buff.toString();
    }

    private String hashPassword(String password) {
        MessageDigest md = null;
        String hashtext = null;
        try {
            md = MessageDigest.getInstance("SHA-256");
            byte[] messageDigest = md.digest(password.getBytes());
            hashtext = hexToString(messageDigest);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return hashtext;
    }

    public User(String firstName, String lastName, String nickName,
                     String email, String password){
        FirstName = new String(firstName);
        LastName = new String(lastName);
        NickName = new String(nickName);
        Email = new String(email);
        Password = new String(hashPassword(password));
    }

    public void getRank(){

    }

    public String getFirstName(){
        return FirstName;
    }

    public String getLastName(){
        return LastName;
    }

    public String getNickName(){
        return NickName;
    }

    public String getEmail(){
        return Email;
    }

    public void setPassword(String password) {
        Password = hashPassword(password);
    }

    public String getPassword() {
        return Password;
    }

}
