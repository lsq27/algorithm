package leetcode;

public class Solution278 {
    public int firstBadVersion(int n) {
        int l = 1, r = n;
        while (l <= r) {
            int mid = (r - l) / 2 + l;
            if (isBadVersion(mid)) {
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        }
        return r + 1;
    }
}
