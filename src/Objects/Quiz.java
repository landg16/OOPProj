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


    public Quiz(int id, int quizOwnerId, String description, String imageUrl, String type, String title){
        this.id = id;
        this.quizOwnerId = quizOwnerId;
        this.description = description;
        this.imageUrl = imageUrl;
        this.type = type;
        this.title = title;
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
}
