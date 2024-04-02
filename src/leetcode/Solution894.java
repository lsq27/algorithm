package leetcode;

import java.util.ArrayList;
import java.util.List;

public class Solution894 {
    public List<TreeNode> allPossibleFBT(int n) {
        List<TreeNode> result = new ArrayList<>();
        if (n == 1) {
            result.add(new TreeNode());
            return result;
        }
        for (int i = 1; i < n; i += 2) {
            List<TreeNode> left = allPossibleFBT(i);
            List<TreeNode> right = allPossibleFBT(n - 1 - i);
            for (TreeNode leftTreeNode : left) {
                for (TreeNode rightTreeNode : right) {
                    TreeNode root = new TreeNode();
                    root.left = leftTreeNode;
                    root.right = rightTreeNode;
                    result.add(root);
                }
            }
        }
        return result;
    }
}
