package leetcode;

import java.util.Collections;
import java.util.List;

public class Solution2895 {
    public int minProcessingTime(List<Integer> processorTime, List<Integer> tasks) {
        Collections.sort(processorTime);
        Collections.sort(tasks);
        int max = Integer.MIN_VALUE;
        for (int i = 0; i < processorTime.size(); i++) {
            max = Math.max(processorTime.get(i) + tasks.get(4 * (processorTime.size() - i) - 1), max);
        }
        return max;
    }
}
