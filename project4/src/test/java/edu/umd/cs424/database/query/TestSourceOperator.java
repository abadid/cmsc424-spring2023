package edu.umd.cs424.database.query;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import edu.umd.cs424.database.TestUtils;
import edu.umd.cs424.database.categories.*;
import edu.umd.cs424.database.table.Record;
import edu.umd.cs424.database.table.Schema;
import edu.umd.cs424.database.table.stats.TableStats;
import org.junit.experimental.categories.Category;

@Category(HW3Tests.class)
public class TestSourceOperator extends QueryOperator {
    private List<Record> recordList;
    private Schema setSchema;
    private int numRecords;

    public TestSourceOperator() throws QueryPlanException {
        super(OperatorType.SEQSCAN, null);
        this.recordList = null;
        this.setSchema = null;
        this.numRecords = 100;

        this.stats = this.estimateStats();
        this.cost = this.estimateIOCost();
    }

    public TestSourceOperator(List<Record> recordIterator, Schema schema) throws QueryPlanException {
        super(OperatorType.SEQSCAN);

        this.recordList = recordIterator;
        this.setOutputSchema(schema);
        this.setSchema = schema;
        this.numRecords = 100;

        this.stats = this.estimateStats();
        this.cost = this.estimateIOCost();
    }

    @Override
    public boolean isSequentialScan() {
        return false;
    }

    public TestSourceOperator(int numRecords) throws QueryPlanException {
        super(OperatorType.SEQSCAN, null);
        this.recordList = null;
        this.setSchema = null;
        this.numRecords = numRecords;

        this.stats = this.estimateStats();
        this.cost = this.estimateIOCost();
    }

    public Iterator<Record> execute() {
        if (this.recordList == null) {
            ArrayList<Record> recordList = new ArrayList<Record>();
            for (int i = 0; i < this.numRecords; i++) {
                recordList.add(TestUtils.createRecordWithAllTypes());
            }

            return recordList.iterator();
        }
        return this.recordList.iterator();
    }

    public Iterator<Record> iterator() {
        return this.execute();
    }

    protected Schema computeSchema() {
        if (this.setSchema == null) {
            return TestUtils.createSchemaWithAllTypes();
        }
        return this.setSchema;
    }

    public TableStats estimateStats() throws QueryPlanException {
        return new TableStats(this.computeSchema());
    }

    public int estimateIOCost() throws QueryPlanException {
        return 1;
    }
}
