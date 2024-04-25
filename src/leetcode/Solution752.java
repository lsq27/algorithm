package leetcode;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.Set;

public class Solution752 {
    // 广度优先搜索
    public int openLock(String[] deadends, String target) {
        Set<String> dead = new HashSet<>(Arrays.asList(deadends));
        if (dead.contains("0000")) {
            return -1;
        }
        Set<String> seen = new HashSet<>();
        seen.add("0000");
        Queue<String> queue = new LinkedList<>();
        queue.offer("0000");

        int cnt = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String status = queue.poll();
                if (status.equals(target)) {
                    return cnt;
                }
                for (String nextStatus : get(status)) {
                    if (dead.contains(nextStatus) || seen.contains(nextStatus)) {
                        continue;
                    }
                    queue.offer(nextStatus);
                    seen.add(nextStatus);
                }
            }
            cnt++;
        }
        return -1;
    }

    private List<String> get(String status) {
        List<String> list = new ArrayList<>();
        for (int i = 0; i < 4; i++) {
            char[] array = status.toCharArray();
            char ch = array[i];
            array[i] = ch == '9' ? '0' : (char) (ch + 1);
            list.add(new String(array));
            array[i] = ch == '0' ? '9' : (char) (ch - 1);
            list.add(new String(array));
        }
        return list;
    }
}
