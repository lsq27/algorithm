package leetcode;

public class Solution27 {
    public int removeElement(int[] nums, int val) {
        int point = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] != val) {
                nums[point++] = nums[i];
            }
        }
        return point;
    }
}
