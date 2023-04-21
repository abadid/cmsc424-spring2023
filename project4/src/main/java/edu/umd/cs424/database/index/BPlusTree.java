package edu.umd.cs424.database.index;

import java.io.Closeable;
import java.io.IOException;
import java.io.FileWriter;
import java.io.File;
import java.util.*;

import edu.umd.cs424.database.BaseTransaction;
import edu.umd.cs424.database.common.Buffer;
import edu.umd.cs424.database.common.Pair;
import edu.umd.cs424.database.concurrency.LockContext;
import edu.umd.cs424.database.concurrency.LockType;
import edu.umd.cs424.database.concurrency.LockUtil;
import edu.umd.cs424.database.databox.DataBox;
import edu.umd.cs424.database.databox.Type;
import edu.umd.cs424.database.io.Page;
import edu.umd.cs424.database.io.PageAllocator;
import edu.umd.cs424.database.table.RecordId;

/**
 * A persistent B+ tree.
 *
 *   // Create an order 2, integer-valued B+ tree that is persisted in tree.txt.
 *   BPlusTree tree = new BPlusTree("tree.txt", Type.intType(), 2, transaction);
 *
 *   // Insert some values into the tree.
 *   tree.put(new IntDataBox(0), new RecordId(0, (short) 0));
 *   tree.put(new IntDataBox(1), new RecordId(1, (short) 1));
 *   tree.put(new IntDataBox(2), new RecordId(2, (short) 2));
 *
 *   // Get some values out of the tree.
 *   tree.get(new IntDataBox(0)); // Optional.of(RecordId(0, 0))
 *   tree.get(new IntDataBox(1)); // Optional.of(RecordId(1, 1))
 *   tree.get(new IntDataBox(2)); // Optional.of(RecordId(2, 2))
 *   tree.get(new IntDataBox(3)); // Optional.empty();
 *
 *   // Iterate over the record ids in the tree.
 *   tree.scanEqual(new IntDataBox(2));        // [(2, 2)]
 *   tree.scanAll();                           // [(0, 0), (1, 1), (2, 2)]
 *   tree.scanGreaterEqual(new IntDataBox(1)); // [(1, 1), (2, 2)]
 *
 *   // Remove some elements from the tree.
 *   tree.get(new IntDataBox(0)); // Optional.of(RecordId(0, 0))
 *   tree.remove(new IntDataBox(0));
 *   tree.get(new IntDataBox(0)); // Optional.empty()
 *
 *   // Load the tree from disk.
 *   BPlusTree fromDisk = new BPlusTree("tree.txt");
 *
 *   // All the values are still there.
 *   fromDisk.get(new IntDataBox(0)); // Optional.empty()
 *   fromDisk.get(new IntDataBox(1)); // Optional.of(RecordId(1, 1))
 *   fromDisk.get(new IntDataBox(2)); // Optional.of(RecordId(2, 2))
 */
public class BPlusTree implements Closeable {
    public static final String FILENAME_PREFIX = "db";
    public static final String FILENAME_EXTENSION = ".index";

    private PageAllocator allocator;
    private BPlusTreeMetadata metadata;
    private Page headerPage;
    private BPlusNode root;
    private LockContext lockContext;

    // Constructors ////////////////////////////////////////////////////////////
    /**
     * Construct a new B+ tree which is serialized into the file `filename`,
     * stores keys of type `keySchema`, and has order `order`. For example,
     * `new BPlusTree("tree.txt", Type.intType(), 2)` constructs a B+ tree that
     * is serialized to "tree.txt", that maps integers to record ids, and that
     * has order 2.
     *
     * If the specified order is so large that a single node cannot fit on a
     * single page, then a BPlusTree exception is thrown. If you want to have
     * maximally full B+ tree nodes, then use the BPlusTree.maxOrder function
     * to get the appropriate order.
     *
     * We reserve the first page (i.e. page number 0) of the file for a header
     * page which contains:
     *
     *   - the key schema of the tree,
     *   - the order of the tree, and
     *   - the page number of the root of the tree.
     *
     * All other pages are serializations of inner and leaf nodes. See
     * writeHeader for details.
     */
    public BPlusTree(String filename, Type keySchema, int order, LockContext lockContext,
                     BaseTransaction transaction)
    throws BPlusTreeException {
        // Sanity checks.
        if (order < 0) {
            String msg = String.format(
                             "You cannot construct a B+ tree with negative order %d.",
                             order);
            throw new BPlusTreeException(msg);
        }

        int maxOrder = BPlusTree.maxOrder(Page.pageSize, keySchema);
        if (order > maxOrder) {
            String msg = String.format(
                             "You cannot construct a B+ tree with order %d greater than the " +
                             "max order %d.",
                             order, maxOrder);
            throw new BPlusTreeException(msg);
        }

        this.lockContext = lockContext;

        // Initialize the page allocator.
        this.allocator = new PageAllocator(this.lockContext, filename, true, transaction);
        this.metadata = new BPlusTreeMetadata(allocator, keySchema, order);

        // Allocate the header page.
        int headerPageNum = allocator.allocPage(transaction);
        assert(headerPageNum == 0);
        this.headerPage = allocator.fetchPage(transaction, headerPageNum);

        // Construct the root.
        List<DataBox> keys = new ArrayList<>();
        List<RecordId> rids = new ArrayList<>();
        Optional<Integer> rightSibling = Optional.empty();
        this.root = new LeafNode(this.metadata, keys, rids, rightSibling, transaction);

        // Initialize the header page.
        writeHeader(transaction, headerPage);
    }

    /** Read a B+ tree that was previously serialized to filename. */
    public BPlusTree(String filename, LockContext lockContext, BaseTransaction transaction) {
        this.lockContext = lockContext;

        // Initialize the page allocator and fetch the header page.
        this.allocator = new PageAllocator(this.lockContext, filename, false, transaction);
        Page headerPage = allocator.fetchPage(transaction, 0);
        Buffer buf = headerPage.getBuffer(transaction);

        // Read the contents of the header page. See writeHeader for information
        // on exactly what is written to the header page.
        Type keySchema = Type.fromBytes(buf);
        int order = buf.getInt();
        int rootPageNum = buf.getInt();

        // Initialize members.
        this.metadata = new BPlusTreeMetadata(allocator, keySchema, order);
        this.headerPage = allocator.fetchPage(transaction, 0);
        this.root = BPlusNode.fromBytes(transaction, this.metadata, rootPageNum);
    }

    public void close() {
        this.allocator.close();
    }

    // Core API ////////////////////////////////////////////////////////////////
    /**
     * Returns the value associated with `key`.
     *
     *   // Create a B+ tree and insert a single value into it.
     *   BPlusTree tree = new BPlusTree("t.txt", Type.intType(), 4);
     *   DataBox key = new IntDataBox(42);
     *   RecordId rid = new RecordId(0, (short) 0);
     *   tree.put(key, rid);
     *
     *   // Get the value we put and also try to get a value we never put.
     *   tree.get(key);                 // Optional.of(rid)
     *   tree.get(new IntDataBox(100)); // Optional.empty()
     */
    public Optional<RecordId> get(BaseTransaction transaction, DataBox key) {
        typecheck(key);
        return Optional.empty();
    }

    /**
     * scanEqual(k) is equivalent to get(k) except that it returns an iterator
     * instead of an Optional. That is, if get(k) returns Optional.empty(),
     * then scanEqual(k) returns an empty iterator. If get(k) returns
     * Optional.of(rid) for some rid, then scanEqual(k) returns an iterator
     * over rid.
     */
    public Iterator<RecordId> scanEqual(BaseTransaction transaction, DataBox key) {
        typecheck(key);
        Optional<RecordId> rid = get(transaction, key);
        if (rid.isPresent()) {
            ArrayList<RecordId> l = new ArrayList<>();
            l.add(rid.get());
            return l.iterator();
        } else {
            return new ArrayList<RecordId>().iterator();
        }
    }

    /**
     * Returns an iterator over all the RecordIds stored in the B+ tree in
     * ascending order of their corresponding keys.
     *
     *   // Create a B+ tree and insert some values into it.
     *   BPlusTree tree = new BPlusTree("t.txt", Type.intType(), 4);
     *   tree.put(new IntDataBox(2), new RecordId(2, (short) 2));
     *   tree.put(new IntDataBox(5), new RecordId(5, (short) 5));
     *   tree.put(new IntDataBox(4), new RecordId(4, (short) 4));
     *   tree.put(new IntDataBox(1), new RecordId(1, (short) 1));
     *   tree.put(new IntDataBox(3), new RecordId(3, (short) 3));
     *
     *   Iterator<RecordId> iter = tree.scanAll();
     *   iter.next(); // RecordId(1, 1)
     *   iter.next(); // RecordId(2, 2)
     *   iter.next(); // RecordId(3, 3)
     *   iter.next(); // RecordId(4, 4)
     *   iter.next(); // RecordId(5, 5)
     *   iter.next(); // NoSuchElementException
     *
     * Note that you CAN NOT materialize all record ids in memory and then
     * return an iterator over them. Your iterator must lazily scan over the
     * leaves of the B+ tree. Solutions that materialize all record ids in
     * memory will receive 0 points.
     */
    public Iterator<RecordId> scanAll(BaseTransaction transaction) {
        return Collections.<RecordId>emptyIterator();
    }

    /**
     * Returns an iterator over all the RecordIds stored in the B+ tree that
     * are greater than or equal to `key`. RecordIds are returned in ascending
     * of their corresponding keys.
     *
     *   // Create a B+ tree and insert some values into it.
     *   BPlusTree tree = new BPlusTree("t.txt", Type.intType(), 4);
     *   tree.put(new IntDataBox(2), new RecordId(2, (short) 2));
     *   tree.put(new IntDataBox(5), new RecordId(5, (short) 5));
     *   tree.put(new IntDataBox(4), new RecordId(4, (short) 4));
     *   tree.put(new IntDataBox(1), new RecordId(1, (short) 1));
     *   tree.put(new IntDataBox(3), new RecordId(3, (short) 3));
     *
     *   Iterator<RecordId> iter = tree.scanGreaterEqual(new IntDataBox(3));
     *   iter.next(); // RecordId(3, 3)
     *   iter.next(); // RecordId(4, 4)
     *   iter.next(); // RecordId(5, 5)
     *   iter.next(); // NoSuchElementException
     *
     * Note that you CAN NOT materialize all record ids in memory and then
     * return an iterator over them. Your iterator must lazily scan over the
     * leaves of the B+ tree. Solutions that materialize all record ids in
     * memory will receive 0 points.
     */
    public Iterator<RecordId> scanGreaterEqual(BaseTransaction transaction, DataBox key) {
        typecheck(key);
        return Collections.<RecordId>emptyIterator();
    }

    /**
     * Inserts a (key, rid) pair into a B+ tree. If the key already exists in
     * the B+ tree, then the pair is not inserted and an exception is raised.
     *
     *   BPlusTree tree = new BPlusTree("t.txt", Type.intType(), 4);
     *   DataBox key = new IntDataBox(42);
     *   RecordId rid = new RecordId(42, (short) 42);
     *   tree.put(key, rid); // Sucess :)
     *   tree.put(key, rid); // BPlusTreeException :(
     */
    public void put(BaseTransaction transaction, DataBox key, RecordId rid) throws BPlusTreeException {
        typecheck(key);
        return;
    }

    /**
     * Bulk loads data into the B+ tree. Tree should be empty and the data
     * iterator should be in sorted order (by the DataBox key field) and
     * contain no duplicates (no error checking is done for this).
     *
     * fillFactor specifies the fill factor for leaves only; inner nodes should
     * be filled up to full and split in half exactly like in put.
     *
     * This method should raise an exception if the tree is not empty at time
     * of bulk loading. If data does not meet the preconditions (contains
     * duplicates or not in order), the resulting behavior is undefined.
     *
     * The behavior of this method should be similar to that of InnerNode's
     * bulkLoad (see comments in BPlusNode.bulkLoad).
     */
    public void bulkLoad(BaseTransaction transaction, Iterator<Pair<DataBox, RecordId>> data,
                         float fillFactor) throws BPlusTreeException {
        return;
    }

    /**
     * Deletes a (key, rid) pair from a B+ tree.
     *
     *   BPlusTree tree = new BPlusTree("t.txt", Type.intType(), 4);
     *   DataBox key = new IntDataBox(42);
     *   RecordId rid = new RecordId(42, (short) 42);
     *
     *   tree.put(key, rid);
     *   tree.get(key); // Optional.of(rid)
     *   tree.remove(key);
     *   tree.get(key); // Optional.empty()
     */
    public void remove(BaseTransaction transaction, DataBox key) {
        typecheck(key);
        return;
    }

    // Helpers /////////////////////////////////////////////////////////////////
    /**
     * Returns a sexp representation of this tree. See BPlusNode.toSexp for
     * more information.
     */
    public String toSexp(BaseTransaction transaction) {
        return root.toSexp(transaction);
    }

    /**
     * Debugging large B+ trees is hard. To make it a bit easier, we can print
     * out a B+ tree as a DOT file which we can then convert into a nice
     * picture of the B+ tree. tree.toDot() returns the contents of DOT file
     * which illustrates the B+ tree. The details of the file itself is not at
     * all important, just know that if you call tree.toDot() and save the
     * output to a file called tree.dot, then you can run this command
     *
     *   dot -T pdf tree.dot -o tree.pdf
     *
     * to create a PDF of the tree.
     */
    public String toDot(BaseTransaction transaction) {
        List<String> strings = new ArrayList<>();
        strings.add("digraph g {" );
        strings.add("  node [shape=record, height=0.1];");
        strings.add(root.toDot(transaction));
        strings.add("}");
        return String.join("\n", strings);
    }

    /**
     * This function is very similar to toDot() except that we write
     * the dot representation of the B+ tree to a dot file and then
     * convert that to a PDF that will be stored in the src directory. Pass in a
     * string with the ".pdf" extension included at the end (ex "tree.pdf").
     */
    public void toDotPDFFile(BaseTransaction transaction, String filename) {
        String tree_string = toDot(transaction);

        // Writing to intermediate dot file
        try {
            File file = new File("tree.dot");
            FileWriter fileWriter = new FileWriter(file);
            fileWriter.write(tree_string);
            fileWriter.flush();
            fileWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Running command to convert dot file to PDF
        try {
            Runtime.getRuntime().exec("dot -T pdf tree.dot -o " + filename);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns the largest number d such that the serialization of a LeafNode
     * with 2d entries and an InnerNode with 2d keys will fit on a single page
     * of size `pageSizeInBytes`.
     */
    public static int maxOrder(int pageSizeInBytes, Type keySchema) {
        int leafOrder = LeafNode.maxOrder(pageSizeInBytes, keySchema);
        int innerOrder = InnerNode.maxOrder(pageSizeInBytes, keySchema);
        return Math.min(leafOrder, innerOrder);
    }

    /** Returns the number of pages used to serialize the tree. */
    public int getNumPages() {
        return metadata.getAllocator().getNumPages();
    }

    /** Serializes the header page to page. */
    private void writeHeader(BaseTransaction transaction, Page page) {
        byte[] keySchema = metadata.getKeySchema().toBytes();
        Buffer buf = page.getBuffer(transaction);
        buf.put(keySchema);
        buf.putInt(metadata.getOrder());
        buf.putInt(root.getPage().getPageNum());
    }

    private void typecheck(DataBox key) {
        Type t = metadata.getKeySchema();
        if (!key.type().equals(t)) {
            String msg = String.format("DataBox %s is not of type %s", key, t);
            throw new IllegalArgumentException(msg);
        }
    }

    // Iterator ////////////////////////////////////////////////////////////////
    private class BPlusTreeIterator implements Iterator<RecordId> {
        @Override
        public boolean hasNext() {
            return false;
        }

        @Override
        public RecordId next() {
            throw new NoSuchElementException();
        }
    }
}
