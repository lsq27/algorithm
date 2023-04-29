package leetcode;

public class Solution279 {
    public int numSquares(int n) {
        int i = 0;
        while (n > 0) {
            n = n - (int) Math.pow((int) Math.sqrt(n), 2);
            i++;
        }
        return i;
    }
}
