package leetcode;

import java.util.ArrayList;
import java.util.List;

public class Solution101 {
    public boolean isSymmetric(TreeNode root) {
        if (root == null) {
            return true;
        }
        return isSymmetric(root.left, root.right);
    }

    public boolean isSymmetric(TreeNode root1, TreeNode root2) {
        if (root1 == null && root2 == null) {
            return true;
        }
        if (root1 == null || root2 == null) {
            return false;
        }
        return root1.val == root2.val && isSymmetric(root1.left, root2.right) && isSymmetric(root1.right, root2.left);
    }

    public boolean isSymmetric2(TreeNode root) {
        List<TreeNode> rootList = new ArrayList<>();
        rootList.add(root);
        while (!rootList.isEmpty()) {
            for (int i = 0; i < rootList.size() / 2; i++) {
                TreeNode left = rootList.get(i);
                TreeNode right = rootList.get(rootList.size() - 1 - i);
                if (left == null || right == null) {
                    if (left != right) {
                        return false;
                    }
                } else if (left.val != right.val) {
                    return false;
                }
            }
            List<TreeNode> leafList = new ArrayList<>();
            for (int i = 0; i < rootList.size(); i++) {
                if (rootList.get(i) != null) {
                    leafList.add(rootList.get(i).left);
                    leafList.add(rootList.get(i).right);
                }
            }
            rootList = leafList;
        }
        return true;
    }
}
