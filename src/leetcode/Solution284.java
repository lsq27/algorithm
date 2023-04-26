package leetcode;

import java.util.ArrayList;
import java.util.Iterator;

public class Solution284 {
    class PeekingIterator implements Iterator<Integer> {
        private ArrayList<Integer> iterator = new ArrayList<>(1000);
        private int idx, length;

        public PeekingIterator(Iterator<Integer> iterator) {
            // initialize any member here.
            iterator.forEachRemaining(integer -> {
                length++;
                this.iterator.add(integer);
            });
        }

        // Returns the next element in the iteration without advancing the iterator.
        public Integer peek() {
            return iterator.get(idx);
        }

        // hasNext() and next() should behave the same as in the Iterator interface.
        // Override them if needed.
        @Override
        public Integer next() {
            return iterator.get(idx++);
        }

        @Override
        public boolean hasNext() {
            return idx < length;
        }
    }
}
