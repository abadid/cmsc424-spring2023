package edu.umd.cs424.database.table;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import edu.umd.cs424.database.categories.*;
import edu.umd.cs424.database.concurrency.DummyLockContext;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.rules.TemporaryFolder;

import edu.umd.cs424.database.DatabaseException;
import edu.umd.cs424.database.TestUtils;
import edu.umd.cs424.database.common.BacktrackingIterator;
import edu.umd.cs424.database.databox.IntDataBox;
import edu.umd.cs424.database.databox.Type;
import edu.umd.cs424.database.io.Page;

@Category(ProjTests.class)
public class TestTable {
    public static final String TABLENAME = "testtable";
    private Table table;
    private Schema schema;

    @Rule
    public TemporaryFolder tempFolder = new TemporaryFolder();

    @Before
    public void beforeEach() throws Exception {
        this.schema = TestUtils.createSchemaWithAllTypes();
        this.table = createTestTable(this.schema, TABLENAME);
    }

    @After
    public void afterEach() {
        table.close();
    }

    private Table createTestTable(Schema schema, String tableName) throws DatabaseException {
        try {
            File file = tempFolder.newFile(tableName + Table.FILENAME_EXTENSION);
            return new Table(tableName, schema, file.getAbsolutePath(), new DummyLockContext(), null);
        } catch (IOException e) {
            throw new DatabaseException(e.getMessage());
        }
    }

    private static Record createRecordWithAllTypes(int i) {
        Record r = TestUtils.createRecordWithAllTypes();
        r.getValues().set(1, new IntDataBox(i));
        return r;
    }

    @Test
    @Category(SystemTests.class)
    public void testComputeBitMapSizeInBytesAndComputeNumRecordsPerPage() {
        Schema oneByte = new Schema(Arrays.asList("x"), Arrays.asList(Type.stringType(1)));
        Schema tenBytes = new Schema(Arrays.asList("x"), Arrays.asList(Type.stringType(10)));

        for (int i = 9; i <= 17; ++i) {
            assertEquals(8, Table.computeNumRecordsPerPage(i, oneByte));
            assertEquals(1, Table.computeBitmapSizeInBytes(i, oneByte));
        }
        for (int i = 18; i <= 26; ++i) {
            assertEquals(16, Table.computeNumRecordsPerPage(i, oneByte));
            assertEquals(2, Table.computeBitmapSizeInBytes(i, oneByte));
        }
        for (int i = 27; i <= 35; ++i) {
            assertEquals(24, Table.computeNumRecordsPerPage(i, oneByte));
            assertEquals(3, Table.computeBitmapSizeInBytes(i, oneByte));
        }

        for (int i = 81; i <= 161; ++i) {
            assertEquals(8, Table.computeNumRecordsPerPage(i, tenBytes));
            assertEquals(1, Table.computeBitmapSizeInBytes(i, tenBytes));
        }
        for (int i = 162; i <= 242; ++i) {
            assertEquals(16, Table.computeNumRecordsPerPage(i, tenBytes));
            assertEquals(2, Table.computeBitmapSizeInBytes(i, tenBytes));
        }
        for (int i = 243; i <= 323; ++i) {
            assertEquals(24, Table.computeNumRecordsPerPage(i, tenBytes));
            assertEquals(3, Table.computeBitmapSizeInBytes(i, tenBytes));
        }
    }

    @Test
    @Category(SystemTests.class)
    public void testGetNumRecordsPerPage() throws DatabaseException {
        assertEquals(14, schema.getSizeInBytes());
        assertEquals(4096, Page.pageSize);
        // 36 + (288 * 14) = 4068
        // 37 + (296 * 14) = 4181
        assertEquals(288, table.getNumRecordsPerPage());
    }

    @Test
    @Category(SystemTests.class)
    public void testGetBitmapSizeInBytes() throws DatabaseException {
        assertEquals(14, schema.getSizeInBytes());
        assertEquals(4096, Page.pageSize);
        // 36 + (288 * 14) = 4068
        // 37 + (296 * 14) = 4181
        assertEquals(36, table.getBitmapSizeInBytes());
    }

    @Test
    @Category(SystemTests.class)
    public void testSingleInsertAndGet() throws DatabaseException {
        Record r = createRecordWithAllTypes(0);
        RecordId rid = table.addRecord(null, r.getValues());
        assertEquals(r, table.getRecord(null, rid));
    }

    @Test
    @Category(SystemTests.class)
    public void testThreePagesOfInserts() throws DatabaseException {
        List<RecordId> rids = new ArrayList<>();
        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            Record r = createRecordWithAllTypes(i);
            rids.add(table.addRecord(null, r.getValues()));
        }

        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            Record r = createRecordWithAllTypes(i);
            assertEquals(r, table.getRecord(null, rids.get(i)));
        }
    }

    @Test
    @Category(SystemTests.class)
    public void testSingleDelete() throws DatabaseException {
        Record r = createRecordWithAllTypes(0);
        RecordId rid = table.addRecord(null, r.getValues());
        assertEquals(r, table.deleteRecord(null, rid));
    }

    @Test
    @Category(SystemTests.class)
    public void testThreePagesOfDeletes() throws DatabaseException {
        List<RecordId> rids = new ArrayList<>();
        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            Record r = createRecordWithAllTypes(i);
            rids.add(table.addRecord(null, r.getValues()));
        }

        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            Record r = createRecordWithAllTypes(i);
            assertEquals(r, table.deleteRecord(null, rids.get(i)));
        }
    }

    @Test
    @Category(SystemTests.class)
    public void testThreePagesCleanupThenInsert() throws DatabaseException {
        List<RecordId> rids = new ArrayList<>();
        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            Record r = createRecordWithAllTypes(i);
            rids.add(table.addRecord(null, r.getValues()));
        }

        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            table.deleteRecord(null, rids.get(i));
        }
        table.cleanup(null);

        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            Record r = createRecordWithAllTypes(i);
            table.addRecord(null, r.getValues());
        }

        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            table.deleteRecord(null, rids.get(i));
        }
    }

    @Test(expected = DatabaseException.class)
    @Category(SystemTests.class)
    public void testGetDeletedRecord() throws DatabaseException {
        Record r = createRecordWithAllTypes(0);
        RecordId rid = table.addRecord(null, r.getValues());
        table.deleteRecord(null, rid);
        table.getRecord(null, rid);
    }

    @Test
    @Category(SystemTests.class)
    public void testUpdateSingleRecord() throws DatabaseException {
        Record rOld = createRecordWithAllTypes(0);
        Record rNew = createRecordWithAllTypes(42);

        RecordId rid = table.addRecord(null, rOld.getValues());
        assertEquals(rOld, table.updateRecord(null, rNew.getValues(), rid));
        assertEquals(rNew, table.getRecord(null, rid));
    }

    @Test
    @Category(SystemTests.class)
    public void testThreePagesOfUpdates() throws DatabaseException {
        List<RecordId> rids = new ArrayList<>();
        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            Record r = createRecordWithAllTypes(i);
            rids.add(table.addRecord(null, r.getValues()));
        }

        for (int i = 0; i < table.getNumRecordsPerPage() * 3; ++i) {
            Record rOld = createRecordWithAllTypes(i);
            Record rNew = createRecordWithAllTypes(i * 10000);
            assertEquals(rOld, table.updateRecord(null, rNew.getValues(), rids.get(i)));
            assertEquals(rNew, table.getRecord(null, rids.get(i)));
        }
    }

    @Test
    @Category(SystemTests.class)
    public void testLoadTableFromDisk() throws Exception {
        // We add 42 to make sure we have some incomplete pages.
        int numRecords = table.getNumRecordsPerPage() * 2 + 42;

        List<RecordId> rids = new ArrayList<>();
        for (int i = 0; i < numRecords; ++i) {
            Record r = createRecordWithAllTypes(i);
            rids.add(table.addRecord(null, r.getValues()));
        }
        table.close();

        table = new Table(table.getName(), table.getFilename(), new DummyLockContext(), null);
        for (int i = 0; i < numRecords; ++i) {
            Record r = createRecordWithAllTypes(i);
            assertEquals(r, table.getRecord(null, rids.get(i)));
        }
    }

    @Test
    @Category(SystemTests.class)
    public void testLoadTableFromDiskThenWriteMoreRecords() throws Exception {
        // We add 42 to make sure we have some incomplete pages.
        int numRecords = table.getNumRecordsPerPage() * 2 + 42;

        List<RecordId> rids = new ArrayList<>();
        for (int i = 0; i < numRecords; ++i) {
            Record r = createRecordWithAllTypes(i);
            rids.add(table.addRecord(null, r.getValues()));
        }
        table.close();

        table = new Table(table.getName(), table.getFilename(), new DummyLockContext(), null);
        for (int i = numRecords; i < 2 * numRecords; ++i) {
            Record r = createRecordWithAllTypes(i);
            rids.add(table.addRecord(null, r.getValues()));
        }

        for (int i = 0; i < 2 * numRecords; ++i) {
            Record r = createRecordWithAllTypes(i);
            assertEquals(r, table.getRecord(null, rids.get(i)));
        }
    }

    /**
     * Loads some number of pages of records. rids will be loaded with all the record IDs
     * of the new records, and the number of records will be returned.
     */
    private int setupIteratorTest(List<RecordId> rids, int pages) throws DatabaseException {
        int numRecords = table.getNumRecordsPerPage() * pages;

        // Write the records.
        for (int i = 0; i < numRecords; ++i) {
            Record r = createRecordWithAllTypes(i);
            RecordId rid = table.addRecord(null, r.getValues());
            rids.add(rid);
        }

        return numRecords;
    }

    /**
     * See above; this overload should be used when the list of record IDs is not
     * needed.
     */
    private int setupIteratorTest(int pages) throws DatabaseException {
        List<RecordId> rids = new ArrayList<>();
        return setupIteratorTest(rids, pages);
    }

    /**
     * Performs a simple loop checking (end - start)/incr records from iter, and
     * assuming values of recordWithAllTypes(i), where start <= i < end and
     * i increments by incr.
     */
    private void checkSequentialRecords(int start, int end, int incr,
                                        BacktrackingIterator<Record> iter) {
        for (int i = start; i < end; i += incr) {
            assertTrue(iter.hasNext());
            assertEquals(createRecordWithAllTypes(i), iter.next());
        }
    }

    /**
     * Basic test over a full page of records to check that next/hasNext work.
     */
    @Test
    @Category(PublicTests.class)
    public void testRIDPageIterator() throws DatabaseException {
        int numRecords = setupIteratorTest(1);
        Iterator<Page> pages = table.getAllocator().iterator(null);
        // Header page.
        pages.next();
        Page page = pages.next();

        BacktrackingIterator<Record> iter = new RecordIterator(table, table.new RIDPageIterator(null,
                page));
        checkSequentialRecords(0, numRecords, 1, iter);
        assertFalse(iter.hasNext());
    }

    /**
     * Basic test over a half-full page of records, with a missing first/last
     * record and gaps between every record, to check that next/hasNext work.
     */
    @Test
    @Category(PublicTests.class)
    public void testRIDPageIteratorWithGaps() throws DatabaseException {
        List<RecordId> rids = new ArrayList<>();
        int numRecords = setupIteratorTest(rids, 1);

        // Delete every other record and the last record.
        for (int i = 0; i < numRecords - 1; i += 2) {
            table.deleteRecord(null, rids.get(i));
        }
        table.deleteRecord(null, rids.get(numRecords - 1));

        Iterator<Page> pages = table.getAllocator().iterator(null);
        // Header page.
        pages.next();
        Page page = pages.next();

        BacktrackingIterator<Record> iter = new RecordIterator(table, table.new RIDPageIterator(null,
                page));
        checkSequentialRecords(1, numRecords - 1, 2, iter);
        assertFalse(iter.hasNext());
    }

    /**
     * Basic test making sure that RIDPageIterator handles mark/reset properly.
     */
    @Test
    @Category(PublicTests.class)
    public void testRIDPageIteratorMarkReset() throws DatabaseException {
        int numRecords = setupIteratorTest(1);
        Iterator<Page> pages = table.getAllocator().iterator(null);
        // Header page.
        pages.next();
        Page page = pages.next();

        BacktrackingIterator<Record> iter = new RecordIterator(table, table.new RIDPageIterator(null,
                page));
        checkSequentialRecords(0, numRecords / 2, 1, iter);
        iter.mark();
        checkSequentialRecords(numRecords / 2, numRecords, 1, iter);
        assertFalse(iter.hasNext());
        iter.reset();
        // -1 because the record before the mark must also be returned
        checkSequentialRecords(numRecords / 2 - 1, numRecords, 1, iter);
        assertFalse(iter.hasNext());

        // resetting twice to the same mark should be fine.
        iter.reset();
        checkSequentialRecords(numRecords / 2 - 1, numRecords, 1, iter);
        assertFalse(iter.hasNext());
    }

    /**
     * Extra test making sure that RIDPageIterator handles mark/reset properly.
     */

    /**
     * Tests RIDBlockIterator over three full pages of records.
     */
    @Test
    @Category(PublicTests.class)
    public void testRIDBlockIterator() throws DatabaseException {
        int numRecords = setupIteratorTest(3);
        Iterator<Page> pages = table.getAllocator().iterator(null);
        // Header page.
        pages.next();

        BacktrackingIterator<Record> iter = new RecordIterator(table, table.new RIDBlockIterator(null,
                pages, 3));
        checkSequentialRecords(0, numRecords, 1, iter);
        assertFalse(iter.hasNext());
    }

    /**
     * Basic test making sure that RIDBlockIterator handles mark/reset properly.
     */
    @Test
    @Category(PublicTests.class)
    public void testRIDBlockIteratorMarkReset() throws DatabaseException {
        int numRecords = setupIteratorTest(3);
        Iterator<Page> pages = table.getAllocator().iterator(null);
        // Header page.
        pages.next();

        BacktrackingIterator<Record> iter = new RecordIterator(table, table.new RIDBlockIterator(null,
                pages, 3));
        checkSequentialRecords(0, numRecords / 2, 1, iter);
        iter.mark();
        checkSequentialRecords(numRecords / 2, numRecords, 1, iter);
        assertFalse(iter.hasNext());
        iter.reset();
        // -1 because the record before the mark must also be returned
        checkSequentialRecords(numRecords / 2 - 1, numRecords, 1, iter);
        assertFalse(iter.hasNext());

        // resetting twice to the same mark should be fine.
        iter.reset();
        checkSequentialRecords(numRecords / 2 - 1, numRecords, 1, iter);
        assertFalse(iter.hasNext());

        // page boundary test
        pages = table.getAllocator().iterator(null);
        pages.next();
        iter = new RecordIterator(table, table.new RIDBlockIterator(null, pages, 3));
        // test second to last record of second to last page
        checkSequentialRecords(0, 2 * numRecords / 3 - 1, 1, iter);
        iter.mark();
        checkSequentialRecords(2 * numRecords / 3 - 1, numRecords, 1, iter);
        assertFalse(iter.hasNext());
        iter.reset();
        checkSequentialRecords(2 * numRecords / 3 - 2, numRecords, 1, iter);
        assertFalse(iter.hasNext());
        iter.reset();
        iter.next();
        iter.next();
        // test last record of second to last page
        iter.mark();
        checkSequentialRecords(2 * numRecords / 3, numRecords, 1, iter);
        assertFalse(iter.hasNext());
        iter.reset();
        checkSequentialRecords(2 * numRecords / 3 - 1, numRecords, 1, iter);
        assertFalse(iter.hasNext());
    }

    /**
     * Simple test of TableIterator over three pages of records with no gaps.
     */
    @Test
    @Category(PublicTests.class)
    public void testTableIterator() throws DatabaseException {
        // We add 42 to make sure we have some incomplete pages.
        int numRecords = table.getNumRecordsPerPage() * 2 + 42;

        // Write the records.
        for (int i = 0; i < numRecords; ++i) {
            Record r = createRecordWithAllTypes(i);
            table.addRecord(null, r.getValues());
        }

        // Iterate once.
        BacktrackingIterator<Record> iter = table.iterator(null);
        checkSequentialRecords(0, numRecords, 1, iter);
        assertFalse(iter.hasNext());

        // Iterate twice for good measure.
        iter = table.iterator(null);
        checkSequentialRecords(0, numRecords, 1, iter);
        assertFalse(iter.hasNext());

        // Reload the database and iterate again.
        table.close();
        table = new Table(table.getName(), table.getFilename(), new DummyLockContext(), null);
        iter = table.iterator(null);
        checkSequentialRecords(0, numRecords, 1, iter);
        assertFalse(iter.hasNext());
    }

    /**
     * Simple test of TableIterator over three pages of records with every other
     * record missing.
     */
    @Test
    @Category(PublicTests.class)
    public void testTableIteratorWithGaps() throws DatabaseException {
        // We add 42 to make sure we have some incomplete pages.
        int numRecords = table.getNumRecordsPerPage() * 2 + 42;

        // Write the records.
        List<RecordId> rids = new ArrayList<>();
        for (int i = 0; i < numRecords; ++i) {
            Record r = createRecordWithAllTypes(i);
            rids.add(table.addRecord(null, r.getValues()));
        }

        // Delete every other record.
        for (int i = 0; i < numRecords; i += 2) {
            table.deleteRecord(null, rids.get(i));
        }

        // Iterate.
        BacktrackingIterator<Record> iter = table.iterator(null);
        checkSequentialRecords(1, numRecords, 2, iter);
        assertFalse(iter.hasNext());

        // Reload the database and iterate again.
        table.close();
        table = new Table(table.getName(), table.getFilename(), new DummyLockContext(), null);
        iter = table.iterator(null);
        checkSequentialRecords(1, numRecords, 2, iter);
        assertFalse(iter.hasNext());
    }
}
