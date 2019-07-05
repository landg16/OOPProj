package DataAccess;

import Objects.Question;
import Objects.Quiz;
import Objects.User;

import java.security.PublicKey;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.sql.*;


public class DatabaseManager {

    public static void main(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/sonoo","root","zazuna12");
            Statement statement = connect.createStatement();

        }catch (Exception e){

        }
    }

    public void InsertUser(User newUser){
        //todo
    }

    public boolean emailExists(String email){
        //todo
        return false;
    }

    public void changeEmail(int userId, String newEmail){
        //todo
    }

    public boolean nickNameExists(String nickName){
        //todo
        return false;
    }

    public void changeUserNickName(int userId, String newNickName){
        //todo
    }

    public void changePassword(int userId, String newPassword){
        //todo
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
        //todo
    }

    public void insertQuiz(int userId, Quiz quiz){
        //todo
    }
}


