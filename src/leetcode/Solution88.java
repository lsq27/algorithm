package leetcode;

public class Solution88 {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        int point1 = m - 1;
        int point2 = n - 1;
        int point = m + n - 1;
        while (point1 >= 0 || point2 >= 0) {
            if (point1 < 0 || (point2 >= 0 && nums1[point1] <= nums2[point2])) {
                nums1[point--] = nums2[point2--];
            }
            else {
                nums1[point--] = nums1[point1--];
            }
        }
    }
}
