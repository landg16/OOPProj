package DataAccess;

import Objects.*;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.time.format.DateTimeFormatter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.time.Clock;
import java.util.Date;
import java.util.Calendar;
import java.sql.*;
import java.lang.String;

public class DatabaseManager {

    private static Connection connect;

    public static void main(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/sonoo","root","saxlshivar97");
            Statement statement = connect.createStatement();

        }catch (Exception e){

        }
    }

    public void insertUser(User newUser){
        try {
            PreparedStatement state = connect.prepareStatement("insert into users values(?,?,?,?,?,?,?)");
            state.setString(2, newUser.getFirstName());
            state.setString(3, newUser.getLastName());
            state.setString(4, newUser.getNickName());
            state.setString(5, newUser.getEmail());
            state.setString(6, newUser.getPassword());
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean emailExists(String email){
        try {
            PreparedStatement state = connect.prepareStatement("select email from users order by email");
            ResultSet emails = state.executeQuery();
            if (emails.next()) {
                String searched = emails.getString(email);
                if (searched.equals(email)) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void changeEmail(int userId, String newEmail){
        try {
            PreparedStatement state = connect.prepareStatement("UPDATE users set email = ? where id = ?");
            state.setString(1, newEmail);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean nickNameExists(String nickName){
        try {
            PreparedStatement state = connect.prepareStatement("select nickName from users order by nickName");
            ResultSet emails = state.executeQuery();
            if (emails.next()) {
                String searched = emails.getString(nickName);
                if (searched.equals(nickName)) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void changeUserNickName(int userId, String newNickName){
        try {
            PreparedStatement state = connect.prepareStatement("UPDATE users set nickname = ? where id = ?");
            state.setString(1, newNickName);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static String hexToString(byte[] bytes) {
        StringBuffer buff = new StringBuffer();
        for (int i = 0; i < bytes.length; i++) {
            int val = bytes[i];
            val = val & 0xff;  // remove higher bits, sign
            if (val < 16) buff.append('0'); // leading 0
            buff.append(Integer.toString(val, 16));
        }
        return buff.toString();
    }

    private String hashPassword(String password) {
        MessageDigest md = null;
        String hashtext = null;
        try {
            md = MessageDigest.getInstance("SHA-256");
            byte[] messageDigest = md.digest(password.getBytes());
            hashtext = hexToString(messageDigest);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return hashtext;
    }

    public void changePassword(int userId, String newPassword){
        String pass = hashPassword(newPassword);
        try {
            PreparedStatement state = connect.prepareStatement("UPDATE users set password = ? where id = ?");
            state.setString(1, pass);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getScore(int userId){
        //todo
        try {
            PreparedStatement state = connect.prepareStatement("select points from users where userid = ?");
            state.setInt(1, userId);
            int score = state.executeQuery().getInt(7);
            return score;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void updateScore(int userId, int score){
        int res = getScore(userId);
        try {
            PreparedStatement state = connect.prepareStatement("UPDATE users set points = ? where id = ?");
            state.setInt(1, res+score);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void insertQuiz(int creatorId, String title, String descripption, int categoryId,
                       boolean random, boolean onePage, boolean immCorr, boolean pracMode, String image){
        //todo
        try {
            PreparedStatement state = connect.prepareStatement("insert into quizes values(?,?,?,?,?,?,?,?,?,?,?)");
            state.setInt(2, creatorId);
            state.setString(3, title);
            state.setString(4, descripption);
            state.setInt(5, categoryId);
            state.setBoolean(6, random);
            state.setBoolean(7, onePage);
            state.setBoolean(8, immCorr);
            state.setBoolean(9, pracMode);
            state.setString(10, image);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void InsertQuestion(int quizId, String type, String question, String secondPart){

        try {
            PreparedStatement state = connect.prepareStatement("insert into questions values(?,?,?,?,?)");
            state.setInt(2, quizId);
            state.setString(3, type);
            state.setString(4, question);
            state.setString(5, secondPart);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertAnswer(int questionId, String answer, boolean correctness, String type) {

        try {
            PreparedStatement state = connect.prepareStatement("insert into answers values(?,?,?,?,?)");
            state.setInt(2, questionId);
            state.setString(3, answer);
            state.setBoolean(4, correctness);
            state.setString(5, type);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void InsertFriend(int userId1, int userId2){
        try {
            PreparedStatement state = connect.prepareStatement("insert into friends values(?,?)");
            state.setInt(1, userId1);
            state.setInt(2, userId2);
            state.executeUpdate();
            state.setInt(1, userId2);
            state.setInt(2, userId1);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertHistory(int userId, int quizId, double quizScore, Date dateTime, Time time) {

        try {
            PreparedStatement state = connect.prepareStatement("insert into user_history values(?,?,?,?,?,?)");
            state.setInt(2, userId);
            state.setInt(3, quizId);
            state.setDouble(4, quizScore);
            state.setDate(5, (java.sql.Date) dateTime);
            state.setTime(6, time);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertCategory(String name) {
        try {
            PreparedStatement state = connect.prepareStatement("insert into category values(?,?)");
            state.setString(2, name);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static ArrayList<Quiz> getQuizes(){
//        Quiz quiz = new Quiz(1, "Didebuli quizi","img/quizzes/football.jpg", "Sport");
        ArrayList<Quiz> quizzes = new ArrayList<>();
//        quizzes.add(quiz);
//        quizzes.add(quiz);
//        quizzes.add(quiz);
//        quizzes.add(quiz);
//        quizzes.add(quiz);
//        quizzes.add(quiz);
        try {
            PreparedStatement state = connect.prepareStatement("select q.id, q.creator_id, q.description, q.image, c.name from quizes q" +
                    "inner join category c on q.category_id = c.id");
            ResultSet quizes = state.executeQuery();
            while (quizes.next()) {
                Quiz quiz = new Quiz(quizes.getInt(1), quizes.getInt(2), quizes.getString(3),
                        quizes.getString(4), quizes.getString(5));
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quizzes;
    }

    private static ArrayList<LeaderUsers> castResults(ResultSet results) throws SQLException {
        ArrayList<LeaderUsers> users = new ArrayList<LeaderUsers>();
        while (results.next()) {
            LeaderUsers leaders = null;
                leaders = new LeaderUsers(results.getInt(1), results.getString(2),
                        results.getString(3), results.getInt(4));

            users.add(leaders);
        }
        return users;
    }

    public static ArrayList<LeaderUsers> getLeaderUsers() {
        ArrayList<LeaderUsers> users = new ArrayList<LeaderUsers>();
        try {
            PreparedStatement state = connect.prepareStatement("select u.id, u.firsname, u.lastname, sum(uh.quiz_score) scores from users u" +
                    " inner join user_history uh on u.id = uh.user_id group by uh.user_id order by scores desc limit 100");
            ResultSet list = state.executeQuery();
            return castResults(list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<LeaderUsers> getDailyLeaderUsers() {
        try {
            PreparedStatement state = connect.prepareStatement("select u.id, u.firsname, u.lastname, sum(uh.quiz_score) scores from users u" +
                    " inner join user_history uh on u.id = uh.user_id group by uh.user_id having uh.quiz_date > (NOW() - INTERVAL 1 DAY) order by scores desc");
            ResultSet list = state.executeQuery();
            return castResults(list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<UserHistory> getUserHistory(int userId) {

        ArrayList<UserHistory> history = new ArrayList<UserHistory>();
        try {
            PreparedStatement state = connect.prepareStatement("select uh.quiz_id, q.title, uh.quiz_date, uh.quit_time, uh.quiz_score " +
                    "from user_history uh INNER JOIN quizes q on uh.quiz_id = q.id where uh.user_id = "+userId);
            ResultSet userHistory = state.executeQuery();
            while (userHistory.next()) {
                UserHistory his = new UserHistory(userHistory.getInt(1), userHistory.getDate(2), userHistory.getTime(3),
                        userHistory.getString(4), userHistory.getInt(5));
                history.add(his);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }


    public static Quiz getQuiz(int quizId){
        Quiz quiz = new Quiz(quizId, 1, "Rakai Chaia Jo", "img/quizzes/football.jpg", "Sport");
        return quiz;
    }

    public static User getUser(int userId){
        User user = new User("jotia", "caava", "jtcava", "jorji", "jarji");
        return user;
    }
}
