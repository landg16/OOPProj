package Objects;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class hashPassword {

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

    public String hashPassword(String password) {
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

}
