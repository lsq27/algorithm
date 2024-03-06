package leetcode;

public class Solution2844 {
    // 让末尾最快为00、25、50、75
    public int minimumOperations(String num) {
        int min = num.length();
        // 00、50
        for (int i = num.length() - 1; i >= 0; i--) {
            if (num.charAt(i) == '0') {
                for (int j = i - 1; j >= 0; j--) {
                    if (num.charAt(j) == '0' || num.charAt(j) == '5') {
                        min = (i - j - 1) + (num.length() - 1 - i);
                        break;
                    }
                }
                if (min != num.length()) {
                    break;
                }
            }
        }

        // 25、75
        for (int i = num.length() - 1; i >= 0; i--) {
            if (num.charAt(i) == '5') {
                for (int j = i - 1; j >= 0; j--) {
                    if (num.charAt(j) == '2' || num.charAt(j) == '7') {
                        return Math.min(min, (i - j - 1) + (num.length() - 1 - i));
                    }
                }
            }
        }

        if (min == num.length()) {
            return num.replace("0", "").length();
        }
        return min;
    }
}