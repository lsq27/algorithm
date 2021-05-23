package leetcode;

import java.util.HashSet;
import java.util.Set;

import common.ListNode;

public class Solution141 {
    public class Solution {
        public boolean hasCycle(ListNode head) {
            Set<ListNode> seen = new HashSet<>();
            while (head != null) {
                if (!seen.add(head)) {
                    return true;
                }
                head = head.next;
            }
            return false;
        }
    }
}
