package leetcode;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Solution94 {
    List<Integer> list = new ArrayList<>();

    public List<Integer> inorderTraversal(TreeNode root) {
        if (root == null)
            return Collections.emptyList();
        inorderTraversal(root.left);
        list.add(root.val);
        inorderTraversal(root.right);
        return list;
    }
}
