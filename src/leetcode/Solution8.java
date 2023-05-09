package leetcode;

public class Solution8 {
    public int myAtoi(String s) {
        int idx = 0;
        while (idx < s.length() && s.charAt(idx) == ' ') {
            idx++;
        }
        if (idx >= s.length()) {
            return 0;
        }
        boolean negative = false;
        char c = s.charAt(idx);
        if (c == '-') {
            negative = true;
            idx++;
        } else if (c == '+') {
            idx++;
        }
        int num = 0;
        while (idx < s.length() && s.charAt(idx) >= '0' && s.charAt(idx) <= '9') {
            int tmp = (negative ? -1 : 1) * (s.charAt(idx) - '0');
            if (num!=0&&((10 * num + tmp)&Integer.MIN_VALUE) != (num&Integer.MIN_VALUE)) {
                num = negative ? Integer.MIN_VALUE : Integer.MAX_VALUE;
                break;
            }
            num = 10 * num + tmp;
            idx++;
        }
        return num;
    }
}
