package leetcode;

public class Solution88 {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        int point1 = 0;
        int point2 = 0;
        int extra = 0;
        while (point1 < m && point2 < n) {
            if (nums1[point1] <= nums2[point2] && nums1[point1] <= nums2[extra]) {
                point1++;
                continue;
            }
            if (nums2[point2] <= nums1[point1] && nums2[point2] <= nums2[extra]) {
                int tmp = nums1[point1];
                nums1[point1] = nums2[point2];
                nums2[point2] = tmp;
                point1++;
                point2++;
                continue;
            }
            if (nums2[extra] <= nums1[point1] && nums2[extra] <= nums2[point2]) {
                int tmp = nums1[point1];
                nums1[point1] = nums2[extra];
                nums2[extra] = tmp;
                point1++;
            }
        }
        if (point1 == m) {

        }
    }
}
