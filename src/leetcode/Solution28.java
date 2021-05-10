package leetcode;

public class Solution28 {
    public int strStr(String haystack, String needle) {
        if (needle.isEmpty()) {
            return 0;
        }
        int[] kmp = new int[needle.length()];
        for (int subLenth = 1; subLenth <= needle.length(); subLenth++) {
            String sub = needle.substring(0, subLenth);
            for (int i = 1; i < subLenth; i++) {
                String l = sub.substring(0, subLenth - i);
                String r = sub.substring(i);
                if (l.equals(r)) {
                    kmp[subLenth - 1] = l.length();
                }
            }
        }
        int begin = 0;
        for (int i = 0; i < needle.length() && begin + i < haystack.length(); i++) {
            if (haystack.charAt(begin + i) != needle.charAt(i)) {
                begin += kmp[i] + 1;
                i = kmp[i] - 1;
            } else if (i == needle.length() - 1) {
                return begin;
            }
        }
        return -1;
    }
}
