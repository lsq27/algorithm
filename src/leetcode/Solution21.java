package leetcode;

public class Solution21 {
    public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        ListNode root = new ListNode();
        ListNode pointer = root;
        while (l1 != null && l2 != null) {
            if (l1.val <= l2.val) {
                pointer.next = l1;
                l1 = l1.next;
            } else {
                pointer.next = l2;
                l2 = l2.next;
            }
            pointer = pointer.next;
        }
        pointer.next = l1 != null ? l1 : l2;
        return root.next;
    }
}
