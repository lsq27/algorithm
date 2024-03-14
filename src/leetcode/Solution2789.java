package leetcode;

public class Solution2789 {
    public long maxArrayValue(int[] nums) {
        long max = nums[nums.length - 1];
        for (int i = nums.length - 2; i >= 0; i--) {
            max = max >= nums[i] ? max + nums[i] : nums[i];
        }
        return max;
    }
}
