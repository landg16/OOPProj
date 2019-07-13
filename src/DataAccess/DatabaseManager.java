package DataAccess;

import Objects.*;
import sun.nio.cs.US_ASCII;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.sql.*;
import java.lang.String;
import java.util.HashMap;
import java.util.Map;

public class DatabaseManager {

    private static Connection connect;
    private static hashPassword hash;

    public DatabaseManager() {
        hash = new hashPassword();
        try {
            String timeZoneError = "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
            Class.forName("com.mysql.cj.jdbc.Driver");
            connect = DriverManager.getConnection("jdbc:mysql://"+DBInfo.MYSQL_DATABASE_SERVER+":3306/"+DBInfo.MYSQL_DATABASE_NAME+timeZoneError, DBInfo.MYSQL_USERNAME,DBInfo.MYSQL_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void insertUser(User newUser) {
        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO users (firstname, lastname, username, email, password, isadmin, imageurl) VALUES (?,?,?,?,?,?,?)");
            state.setString(1, newUser.getFirstname());
            state.setString(2, newUser.getLastname());
            state.setString(3, newUser.getUsername());
            state.setString(4, newUser.getEmail());
            state.setString(5, newUser.getPassword());
            state.setBoolean(6, newUser.getIsAdmin());
            state.setString(7, newUser.getImageurl());
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean emailExists(String email) {
        try {
            PreparedStatement state = connect.prepareStatement("SELECT email FROM users WHERE email = ?");
            state.setString(1, email);
            ResultSet em = state.executeQuery();
            return em.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void changeEmail(int userId, String newEmail) {
        try {
            PreparedStatement state = connect.prepareStatement("UPDATE users SET email = ? WHERE id = ?");
            state.setString(1, newEmail);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean usernameExists(String username) {
        try {
            PreparedStatement state = connect.prepareStatement("SELECT id FROM users WHERE username = ?");
            state.setString(1, username);
            ResultSet user = state.executeQuery();
            return user.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int checkLogin(String username, String password) {
        if(username.length() == 0 || password.length() == 0) return -1;
        String hashedPass = hash.hashPassword(password);
        try {
            PreparedStatement state = connect.prepareStatement("SELECT id FROM users WHERE username = ? AND password = ?");
            state.setString(1, username);
            state.setString(2, hashedPass);
            ResultSet user = state.executeQuery();
            if(user.next()){
                return user.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static void changeUsername(int userId, String username) {
        try {
            PreparedStatement state = connect.prepareStatement("UPDATE users SET username = ? WHERE id = ?");
            state.setString(1, username);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void changePassword(int userId, String newPassword) {
        try {
            String pass = hash.hashPassword(newPassword);
            PreparedStatement state = connect.prepareStatement("UPDATE users SET password = ? WHERE id = ?");
            state.setString(1, pass);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static int getScore(int userId) {
        int score = 0;
        try {
            PreparedStatement state = connect.prepareStatement("SELECT sum(uh.quiz_score) FROM user_history uh groub by uh.user_id having userid = ?");
            state.setInt(1, userId);
            score = state.executeQuery().getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return score;
    }

    public static int insertQuiz(int creator_id, String title, String descripption, int category_id, boolean random, boolean onePage, boolean immCorr, boolean pracMode, String image, int count) {
        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO quizes (creator_id, title, description, image, category_id, random, one_page," +
                    "immediate_correction, practice_mode, count) VALUES (?,?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            state.setInt(1, creator_id);
            state.setString(2, title);
            state.setString(3, descripption);
            state.setString(4, image);
            state.setInt(5, category_id);
            state.setBoolean(6, random);
            state.setBoolean(7, onePage);
            state.setBoolean(8, immCorr);
            state.setBoolean(9, pracMode);
            state.setInt(10, count);
            state.executeUpdate();

            ResultSet rs = state.getGeneratedKeys();
            if (rs.next()){
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static boolean deleteQuiz(int quiz_id){
        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM quizes WHERE id = ?");
            state.setInt(1, quiz_id);
            ResultSet result = state.executeQuery();
            return result.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int InsertQuestion(int quizId, String type, String question, String secondPart) {
        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO questions (quiz_id, question_type, question, secondpart) VALUES (?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);
            state.setInt(1, quizId);
            state.setString(2, type);
            state.setString(3, question);
            state.setString(4, secondPart);
            state.executeUpdate();

            ResultSet rs = state.getGeneratedKeys();
            if (rs.next()){
                return rs.getInt(1);
            }
            state.setString(4, secondPart);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static void insertAnswer(int questionId, String answer, boolean correctness) {
        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO answers (question_id, answer, iscorrect) VALUES (?,?,?)");
            state.setInt(1, questionId);
            state.setString(2, answer);
            state.setBoolean(3, correctness);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void insertFriend(int userId1, int userId2) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO friends (account_id, friend_id) VALUES (?,?)");

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

    public static void insertHistory(int userId, int quizId, double quizScore, Date dateTime, Time time) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO user_history (user_id, quiz_id, quiz_score, quiz_date, quiz_time) VALUES (?,?,?,?,?)");
            state.setInt(1, userId);
            state.setInt(2, quizId);
            state.setDouble(3, quizScore);
            state.setDate(4, (java.sql.Date) dateTime);
            state.setTime(5, time);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Map<Integer, String> getCategories() {
        Map<Integer, String> categories = null;
        try {
            PreparedStatement state = connect.prepareStatement("select * from category");
            ResultSet cats = state.executeQuery();
            categories = new HashMap<>();
            while (cats.next()) {
                int cat_id = cats.getInt(1);
                String cat_name = cats.getString(2);
                categories.put(cat_id, cat_name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

        public static void InsertAnnouncement(int announcerId, String title, String text, Date date) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO announcements (announcer_id, title, text, announce_date) VALUES (?,?,?,?)");
            state.setInt(1, announcerId);
            state.setString(2, title);
            state.setString(3, text);
            state.setDate(4, (java.sql.Date) date);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<Announcement> getAnnouncements(int id) {

        ArrayList<Announcement> announcements= new ArrayList<Announcement>();
        Announcement announcement = null;
        try {
            PreparedStatement state = connect.prepareStatement("select id, announcer_id, title, text, announce_date from announcements where id = ?");
            state.setInt(1, id);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                announcement = new Announcement(result.getInt(1), result.getInt(2),
                        result.getString(3), result.getString(4), result.getDate(5));
                announcements.add(announcement);
            }
            return announcements;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void setAsAdmin(int userId) {
        try {
            PreparedStatement state = connect.prepareStatement("UPDATE users set isadmin = ? where userid = ?");
            state.setBoolean(1,true);
            state.setInt(2,userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean isAdmin(int userId) {
        try {
            PreparedStatement state = connect.prepareStatement("select u.id from users u where u.id = ? and u.isadmin = true");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            return result.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static ArrayList<User> getAdmins() {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT * from users u where u.isadmin = 1");
            ResultSet result = state.executeQuery();
            return castResults(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<User> searchUser(String searchValue) {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT u.id, u.firstname, u.lastname, u.username, u.email, u.password, u.isAdmin," +
                    " u.imageurl from users u where u.firstname like ? or u.lastname like ? or u.email like ? or u.username like ?");
            state.setString(1, "'%"+searchValue+"%'");
            state.setString(2, "'%"+searchValue+"%'");
            state.setString(3, "'%"+searchValue+"%'");
            state.setString(4, "'%"+searchValue+"%'");
            ResultSet result = state.executeQuery();
            return castResults(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<User> getFriends(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT u.id, u.firstname, u.lastname, u.username, u.email, u.imageurl from users u " +
                    "INNER JOIN user_history uh on u.id = uh.friend_id where uh.account_id = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            return castResults(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void insertCategory(String name) {

        try {
        PreparedStatement state = connect.prepareStatement("INSERT INTO category (name) VALUES (?)");
            state.setString(1, name);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Quiz getQuiz(int quizId) {
        Quiz quiz = null;
        try {
            PreparedStatement state = connect.prepareStatement("select q.id, q.creator_id, q.title, q.description, q.image, c.name, q.random, " +
                    "q.one_page, q.immediate_correction, q.practice_mode from quizes q inner join category c on q.category_id = c.id where q.id = ?");
            state.setInt(1, quizId);
            ResultSet result = state.executeQuery();
            quiz = new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                    result.getString(5), result.getString(6), result.getBoolean(7),
                    result.getBoolean(8), result.getBoolean(9), result.getBoolean(10));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quiz;
    }

    public static ArrayList<Quiz> getAllQuizes () {
        ArrayList<Quiz> quizes = new ArrayList<>();
        Quiz quiz = null;
        try {
            PreparedStatement state = connect.prepareStatement("select q.id, q.creator_id, q.title, q.description, q.image, c.name, q.random, " +
                    "q.one_page, q.immediate_correction, q.practice_mode from quizes q inner join category c on q.category_id = c.id");
            ResultSet result = state.executeQuery();
            while (result.next()) {
                quiz = new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                        result.getString(5), result.getString(6), result.getBoolean(7),
                        result.getBoolean(8), result.getBoolean(9), result.getBoolean(10));
                quizes.add(quiz);
            }
            return quizes;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static ArrayList<User> castResults(ResultSet results) {

        ArrayList<User> users = new ArrayList<User>();
        User leaders = null;
        try {
            while (results.next()) {
                leaders = new User(results.getInt(1), results.getString(2), results.getString(3),
                        results.getString(4), results.getString(5), results.getString(6),
                        results.getBoolean(7), results.getString(8));
                users.add(leaders);
            }
            return users;
            } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<User> getLeaderUsers() {
//        try {
//            PreparedStatement state = connect.prepareStatement("select u.id, u.firsname, u.lastname, u.username, u.email, u.password, u.isadmin, u.imageurl,
//                  sum(uh.quiz_score) scores from user_history uh inner join users u on uh.user_id = u.id group by uh.user_id order by scores desc limit 100");
//            ResultSet list = state.executeQuery();
//            return castResults(list);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
        ArrayList<User> leaderUsers = new ArrayList<>();
        User leaderUser = new User(1, "revaz", "meshvelashvili", "10", "141", "1324", false, "145");
        leaderUsers.add(leaderUser);
        return leaderUsers;
    }

    public static ArrayList<User> getDailyLeaderUsers() throws SQLException {
//        try {
//            PreparedStatement state = connect.prepareStatement("select u.id, u.firsname, u.lastname, sum(uh.quiz_score) scores from users u" +
//                    " inner join user_history uh on u.id = uh.user_id group by uh.user_id having uh.quiz_date > (NOW() - INTERVAL 1 DAY) order by scores desc");
//            ResultSet list = state.executeQuery();
//            return castResults(list);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
        ArrayList<User> leaderUsers = new ArrayList<>();
        User leaderUser = new User(1, "revaz", "meshvelashvili", "10", "141", "1324", false, "145");
        leaderUsers.add(leaderUser);
        return leaderUsers;
    }

    public static ArrayList<UserHistory> getUserHistory(int userId) {

        ArrayList<UserHistory> histories = new ArrayList<UserHistory>();
        UserHistory history = null;
        try {
            PreparedStatement state = connect.prepareStatement("select uh.quiz_id, q.title, uh.quiz_date, uh.quit_time, uh.quiz_score " +
                    "from user_history uh INNER JOIN quizes q on uh.quiz_id = q.id where uh.user_id = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                    history = new UserHistory(result.getInt(1), result.getString(2), result.getDate(3),
                            result.getInt(4), result.getInt(5));
                histories.add(history);
            }
            return histories;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return histories;
    }

    public static User getUser(int userId) {
        User user = null;
        try {
            PreparedStatement state = connect.prepareStatement("select * from users where id = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            if (result.next()) {
                user = new User(result.getInt("id"), result.getString("firstname"), result.getString("lastname"),
                        result.getString("username"), result.getString("email"), result.getString("password"),
                        result.getBoolean("isadmin"), result.getString("imageurl"));
            }
            return user;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
        //returns all time best 5 users with best score in this quiz
    public static ArrayList<User> getAllTimeBest(int quizId){

        try {
            PreparedStatement state = connect.prepareStatement("SELECT u.id, u.firstname, u.lastname, u.username, u.email, u.password, u.isadmin, u.imagerurl, " +
                    "sum(quiz_score) scores from user_history uh INNER JOIN users u on  uh.user_id = u.id group by uh.user_id having uh.quiz_id = ? order by scores desc limit 5");
            state.setInt(1, quizId);
            ResultSet result = state.executeQuery();
            return castResults(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
