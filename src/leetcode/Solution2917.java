package leetcode;

public class Solution2917 {
    public int findKOr(int[] nums, int k) {
        int kor = 0;
        for (int i = 0; i < 31; i++) {
            int pow = 1 << i;
            int cnt = 0;
            for (int num : nums) {
                if ((pow & num) == pow) {
                    cnt++;
                    if (cnt == k) {
                        kor += pow;
                        break;
                    }
                }
            }
        }
        return kor;
    }
}