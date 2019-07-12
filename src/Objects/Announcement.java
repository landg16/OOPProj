package Objects;

import java.util.Date;

public class Announcement {
    private int id;
    private int announcerId;
    private String title;
    private String text;
    private Date announceDate;

    public Announcement(int id, int announcerId, String title, String text, Date announceDate) {
        this.id = id;
        this.announcerId = announcerId;
        this.title = title;
        this.text = text;
        this.announceDate = announceDate;
    }

    public int getId() {
        return id;
    }

    public int getAnnouncerId() {
        return announcerId;
    }

    public String getTitle() {
        return title;
    }

    public String getText() {
        return text;
    }

    public Date getAnnounceDate() {
        return announceDate;
    }
}
