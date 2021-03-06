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

    public static int insertQuiz(int creator_id, String title, String descripption, int category_id, boolean random, boolean onePage, boolean immCorr, boolean pracMode, String image) {
        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO quizes (creator_id, title, description, image, category_id, random, one_page," +
                    "immediate_correction, practice_mode, creation_date) VALUES (?,?,?,?,?,?,?,?,?,NOW())", Statement.RETURN_GENERATED_KEYS);
            state.setInt(1, creator_id);
            state.setString(2, title);
            state.setString(3, descripption);
            state.setString(4, image);
            state.setInt(5, category_id);
            state.setBoolean(6, random);
            state.setBoolean(7, onePage);
            state.setBoolean(8, immCorr);
            state.setBoolean(9, pracMode);
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
            PreparedStatement state = connect.prepareStatement("SELECT a.id FROM answers a WHERE a.question_id = ?");
            state.setInt(1, questionId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                dropAnswers(result.getInt(1));
            }
            state = connect.prepareStatement("DELETE FROM questions where id = ?");
            state.setInt(1, questionId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void dropQuiz(int quizId){
        try {
            PreparedStatement state = connect.prepareStatement("SELECT q.id FROM questions q where q.quiz_id = ?");
            state.setInt(1, quizId);
            ResultSet resultSet = state.executeQuery();
            while (resultSet.next()) {
                dropQuestion(resultSet.getInt(1));
            }
            state = connect.prepareStatement("DELETE FROM quizes WHERE id = ?");
            state.setInt(1, quizId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void dropFriendRequestVol2(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM friendrequest where senderid = ? or receiverid = ?");
            state.setInt(1, userId);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void dropFriends(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM friends where account_id = ? or friend_id = ?");
            state.setInt(1, userId);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void dropChatTexts(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM chats where senderId = ? or receiverId = ?");
            state.setInt(1, userId);
            state.setInt(2, userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void dropUsersAcnnouncements(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM announcements where announcer_id = ?");
            state.setInt(1, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void dropAchievements(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM achievements where userid = ?");
            state.setInt(1, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void dropChallengeVol2(int userId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE  FROM challenges where senderid = ? or receiverid = ?");
            state.setInt(1, userId);
            state.setInt(2, userId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean dropUser(int userId) {

        try {
            dropFriends(userId);
            dropChallengeVol2(userId);
            dropChatTexts(userId);
            dropFriendRequestVol2(userId);
            dropAchievements(userId);
            dropUsersAcnnouncements(userId);
            PreparedStatement state = connect.prepareStatement("DELETE FROM user_history where user_id = ?");
            state.setInt(1, userId);
            state.executeUpdate();
            state = connect.prepareStatement("SELECT q.id from quizes q where q.creator_id = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                dropQuiz(result.getInt(1));
            }
            state = connect.prepareStatement("DELETE FROM users WHERE id = ?");
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

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Timestamp getSQLTime() {
        Timestamp ts = null;
        try {
            PreparedStatement state = connect.prepareStatement("SELECT NOW()");
            ResultSet result = state.executeQuery();
            if (result.next()) {
                ts = result.getTimestamp(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ts;
    }
        public static int insertHistory(int userId, int quizId) {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT uh.id, uh.quiz_end from user_history uh where uh.user_id = ? and uh.quiz_id = ?");
            state.setInt(1, userId);
            state.setInt(2, quizId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                if (result.getTimestamp(2) == null) {
                    return result.getInt(1);
                }
            }
            state = connect.prepareStatement("INSERT INTO user_history (user_id, quiz_id, quiz_start) VALUES (?,?,NOW())", Statement.RETURN_GENERATED_KEYS);
            state.setInt(1, userId);
            state.setInt(2, quizId);
            state.executeUpdate();
            result = state.getGeneratedKeys();
            if (result.next()){
                return result.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  -1;
    }

    public static void updateHistory(int id, int quiz_id, int score) {

        try {
            PreparedStatement state = connect.prepareStatement("UPDATE user_history SET quiz_score = ?, quiz_end = NOW() where id = ?", Statement.RETURN_GENERATED_KEYS);
            state.setInt(1, score);
            state.setInt(2, id);
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

    public static void dropFriendRequest(int senderId, int receiverId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM friendrequest where senderid = ? and receiverid = ?");
            state.setInt(1, senderId);
            state.setInt(2, receiverId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<Announcement> getAnnouncements() {

        ArrayList<Announcement> announcements= new ArrayList<Announcement>();
        Announcement announcement = null;
        try {
            PreparedStatement state = connect.prepareStatement("select * from announcements");
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

    public static boolean friendRequestExists(int userId1, int userId2) {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT * from friendrequest f where" +
                    " (f.senderid = ? and f.receiverid = ?) or (f.senderid = ? and f.receiverid = ?)");
            state.setInt(1, userId1);
            state.setInt(2, userId2);
            state.setInt(3, userId2);
            state.setInt(4, userId1);
            ResultSet result = state.executeQuery();
            return result.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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
                Answer ans = new Answer(result.getInt(1), questionId, result.getString(3), result.getBoolean(4));
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
        try {
            PreparedStatement state = connect.prepareStatement("SELECT *, sum(uh.quiz_score) scores from users u " +
                    "INNER JOIN user_history uh on u.id = uh.user_id group by uh.user_id order by scores desc limit 100");
            ResultSet list = state.executeQuery();
            return castResults(list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
/*        ArrayList<User> leaderUsers = new ArrayList<>();
        User leaderUser = new User(1, "revaz", "meshvelashvili", "10", "141", "1324", false, "145");
        leaderUsers.add(leaderUser);
        return leaderUsers;*/
    }

    public static ArrayList<User> getDailyLeaderUsers() throws SQLException {
        try {
            PreparedStatement state = connect.prepareStatement("SELECT *, sum(uh.quiz_score) scores from users u " +
                    "INNER JOIN user_history uh on u.id = uh.user_id where uh.quiz_end >= (NOW() - INTERVAL 1 week) group by uh.user_id order by scores desc");
            ResultSet list = state.executeQuery();
            return castResults(list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
/*        ArrayList<User> leaderUsers = new ArrayList<>();
        User leaderUser = new User(1, "revaz", "meshvelashvili", "10", "141", "1324", false, "145");
        leaderUsers.add(leaderUser);
        return leaderUsers;*/
    }

    public static ArrayList<UserHistory> getUserHistory(int userId) {

        ArrayList<UserHistory> histories = new ArrayList<UserHistory>();
        UserHistory history = null;
        try {
            PreparedStatement state = connect.prepareStatement("select * from user_history uh where uh.user_id = ? order by uh.quiz_score");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                int histId = result.getInt(1);
                int userid = result.getInt(2);
                int quizId = result.getInt(3);
                double score = result.getDouble(4);
                Timestamp start = result.getTimestamp(5);
                Timestamp end = result.getTimestamp(6);
                if (end == null) {
                    history = new UserHistory(histId, userid, quizId, score, start, end, false);
                } else history = new UserHistory(histId, userid, quizId, score, start, end, true);
                histories.add(history);
            }
            return histories;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    public static int numberOfUsers() {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT count(u.id) from users u");
            ResultSet result = state.executeQuery();
            if (result.next()) return result.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int numberOfQuizCreators() {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT count(distinct q.creator_id) from quizes q");
            ResultSet result = state.executeQuery();
            if (result.next()) return result.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int numberOfQuizzes() {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT count(q.id) from quizes q");
            ResultSet result = state.executeQuery();
            if (result.next()) return result.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static long averageAllQuizDuration() {

        try {
            PreparedStatement state = connect.prepareStatement("SELECT AVG(uh.quiz_end - uh.quiz_start) as average from user_history uh");
            ResultSet result = state.executeQuery();
            if (result.next()) {
                return (long) result.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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

    public static HashMap<Integer, ArrayList<String> > getRecentAchievements(int userId) {

        ArrayList<String> achievements = new ArrayList<String>();
        HashMap<Integer, ArrayList<String> > recents = new HashMap<Integer, ArrayList<String>>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT a.name from achievements a where a.userid = ?");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                achievements.add(result.getString(1));
            }
            if (!achievements.isEmpty()) recents.put(userId, achievements);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recents;
    }

    public static void insertChatMessages(int senderId, int receiverId, String txt) {

        try {
            PreparedStatement state = connect.prepareStatement("INSERT INTO chats (senderid, receiverid, txt) values (?,?,?)");
            state.setInt(1, senderId);
            state.setInt(2, receiverId);
            state.setString(3, txt);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<String> getChatMessages(int senderId, int receiverId) {

        ArrayList<String> texts = new ArrayList<String>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT c.txt from chats c where " +
                    "(c.senderId = ? and c.receiverId = ?) or (c.senderId = ? and c.receiverId = ?)");
            state.setInt(1, senderId);
            state.setInt(2, receiverId);
            state.setInt(3, receiverId);
            state.setInt(4, senderId);
            ResultSet result = state.executeQuery();
            while (result.next()) {
                texts.add(new String(result.getString(1)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static HashMap<Integer, Integer> getChallenges(int userId) {

        HashMap<Integer, Integer> challenges = new HashMap<Integer, Integer>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT ch.senderid, ch.quizid from challenges ch where ch.receiverid= ?");
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

    public static void dropChallenge(int senderId, int receiverId, int quizId) {

        try {
            PreparedStatement state = connect.prepareStatement("DELETE FROM challenges where senderid = ? and  receiverid = ? and quizid = ?");
            state.setInt(1, senderId);
            state.setInt(2, receiverId);
            state.setInt(3, quizId);
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static ArrayList<Quiz> castQuizResult(ResultSet result) {

        ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
        try {
            while (result.next()) {
                quizzes.add(new Quiz(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4),
                        result.getString(5), result.getString(6), result.getBoolean(7), result.getBoolean(8),
                        result.getBoolean(9), result.getBoolean(10), result.getDate(11)));
            }
        } catch (SQLException e) {
                e.printStackTrace();
        }
        return quizzes;
    }

    public static ArrayList<Quiz> getPopularQuizzes() {

        try {
            PreparedStatement state = connect.prepareStatement("select q.id, q.creator_id, q.title, q.description, q.image, c.name," +
                    "q.random, q.one_page, q.immediate_correction, q.practice_mode, q.creation_date, count(uh.user_id) counts from quizes q" +
                    " INNER join user_history uh on q.id = uh.quiz_id INNER join category c " +
                    "on q.category_id = c.id group by uh.quiz_id order by counts limit 5");
            ResultSet result = state.executeQuery();
            return castQuizResult(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<Quiz> getRecentlyCreatedQuizzes() {

        try {
            PreparedStatement state = connect.prepareStatement("select q.id, q.creator_id, q.title, q.description, q.image, c.name, " +
                    "q.random, q.one_page, q.immediate_correction, q.practice_mode, q.creation_date from quizes q INNER JOIN category c" +
                    " on q.category_id = c.id where q.creation_date >= (NOW() - INTERVAL 1 WEEK )");
            ResultSet result = state.executeQuery();
            return castQuizResult(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<Quiz> getUsersRecentTakenQuizzes(int userId) {

        ArrayList<Quiz> recents = new ArrayList<>();
        try {
            PreparedStatement state = connect.prepareStatement("SELECT q.id, q.creator_id, q.title, q.description, q.image, c.name, " +
                    "q.random, q.one_page, q.immediate_correction, q.practice_mode, q.creation_date from quizes q INNER JOIN category c" +
                    " on q.category_id = c.id INNER JOIN user_history uh on q.id = uh.quiz_id " +
                    "where (uh.quiz_end >= (NOW() - INTERVAL 1 WEEK )) and (uh.user_id = ?)");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            return castQuizResult(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static ArrayList<Quiz> usersRecentlyAddedQuizzes(int userId) {
        try {
            PreparedStatement state = connect.prepareStatement("SELECT q.id, q.creator_id, q.title, q.description, q.image, c.name, " +
                    "q.random, q.one_page, q.immediate_correction, q.practice_mode, q.creation_date from quizes q INNER JOIN category c" +
                    " on q.category_id = c.id where (q.creation_date >= (NOW() - INTERVAL 1 WEEK )) and (q.creator_id = ?)");
            state.setInt(1, userId);
            ResultSet result = state.executeQuery();
            return castQuizResult(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
