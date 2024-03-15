package leetcode;

public class Solution55 {
    public boolean canJump(int[] nums) {
        int max = nums[0];
        for (int i = 1; i <= max && max < nums.length - 1; i++) {
            max = Math.max(max, i + nums[i]);
        }
        return max >= nums.length - 1;
    }
}
