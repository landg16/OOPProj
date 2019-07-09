package DataAccess;

import Objects.Question;
import Objects.Quiz;
import Objects.User;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;


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



    public void InsertUser(User newUser){
        try {
            PreparedStatement state = connect.prepareStatement("insert into Emp values(?,?,?,?,?,?)");
            state.setInt(1, 2);
            state.setString(2, newUser.getFirstName());
            state.setString(3, newUser.getLastName());
            state.setString(4, newUser.getNickName());
            state.setString(5, newUser.getEmail());
            state.setString(6,newUser.getPassword());
            state.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean emailExists(String email){
        try {
            PreparedStatement state = connect.prepareStatement("select * from users order by email");
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
            PreparedStatement state = connect.prepareStatement("UPDATE users set email="+newEmail+" where id="+userId);
            int res = state.executeUpdate();
            ResultSet emails = state.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean nickNameExists(String nickName){
        try {
            PreparedStatement state = connect.prepareStatement("select * from users order by nickName");
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
            PreparedStatement state = connect.prepareStatement("UPDATE users set email="+newNickName+" where id="+userId);
            int res = state.executeUpdate();
            ResultSet emails = state.executeQuery();
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
            PreparedStatement state = connect.prepareStatement("UPDATE users set email="+pass+" where id="+userId);
            int res = state.executeUpdate();
            ResultSet emails = state.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getScore(int userId){
        //todo
        return 0;
    }

    public void updateScore(int userId, int score){
        //todo
    }

    public void InsertQuestion(Question newQuestion){
        //todo
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

    public void insertQuiz(int userId, Quiz quiz){
        //todo
    }
}


