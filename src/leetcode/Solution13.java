package leetcode;

public class Solution13 {
    public int romanToInt(String s) {
        int result = 0;
        int pre = convert(s.charAt(0));
        for (int i = 1; i < s.length(); i++) {
            int ch = convert(s.charAt(i));
            result += pre < ch ? -pre : pre;
            pre = ch;
        }
        result += pre;
        return result;
    }

    int convert(char ch) {
        switch (ch) {
            case 'M':
                return 1000;
            case 'D':
                return 500;
            case 'C':
                return 100;
            case 'L':
                return 50;
            case 'X':
                return 10;
            case 'V':
                return 5;
            case 'I':
                return 1;
            default:
                return 0;
        }
    }
}
