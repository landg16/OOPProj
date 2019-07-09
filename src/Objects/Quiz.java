package Objects;

import java.awt.*;
import java.util.ArrayList;

public class Quiz {

    private int id;
    private String title;
    private String description;
    private String imageUrl;
    private String type;

    public Quiz(int id, String title, String description, String imageUrl, String type){
        this.id = id;
        this.title = title;
        this.description = description;
        this.imageUrl = imageUrl;
        this.type = type;
    }

    public int getQuizId(){
        return id;
    }

    public String getQuizTitle(){
        return title;
    }

    public String getQuizDescription(){
        return description;
    }

    public String getQuizImage(){
        return imageUrl;
    }

    public String getQuizType(){
        return type;
    }
}
