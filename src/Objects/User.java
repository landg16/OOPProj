package Objects;

public class User {

    private int id;
    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String password;
    private int isAdmin; // equal to 0 or 1
    private String imageurl;
    private hashPassword hash;

    public User(int id, String firstName, String lastName, String username,
                     String email, String password, int isAdmin, String imageurl){
        this.id = id;
        hash = new hashPassword();
        this.firstName = firstName;
        this.lastName = lastName;
        this.userName = username;
        this.email = email;
        this.isAdmin = isAdmin;
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

    public int getIsAdmin() {
        return isAdmin;
    }

    public void setPassword(String password) {
        this.password = hash.hashPassword(password);
    }

}
