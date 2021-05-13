package leetcode;

public class Solution11 {
    public int name(int[] array) {
        int l = 0;
        int r = array.length - 1;
        int max = 0;
        while (l < r) {
            int count = (r - l) * Integer.min(array[l], array[r]);
            max = Integer.max(max, count);
            if (array[l] < array[r]) {
                l++;
            } else {
                r--;
            }
        }
        return max;
    }
}
