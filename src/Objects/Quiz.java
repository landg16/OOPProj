package Objects;

import java.awt.*;
import java.util.ArrayList;

public class Quiz {

    private String title;
    private int id;
    private int quizOwnerId;
    private String description;
    private String imageUrl;
    private String type;
    private boolean immediate_correction;


    public Quiz(int id, int quizOwnerId, String description, String imageUrl, String type, String title, boolean immediate_correction){
        this.id = id;
        this.quizOwnerId = quizOwnerId;
        this.description = description;
        this.imageUrl = imageUrl;
        this.type = type;
        this.title = title;
        this.immediate_correction = immediate_correction;
    }

    public int getQuizId(){ return id; }

    public int getQuizOwnerId() { return quizOwnerId; }

    public String getQuizDescription(){
        return description;
    }

    public String getQuizImage(){
        return imageUrl;
    }

    public String getQuizType(){
        return type;
    }

    public String getQuizTitle() { return title;};

    public boolean getQuizIsImmediate() { return immediate_correction; }
}
