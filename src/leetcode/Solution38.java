package leetcode;

public class Solution38 {
    public String countAndSay(int n) {
        String seed = "1";
        for (int i = 1; i < n; i++) {
            char lastChar = seed.charAt(0);
            int count = 1;
            StringBuilder sb = new StringBuilder();
            for (int j = 1; j < seed.length(); j++, count++) {
                if (seed.charAt(j) != lastChar) {
                    sb.append(count).append(lastChar);
                    count = 0;
                    lastChar = seed.charAt(j);
                }
            }
            sb.append(count).append(lastChar);
            seed = sb.toString();
        }
        return seed;
    }
}
