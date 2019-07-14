package Objects;

import java.sql.Date;

public class Quiz {

    private int id;
    private int quizOwnerId;
    private String title;
    private String description;
    private String imageUrl;
    private String type;
    private boolean immediateCorrection;
    private boolean random;
    private boolean onePage;
    private boolean practiceMode;
    private Date creationDate;

    public Quiz(int id, int quizOwnerId, String title, String description, String imageUrl, String type,
                boolean random, boolean onePage, boolean immediateCorrection, boolean practiceMode, Date creationDate) {
        this.title = title;
        this.id = id;
        this.quizOwnerId = quizOwnerId;
        this.description = description;
        this.imageUrl = imageUrl;
        this.type = type;
        this.immediateCorrection = immediateCorrection;
        this.random = random;
        this.onePage = onePage;
        this.practiceMode = practiceMode;
        this.creationDate = creationDate;
    }

    public String getTitle() {
        return title;
    }

    public int getId() {
        return id;
    }

    public int getQuizOwnerId() { return quizOwnerId; }

    public String getDescription() {
        return description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getType() {
        return type;
    }

    public boolean isImmediateCorrection() {
        return immediateCorrection;
    }

    public boolean isRandom() {
        return random;
    }

    public boolean isOnePage() {
        return onePage;
    }

    public boolean isPracticeMode() {
        return practiceMode;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public boolean getQuizDescription() { return false; }
}
