package Helper;

public class Calculate {
    private static final int medDuration = 500;
    private static final int multiplier = 1000;

    public static int getScore(int maxPoint, int userPoint, Long duration){
        double pointVal = Math.pow((double)userPoint / (double)maxPoint, 3);
        pointVal *= multiplier;

        double timeVal = (double) duration / (double)medDuration;

        int returnVal = (int) (pointVal * timeVal);
        while(returnVal % 10 != 0)returnVal++;

        return returnVal;
    }
}
