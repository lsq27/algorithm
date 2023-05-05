package leetcode;

import java.util.TreeSet;

public class Solution264 {
    public int nthUglyNumber(int n) {
        int now = 1;
        for (int i = 0; i < n; now++) {
            if (isUgly(now)) {
                i++;
            }
        }

        int[] a = {2, 3, 4};
        TreeSet<Integer> set = new TreeSet<>();
        set.add(1);
        int[] b = {1};
        for (int i : b) {
            set.add(i*2);
        }
    }

    public boolean isUgly(int n) {
        if (n <= 0) {
            return false;
        }
        while (n % 2 == 0) {
            n = n / 2;
        }
        while (n % 3 == 0) {
            n = n / 3;
        }
        while (n % 5 == 0) {
            n = n / 5;
        }
        return n == 1;
    }
}
