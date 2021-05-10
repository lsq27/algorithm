package leetcode;

public class Solution53 {
    public int maxSubArray(int[] nums) {
        int last = nums[0];
        int max = last;
        for (int i = 1; i < nums.length; i++) {
            last = nums[i] + (last > 0 ? last : 0);
            max = Integer.max(last, max);
        }
        return max;
    }
}
