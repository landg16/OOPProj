package Objects;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class User {

    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String password;
    private hashPassword hash;

    public User(String firstName, String lastName, String username,
                     String email, String password){
        this.firstName = new String(firstName);
        this.lastName = new String(lastName);
        this.userName = new String(username);
        this.email = new String(email);
        this.password = new String(hash.hashPassword(password));
    }

    public void getRank(){

    }

    public String getFirstName(){
        return firstName;
    }

    public String getLastName(){
        return lastName;
    }

    public String getNickName(){
        return userName;
    }

    public String getEmail(){
        return email;
    }

    public void setPassword(String password) {
        password = hash.hashPassword(password);
    }

    public String getPassword() {
        return password;
    }

}
