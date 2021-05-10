package leetcode;

import java.util.HashSet;

public class Solution3 {
    public void name(String str) {
        int result = 0;

        HashSet<Character> set = new HashSet<>();
        int l = 0;
        int r = 0;

        while (l >= 0 && set.add(str.charAt(l))) {
            l--;
        }
        while (r < str.length() && set.add(str.charAt(r))) {
            r--;
        }
        if (result < r - l - 1) {
            result = r - l - 1;
        }
        l = r;

        return result;
    }
}
