package leetcode;

import java.util.Arrays;

public class Solution204 {
    public int countPrimes(int n) {
        boolean[] isPrime = new boolean[n];
        Arrays.fill(isPrime, true);
        int cnt = 0;
        for (int i = 2; i < n; i++) {
            if (isPrime[i]) {
                cnt++;
                if ((long) i * i >= n) {
                    continue;
                }
                int j = i * i;
                while (j < n) {
                    isPrime[j] = false;
                    j += i;
                }
            }
        }
        return cnt;
    }
}