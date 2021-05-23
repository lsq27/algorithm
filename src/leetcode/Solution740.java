package leetcode;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class Solution740 {
    public int deleteAndEarn(int[] nums) {
        Arrays.sort(nums);
        List<Integer> list = new LinkedList<>(Arrays.asList(nums));

    }

    public int deleteAndEarn(List<Integer> nums, int score) {
        if (nums.isEmpty()) {
            return score;
        }
        for (int i = 0; i < nums.size(); i++) {

        }
    }
}
