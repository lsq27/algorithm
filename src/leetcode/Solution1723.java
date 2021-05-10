package leetcode;

import java.util.Arrays;
import java.util.TreeSet;

public class Solution1723 {
    public static void main(String[] args) {
        System.out.println(new Solution1723().minimumTimeRequired(new int[] { 1, 2, 4, 7, 8 }, 2));
    }

    public int minimumTimeRequired(int[] jobs, int k) {
        TreeSet<Worker> set = new TreeSet<>();
        for (int i = 0; i < k; i++) {
            set.add(new Worker(i));
        }
        Arrays.sort(jobs);
        for (int i = jobs.length - 1; i >= 0; i--) {
            Worker w = set.pollFirst();
            w.job += jobs[i];
            set.add(w);
        }
        return set.last().job;
    }

    private class Worker implements Comparable<Worker> {
        int job = 0;
        int id;

        Worker(int id) {
            this.id = id;
        }

        @Override
        public int compareTo(Worker o) {
            int result = Integer.compare(job, o.job);
            return result != 0 ? result : Integer.compare(id, o.id);
        }
    }
}
