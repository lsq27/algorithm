package leetcode;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

// 统计字符出现次数 用数组效率更高，因为英文字母数量有限
public class Solution748 {
    public String shortestCompletingWord(String licensePlate, String[] words) {
        String shor = null;
        Map<Character, Integer> target = calculateMap(licensePlate);
        for (String word : words) {
            Map<Character, Integer> map = calculateMap(word);
            boolean satisf = true;
            for (Entry<Character, Integer> entry : target.entrySet()) {
                Character ch = entry.getKey();
                if (!map.containsKey(ch) || map.get(ch) < target.get(ch)) {
                    satisf = false;
                    break;
                }
            }
            if (satisf && (shor == null || shor.length() > word.length())) {
                shor = word;
            }
        }
        return shor;
    }

    private Map<Character, Integer> calculateMap(String licensePlate) {
        Map<Character, Integer> map = new HashMap<>();
        for (char ch : licensePlate.toLowerCase().toCharArray()) {
            if (ch >= 'a' && ch <= 'z') {
                map.put(ch, map.containsKey(ch) ? map.get(ch) + 1 : 1);
            }
        }
        return map;
    }

    public String shortestCompletingWord2(String licensePlate, String[] words) {
        int[] cnt = new int[26];
        for (char ch : licensePlate.toLowerCase().toCharArray()) {
            if (ch >= 'a' && ch <= 'z') {
                cnt[ch - 'a']++;
            }
        }
        String result = null;
        for (String word : words) {
            int[] temp = new int[26];
            for (char ch : word.toCharArray()) {
                temp[ch - 'a']++;
            }
            boolean ok = true;
            for (int i = 0; i < cnt.length; i++) {
                if (temp[i] < cnt[i]) {
                    ok = false;
                    break;
                }
            }
            if (ok && (result == null || result.length() > word.length())) {
                result = word;
            }
        }
        return result;
    }
}
