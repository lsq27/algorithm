package leetcode;

public class Solution287 {
    public int findDuplicate(int[] nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        return sum - nums.length * (nums.length - 1) / 2;
    }
}
