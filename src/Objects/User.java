package Objects;

public class User {

    private int id;
    private String firstName;
    private String lastName;
    private String userName;
    private String email;
    private String password;
    private boolean isAdmin; // equal to 0 or 1
    private String imageUrl;
    private hashPassword hash;

    public User(int id, String firstName, String lastName, String username,
                     String email, String password, boolean isAdmin, String imageUrl){
        this.id = id;
        hash = new hashPassword();
        this.firstName = firstName;
        this.lastName = lastName;
        this.userName = username;
        this.email = email;
        this.isAdmin = isAdmin;
        this.password = hash.hashPassword(password);
        this.imageUrl = imageUrl;
    }

    public void getRank(){

    }

    public int getId() {
        return id;
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

    public String getImageurl () { return imageUrl; }

    public String getPassword() {
        return password;
    }

    public boolean getIsAdmin() {
        return isAdmin;
    }

    public void setPassword(String password) {
        this.password = hash.hashPassword(password);
    }

}
