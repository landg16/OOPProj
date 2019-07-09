package Objects;

public class LeaderUsers {
    private int id;
    private String firstName;
    private String lastName;
    private int score;

    public LeaderUsers(int id, String firstName, String lastName, int score) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.score = score;
    }

    public int getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public int getScore() {
        return score;
    }
}
