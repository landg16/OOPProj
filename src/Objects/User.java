package Objects;

public class User {

    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String password;
    private String imageurl;
    private hashPassword hash;

    public User(String firstName, String lastName, String username,
                     String email, String password, String imageurl){
        hash = new hashPassword();
        this.firstName = firstName;
        this.lastName = lastName;
        this.userName = username;
        this.email = email;
        this.password = hash.hashPassword(password);
        this.imageurl = imageurl;
    }

    public void getRank(){

    }

    public String getFirstname(){
        return firstName;
    }

    public String getLastname(){
        return lastName;
    }

    public String getUsername(){
        return userName;
    }

    public String getEmail(){
        return email;
    }

    public String getImageurl () { return imageurl; }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = hash.hashPassword(password);
    }

}
