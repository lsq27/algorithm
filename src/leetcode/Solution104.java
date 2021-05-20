import java.util.ArrayList;
import java.util.List;

public class Solution104 {
    public int maxDepth(TreeNode root) {
        if (root == null) {
            return 0;
        }
        return Math.max(maxDepth(root.left), maxDepth(root.right)) + 1;
    }

    public int maxDepth2(TreeNode root) {
        if (root == null) {
            return 0;
        }
        List<TreeNode> list = new ArrayList<>();
        return Math.max(maxDepth(root.left), maxDepth(root.right)) + 1;
    }
}
