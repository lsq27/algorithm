package leetcode;

public class Solution1261 {
    private TreeNode root;

    public FindElements(TreeNode root) {
        root.val = 0;
        recover(root);
        this.root = root;
    }

    private void recover(TreeNode node) {
        if (node == null) {
            return;
        }
        if (node.left != null) {
            node.left.val = node.val * 2 + 1;
            recover(node.left);
        }
        if (node.right != null) {
            node.right.val = node.val * 2 + 2;
            recover(node.right);
        }
    }

    public boolean find(int target) {
        return findNode(target) != null;
    }

    private TreeNode findNode(int target) {
        if (target == 0) {
            return root;
        }
        if (target % 2 == 1) {
            TreeNode parent = findNode((target - 1) / 2);
            return parent == null ? null : parent.left;
        } else {
            TreeNode parent = findNode((target - 2) / 2);
            return parent == null ? null : parent.right;
        }
    }
}