public class Solution67 {
    public String addBinary(String a, String b) {
        StringBuilder sb = new StringBuilder();
        int length = Math.max(a.length(), b.length());
        int flag = 0;
        for (int i = 1; i <= length; i++) {
            int ch = (a.length() - i >= 0 ? a.charAt(a.length() - i) - '0' : 0)
                    + (b.length() - i >= 0 ? b.charAt(b.length() - i) - '0' : 0) + flag;
            sb.insert(0, ch % 2);
            flag = ch / 2;
        }
        if (flag == 1) {
            sb.insert(0, 1);
        }
        return sb.toString();
    }
}
