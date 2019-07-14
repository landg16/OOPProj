package Objects;

public class Answer {
    private int id;
    private int question_id;
    private String answer;
    private boolean isCorrect;

    public Answer(int id, int question_id, String answer, boolean isCorrect) {
        this.id = id;
        this.question_id = question_id;
        this.answer = answer;
        this.isCorrect = isCorrect;
    }

    public int getId() {
        return id;
    }

    public int getQuestion_id() {
        return question_id;
    }

    public String getAnswer() {
        return answer;
    }

    public boolean isCorrect() {
        return isCorrect;
    }
}
