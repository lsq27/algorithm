package leetcode;

<<<<<<< HEAD
import java.util.HashMap;
import java.util.Map;

public class Solution2 {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int idx = 0; idx < nums.length; idx++) {
            int num = nums[idx];
            int need = target - num;
            if (map.containsKey(need)) {
                return new int[] { map.get(need), idx };
            } else {
                map.put(num, idx);
            }
        }

        return new int[0];
    }
}
