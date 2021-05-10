package leetcode;

public class Solution14 {
    public String longestCommonPrefix(String[] strs) {
        if (strs.length == 0) {
            return "";
        }
        for (int idx = 0; idx < strs[0].length(); idx++) {
            char c = strs[0].charAt(idx);
            for (int strsIdx = 1; strsIdx < strs.length; strsIdx++) {
                if (strs[strsIdx].length() - 1 < idx || strs[strsIdx].charAt(idx) != c) {
                    return strs[0].substring(0, idx);
                }
            }
        }
        return strs[0];
    }
}
