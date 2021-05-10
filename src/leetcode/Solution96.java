package leetcode;

public class Solution96 {
    public int mySqrt(int x) {
        int left = 0;
        int right = x < 46340 ? x : 46340;
        while (left <= right) {
            int mid = (right - left) / 2 + left;
            int pow = mid * mid;
            if (pow == x) {
                return mid;
            } else if (pow > x) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return left - 1;
    }
}
