package DataAccess;

import Objects.*;

import java.sql.*;
import java.util.ArrayList;
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

        try {
            PreparedStatement state = connect.prepareStatement("SELECT sum(uh.quiz_score) FROM user_history uh group by uh.user_id having uh.user_id = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            if (result.next()) return result.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int insertQuiz(int creator_id, String title, String descripption, int category_id, boolean random, boolean onePage, boolean immCorr, boolean pracMode, String image, Date creationDate) {
        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO quizes (creator_id, title, description, image, category_id, random, one_page," +
                    "immediate_correction, practice_mode, creation_date) VALUES (?,?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            state.setInt(1, creator_id);
            state.setString(2, title);
            state.setString(3, descripption);
            state.setString(4, image);
            state.setInt(5, category_id);
            state.setBoolean(6, random);
            state.setBoolean(7, onePage);
            state.setBoolean(8, immCorr);
            state.setBoolean(9, pracMode);
            state.setDate(10, creationDate);
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

    private static void dropAnswers(int answerId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM answers WHERE id = ?");
            state.setInt(1, answerId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void dropQuestion(int questionId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM questions where id = ?");
            state.setInt(1, questionId);
            state.executeUpdate();
            state = connect.prepareStatement("SELECT a.id FROM answers a WHERE a.question_id = ?");
            state.setInt(1, questionId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                dropAnswers(result.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void dropQuiz(int quizId){
        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM quizes WHERE id = ?");
            state.setInt(1, quizId);
            state.executeUpdate();
            state = connect.prepareStatement("SELECT q.id FROM questions q where q.quiz_id = ?");
            state.setInt(1, quizId);
            ResultSet resultSet = state.executeQuery();
            while (resultSet.next()) {
                dropQuestion(resultSet.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean dropUser(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM users WHERE id = ?");
            state.setInt(1, userId);
            state.executeUpdate();
            state = connect.prepareStatement("SELECT q.id from quizes q where q.creator_id = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                dropQuiz(result.getInt(1));
            }
            state = connect.prepareStatement("DELETE FROM user_history where user_id = ?");
            state.setInt(1, userId);
            state.executeUpdate();
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

            state = connect.prepareStatement("DELETE FROM friendRequest where senderid = ? and receiverid = ?");
            state.setInt(1, userId1);
            state.setInt(2, userId2);
            state.executeUpdate();

            state = connect.prepareStatement("DELETE FROM friendRequest where senderid = ? and receiverid = ?");
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

        public static void InsertAnnouncement(int announcerId, String title, String text) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO announcements (announcer_id, title, text, announce_date) VALUES (?,?,?,NOW())");
            state.setInt(1, announcerId);
            state.setString(2, title);
            state.setString(3, text);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void insertFriendRequest(int sender, int receiver) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO friendRequest (senderid, receiverid) VALUES (?,?)");
            state.setInt(1, sender);
            state.setInt(2, receiver);
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
            PreparedStatement state = connect.prepareStatement("UPDATE users set isadmin = ? where id = ?");
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

    public static ArrayList<User> getFriendRequest(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT u.id, u.firstname, u.lastname, u.username, u.email, u.password, u.isadmin, u.imageurl " +
                    "from users u INNER JOIN friendRequest f on u.id  = f.senderid where f.receiverid = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            return castResults(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<User> getFriends(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT * from users u " +
                    "INNER JOIN friends f on u.id = f.friend_id where f.account_id = ?");
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
                    "q.one_page, q.immediate_correction, q.practice_mode, q.creation_date from quizes q inner join category c on q.category_id = c.id where q.id = ?");
            state.setInt(1, quizId);
            ResultSet result = state.executeQuery();
            if(result.next()) {
                quiz = new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                        result.getString(5), result.getString(6), result.getBoolean(7), result.getBoolean(8),
                        result.getBoolean(9), result.getBoolean(10), result.getDate(11));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quiz;
    }

    public static ArrayList<Question> getQuestions(int quizId, boolean random) {
        ArrayList<Question> quests = new ArrayList<>();
        try {
            PreparedStatement state;
            if(random) {
                state = connect.prepareStatement("SELECT id, question_type, question, secondpart FROM questions WHERE quiz_id = ? ORDER BY RAND()");
            } else {
                state = connect.prepareStatement("SELECT id, question_type, question, secondpart FROM questions WHERE quiz_id = ?");
            }
            state.setInt(1, quizId);
            ResultSet result = state.executeQuery();
            while(result.next()){
                Question quest = new Question(result.getInt(1), quizId, result.getString(2), result.getString(3), result.getString(4));
                quests.add(quest);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quests;
    }

    public static ArrayList<Answer> getAnswers(int questionId) {
        ArrayList<Answer> answers = new ArrayList<>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT id, question_id, answer, iscorrect FROM answers WHERE question_id = ? ORDER BY RAND()");
            state.setInt(1, questionId);
            ResultSet result = state.executeQuery();
            while(result.next()) {
                Answer ans = new Answer(result.getInt(1), questionId, result.getString(2), result.getBoolean(4));
                answers.add(ans);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return answers;
    }

    public static ArrayList<User> getAllUsers() {

        try {
            PreparedStatement state = connect.prepareStatement("select * from users");
            ResultSet result = state.executeQuery();
            return castResults(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<Quiz> getAllQuizes () {
        ArrayList<Quiz> quizes = new ArrayList<>();
        Quiz quiz = null;
        try {
            PreparedStatement state = connect.prepareStatement("select q.id, q.creator_id, q.title, q.description, q.image, c.name, q.random, " +
                    "q.one_page, q.immediate_correction, q.practice_mode, q.creation_date from quizes q inner join category c on q.category_id = c.id");
            ResultSet result = state.executeQuery();
            while (result.next()) {
                quiz = new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                        result.getString(5), result.getString(6), result.getBoolean(7), result.getBoolean(8),
                        result.getBoolean(9), result.getBoolean(10), result.getDate(11));
                quizes.add(quiz);
            }
            return quizes;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static int getId(String name) {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT c.id  from category c WHERE c.name = ?");
            state.setString(1, name);
            ResultSet result = state.executeQuery();
            if (result.next()) return result.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static void setQuizSettings(Quiz editedQuiz) {

        int catId = getId(editedQuiz.getType());
        if (catId == -1) return;
        try {
            PreparedStatement state = connect.prepareStatement("UPDATE quizes SET title = ?, description = ?, image = ?, category_id = ?," +
                    " random = ?, one_page = ?, immediate_correction = ?, practice_mode = ? where id = ?");
            state.setString(1, editedQuiz.getTitle());
            state.setString(2, editedQuiz.getDescription());
            state.setString(3, editedQuiz.getImageUrl());
            state.setInt(4, catId);
            state.setBoolean(5, editedQuiz.isRandom());
            state.setBoolean(6, editedQuiz.isOnePage());
            state.setBoolean(7, editedQuiz.isImmediateCorrection());
            state.setBoolean(8, editedQuiz.isPracticeMode());
            state.setInt(9, editedQuiz.getId());
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
//            PreparedStatement state = connect.prepareStatement("select u.id, u.firsname, u.lastname, u.username, u.email, u.password, u.isadmin, u.imageurl, " +
//                    "sum(uh.quiz_score) scores from user_history uh inner join users u on uh.user_id = u.id group by uh.user_id order by scores desc limit 100");
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
            PreparedStatement state = connect.prepareStatement("select uh.quiz_id, q.title, uh.quiz_date, uh.quiz_time, uh.quiz_score " +
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
            PreparedStatement state = connect.prepareStatement("SELECT u.id, u.firstname, u.lastname, u.username, u.email, u.password, u.isadmin, u.imageurl, " +
                    "sum(quiz_score) scores from users u INNER JOIN user_history uh on  uh.user_id = u.id where uh.quiz_id = ? group by uh.user_id order by scores desc limit 5");
            state.setInt(1, quizId);
            ResultSet result = state.executeQuery();
            return castResults(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void insertAchievement(int userId, String achievement) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO achievements(userid, name) VALUES (?,?)");
            state.setInt(1, userId);
            state.setString(2, achievement);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<String> getAchievement(int userId) {

        ArrayList<String> achievements = new ArrayList<String>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT a.name FROM achievements a where a.userid = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                achievements.add(new String(result.getString(1)));
            }
            return achievements;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    public static void insertChatMessages(int senderId, int receiverId, String txt) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO chats (sernderid, receiverid, txt) values (?,?,?)");
            state.setInt(1, senderId);
            state.setInt(2, receiverId);
            state.setString(3, txt);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static HashMap<Integer, Integer> getChallenges(int userId) {

        HashMap<Integer, Integer> challenges = new HashMap<Integer, Integer>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT ch.receiverid, ch.quizid from challenges ch where ch.senderid = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                challenges.put(result.getInt(1), result.getInt(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return challenges;
    }

    public static void insertChallenge(int senderId, int receiverId, int quizId) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO challenges (senderid, receiverid, quizid) VALUES (?,?,?)");
            state.setInt(1, senderId);
            state.setInt(2, receiverId);
            state.setInt(3, quizId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void dropChallenge() {

        try {
            PreparedStatement state = connect.prepareStatement("");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<Quiz> popularQuizzes() {

        try {
            PreparedStatement state = connect.prepareStatement("select q.id, q.creator_id, q.title, q.description, q.image, c.name, q.random, q.one_page, " +
                    "q.immediate_correction, q.practice_mode, count(uh.user_id) counts from user_history uh INNER join quizes q on uh.quiz_id = q.id " +
                    "INNER join category c on q.category_id = c.id group by uh.quiz_id order by counts limit 5");
            ArrayList<Quiz> populars = new ArrayList<Quiz>();
            ResultSet result = state.executeQuery();
            while (result.next()) {
                populars.add(new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                        result.getString(5), result.getString(6), result.getBoolean(7), result.getBoolean(8),
                        result.getBoolean(9), result.getBoolean(10), result.getDate(11)));
            }
            return populars;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<Quiz> recentlyCreatedQuizzes() {

        ArrayList<Quiz> recents = new ArrayList<Quiz>();
        try {
            PreparedStatement state = connect.prepareStatement("select * from quizes q where q.creation_date >= (NOW() - INTERVAL 1 HOUR)");
            ResultSet result = state.executeQuery();
            while (result.next()) {
                recents.add(new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                        result.getString(5), result.getString(6), result.getBoolean(7), result.getBoolean(8),
                        result.getBoolean(9), result.getBoolean(10), result.getDate(11)));
            }
            return recents;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static HashMap<Quiz, Integer> usersRecentTakenQuizzes(int userId) {

        HashMap<Quiz, Integer> recents = new HashMap<Quiz, Integer>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT *, uh.quiz_score from quizes q INNER JOIN user_history uh on q.id = uh.quiz_id " +
                    "where (uh.quiz_date >= (NOW() - INTERVAL 1 HOUR)) and (uh.user_id = ?)");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                recents.put(new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                        result.getString(5), result.getString(6), result.getBoolean(7), result.getBoolean(8),
                        result.getBoolean(9), result.getBoolean(10), result.getDate(11)), result.getInt(12));
            }
            return recents;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<Quiz> usersRecentlyAddedQuizzes(int userId) {

        ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT * from quizes q where (q.creation_date >= (NOW() - INTERVAL 1 HOUR)) and (q.creator_id = ?)");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                quizzes.add(new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                        result.getString(5), result.getString(6), result.getBoolean(7), result.getBoolean(8),
                        result.getBoolean(9), result.getBoolean(10), result.getDate(12)));
            }
            return quizzes;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
