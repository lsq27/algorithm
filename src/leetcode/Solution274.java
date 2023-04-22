package leetcode;

import java.util.Arrays;

public class Solution274 {
    public int hIndex(int[] citations) {
        Arrays.sort(citations);
        int h = citations.length;
        while (h > 0 && citations[citations.length - h] < h) {
            h--;
        }
        return h;
    }
}
