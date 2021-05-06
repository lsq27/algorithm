import java.util.ArrayList;
import java.util.List;

public class Solution57 {
    public int[][] insert(int[][] intervals, int[] newInterval) {
        List<int[]> list = new ArrayList<>();
        int begin = newInterval[0];
        int end = newInterval[1];
        for (int i = 0; i < intervals.length; i++) {
            int left = intervals[i][0];
            int right = intervals[i][1];
            if (end < left) {
                list.add(newInterval);
            } else if (end < right) {
                list.add(new int[] { Integer.min(begin, left), right });
            } else if (end < intervals[i + 1][0]) {
                if (begin <= right) {
                    list.add(new int[] { Integer.min(begin, left), end });
                } else {
                    list.add(intervals[i]);
                    list.add(newInterval);
                }
            } else {

            }
        }
        int[][] result = new int[list.size()][];
        return list.toArray(result);
    }
}
