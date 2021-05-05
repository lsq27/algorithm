import java.util.ArrayDeque;
import java.util.Deque;

public class Solution20 {
    public boolean isValid(String s) {
        Deque<Character> stack = new ArrayDeque<>();
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (ch == '(' || ch == '[' || ch == '{') {
                stack.push(ch);
            } else if (stack.isEmpty() || !((ch == ')' && stack.pop() == '(') || (ch == ']' && stack.pop() == '[')
                    || (ch == '}' && stack.pop() == '{'))) {
                return false;
            }
        }
        return stack.isEmpty();
    }
}