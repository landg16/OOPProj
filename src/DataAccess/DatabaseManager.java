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
import java.text.DateFormat;
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
    private static hashPassword hash;

    public static void main()  {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/sonoo","root","saxlshivar97");
            Statement statement = connect.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertUser(User newUser) {
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

    public boolean emailExists(String email) {
        try {
            PreparedStatement state = connect.prepareStatement("select email from users where email = "+email);
            ResultSet em = state.executeQuery();
            String searched = null;
                searched = em.getString(1);
            if (searched.equals(email)) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void changeEmail(int userId, String newEmail) throws SQLException {
        PreparedStatement state = connect.prepareStatement("UPDATE users set email = ? where id = ?");
        state.setString(1, newEmail);
        state.setInt(2, userId);
        state.executeUpdate();
    }

    public boolean usernameExists(String username) {
        try {
            PreparedStatement state = connect.prepareStatement("select username from users where username = "+username);
            ResultSet user = state.executeQuery();
            String searched = null;
                searched = user.getString(1);
            if (searched.equals(username)) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkLogin(String username, String password) {
        String pass = hash.hashPassword(password);
        try {
            PreparedStatement state = connect.prepareStatement("select username, password from users where username = "+username+" and password = "+pass);
            ResultSet user = state.executeQuery();
            String name = user.getString(1);
            String passw = null;
                passw = user.getString(2);
            if (name.equals(username) && passw.equals(pass)) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void changeUsername(int userId, String username) {

        try {
            PreparedStatement state = connect.prepareStatement("UPDATE users set username = ? where id = ?");
            state.setString(1, username);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void changePassword(int userId, String newPassword) {

        try {
            String pass = hash.hashPassword(newPassword);
            PreparedStatement state = connect.prepareStatement("UPDATE users set password = ? where id = ?");
            state.setString(1, pass);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getScore(int userId) {
        //todo
        int score = 0;
        try {
            PreparedStatement state = connect.prepareStatement("select points from users where userid = ?");
            state.setInt(1, userId);
            score = state.executeQuery().getInt(7);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return score;
    }

    public void updateScore(int userId, int score) {

        try {
            int res = getScore(userId);
            PreparedStatement state = connect.prepareStatement("UPDATE users set points = ? where id = ?");
            state.setInt(1, res+score);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void insertQuiz(String title, String descripption, int category, boolean random, boolean onePage, boolean immCorr, boolean pracMode, String image) {
        //todo
        try {
            PreparedStatement state = connect.prepareStatement("insert into quizes values(?,?,?,?,?,?,?,?,?,?)");
            state.setString(2, title);
            state.setString(3, descripption);
            state.setInt(4, category);
            state.setBoolean(5, random);
            state.setBoolean(6, onePage);
            state.setBoolean(7, immCorr);
            state.setBoolean(8, pracMode);
            state.setString(9, image);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void InsertQuestion(int quizId, String type, String question, String secondPart) {

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

    public void InsertFriend(int userId1, int userId2) {

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


    public static ArrayList<Quiz> getQuizes () {
        Quiz quiz = new Quiz(1, 1, "Didebuli quizi","img/quizzes/football.jpg", "Sport");
        ArrayList<Quiz> quizzes = new ArrayList<>();
        quizzes.add(quiz);
        quizzes.add(quiz);
        quizzes.add(quiz);
        quizzes.add(quiz);
        quizzes.add(quiz);
        quizzes.add(quiz);
//        try {
//            PreparedStatement state = connect.prepareStatement("select q.id, q.title, q.description, q.image, c.name from quizes q" +
//                    "inner join category c on q.category_id = c.id");
//            ResultSet quizes = state.executeQuery();
//            while (quizes.next()) {
//                Quiz quiz = new Quiz(quizes.getInt(1), 1, quizes.getString(3),
//                        quizes.getString(4), quizes.getString(5));
//                quizzes.add(quiz);
//            }
//    } catch (SQLException e) {
//        e.printStackTrace();
//    }
        return quizzes;
    }

    private static ArrayList<LeaderUsers> castResults(ResultSet results) {

        ArrayList<LeaderUsers> users = new ArrayList<LeaderUsers>();
        try {
            while (results.next()) {
                LeaderUsers leaders = null;
                    leaders = new LeaderUsers(results.getInt(1), results.getString(2),
                            results.getString(3), results.getInt(4));

                users.add(leaders);
            }
            } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public static ArrayList<LeaderUsers> getLeaderUsers() {
        //        try {
//            PreparedStatement state = connect.prepareStatement("select u.id, u.firsname, u.lastname, sum(uh.quiz_score) scores from users u" +
//                    " inner join user_history uh on u.id = uh.user_id group by uh.user_id order by scores desc limit 100");
//            ResultSet list = state.executeQuery();
//            return castResults(list);
        //        } catch (SQLException e) {
//            e.printStackTrace();
//        }
        ArrayList<LeaderUsers> leaderUsers = new ArrayList<>();
        LeaderUsers leaderUser = new LeaderUsers(1, "revaz", "meshvelashvili", 10);
        leaderUsers.add(leaderUser);
        return leaderUsers;
    }

    public static ArrayList<LeaderUsers> getDailyLeaderUsers() throws SQLException {
//        try {
        //            PreparedStatement state = connect.prepareStatement("select u.id, u.firsname, u.lastname, sum(uh.quiz_score) scores from users u" +
//                    " inner join user_history uh on u.id = uh.user_id group by uh.user_id having uh.quiz_date > (NOW() - INTERVAL 1 DAY) order by scores desc");
//            ResultSet list = state.executeQuery();
//            return castResults(list);
        //        } catch (SQLException e) {
//            e.printStackTrace();
//        }
        ArrayList<LeaderUsers> leaderUsers = new ArrayList<>();
        LeaderUsers leaderUser = new LeaderUsers(1, "revaz", "meshvelashvili", 10);
        leaderUsers.add(leaderUser);
        return leaderUsers;
    }

    public static ArrayList<UserHistory> getUserHistory(int userId) {

        ArrayList<UserHistory> histories = new ArrayList<UserHistory>();
        UserHistory history = new UserHistory(1, new Date(), Time.valueOf("100"), 10);
        histories.add(history);
//        try {
//            PreparedStatement state = connect.prepareStatement("select uh.quiz_id, q.title, uh.quiz_date, uh.quit_time, uh.quiz_score " +
//                    "from user_history uh INNER JOIN quizes q on uh.quiz_id = q.id where uh.user_id = "+userId);
//            ResultSet userHistory = state.executeQuery();
//            while (userHistory.next()) {
//
//                    UserHistory his = new UserHistory(userHistory.getInt(1), userHistory.getDate(2), userHistory.getTime(3),
//                            userHistory.getInt(5));
//
//                histories.add(history);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
        return histories;
    }


    public static Quiz getQuiz(int quizId) {
        Quiz quiz = new Quiz(quizId, 1, "Rakai Chaia Jo", "img/quizzes/football.jpg", "Sport");
//        try {
//        PreparedStatement state = connect.prepareStatement("select q.quiz_id, q.creator_id, q.DESCRIPTION, q.imageurl, q.type " +
//                "from quizes q where q.quiz_id = "+quizId);
//        ResultSet result = state.executeQuery();
//        Quiz quiz = new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4), result.getString(5));
//    } catch (SQLException e) {
//        e.printStackTrace();
//    }
        return quiz;
//
    }

    public static User getUser(int userId) {
        User user = new User("jotia", "caava", "jtcava", "jorji", "jarji", "jurji");
        //        try {
//        PreparedStatement state = connect.prepareStatement("select u.quiz_id, u.creator_id, u.DESCRIPTION, u.imageurl, u.type " +
//                "from users u where u.user_id = "+userId);
//        ResultSet result = state.executeQuery();
//        User user = new User(result.getString(1), result.getString(2), result.getString(3),
//                result.getString(4), result.getString(5), result.getString(6));
        //    } catch (SQLException e) {
//        e.printStackTrace();
//    }
        return user;
    }
}
