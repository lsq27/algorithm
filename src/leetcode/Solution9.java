package leetcode;

public class Solution9 {
    public boolean isPalindrome(int x) {
        if (x < 0 || (x != 0 && x % 10 == 0)) {
            return false;
        }
        int result = 0;
        while (x > result) {
            result = 10 * result + x % 10;
            x /= 10;
        }
        return result == x || result / 10 == x;
    }
}
