package Helper;

import Objects.UserHistory;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Helper {
    class SortByDate implements Comparator<UserHistory> {
        @Override
        public int compare(UserHistory userHistory1, UserHistory userHistory2) {
            return 0;
        }
    }

    class SortByScore implements Comparator<UserHistory> {
        @Override
        public int compare(UserHistory userHistory1, UserHistory userHistory2) {
            return userHistory1.getScore() - userHistory2.getScore();
        }
    }

    class SortByDuration implements Comparator<UserHistory> {
        @Override
        public int compare(UserHistory userHistory1, UserHistory userHistory2) {
            return userHistory1.getQuizTime() - userHistory2.getQuizTime();
        }
    }

    public ArrayList<UserHistory> sortByDate(ArrayList<UserHistory> userHistories){
        Collections.sort(userHistories, new SortByDate());
        return userHistories;
    }

    public ArrayList<UserHistory> sortByScore(ArrayList<UserHistory> userHistories){
        Collections.sort(userHistories, new SortByScore());
        return userHistories;
    }

    public static ArrayList<UserHistory> sortByDuration(ArrayList<UserHistory> userHistories){
        return null;
    }
}
