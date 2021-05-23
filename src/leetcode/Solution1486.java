package leetcode;

public class Solution1486 {
    public int xorOperation(int n, int start) {
        int result = 0;
        if (start % 4 == 2 || start % 4 == 3) {
            result = start;
            start += 2;
            n--;
        }
        for (int i = n / 4 * 4; i < array.length; i++) {
            // start+2*n
        }
    }
}
