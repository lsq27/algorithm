package leetcode;

public class Solution283 {
    public void moveZeroes(int[] nums) {
        int last = nums.length - 1, first = 0;
        while (first < last) {
            if (nums[first] == 0) {
                for (int i = first; i + 1 <= last; i++) {
                    int tmp = nums[i];
                    nums[i] = nums[i + 1];
                    nums[i + 1] = tmp;
                }
                last--;
            } else {
                first++;
            }
        }
    }
}
