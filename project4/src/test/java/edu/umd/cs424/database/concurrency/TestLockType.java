package edu.umd.cs424.database.concurrency;

import edu.umd.cs424.database.TimeoutScaling;
import edu.umd.cs424.database.categories.*;
import org.junit.Rule;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.rules.DisableOnDebug;
import org.junit.rules.TestRule;
import org.junit.rules.Timeout;

import static org.junit.Assert.*;

@Category({HW5Tests.class, HW5Part1Tests.class})
public class TestLockType {
    @Rule
    public TestRule globalTimeout = new DisableOnDebug(Timeout.millis((long) (200 * TimeoutScaling.factor)));

    @Test
    @Category(PublicTests.class)
    public void testCompatibleNL() {
        assertTrue(LockType.compatible(LockType.NL, LockType.NL));
        assertTrue(LockType.compatible(LockType.NL, LockType.S));
        assertTrue(LockType.compatible(LockType.NL, LockType.X));
        assertTrue(LockType.compatible(LockType.NL, LockType.IS));
        assertTrue(LockType.compatible(LockType.NL, LockType.IX));
        assertTrue(LockType.compatible(LockType.NL, LockType.SIX));
        assertTrue(LockType.compatible(LockType.S, LockType.NL));
        assertTrue(LockType.compatible(LockType.X, LockType.NL));
        assertTrue(LockType.compatible(LockType.IS, LockType.NL));
        assertTrue(LockType.compatible(LockType.IX, LockType.NL));
        assertTrue(LockType.compatible(LockType.SIX, LockType.NL));
    }

    @Test
    @Category(PublicTests.class)
    public void testCompatibleS() {
        assertTrue(LockType.compatible(LockType.S, LockType.S));
        assertFalse(LockType.compatible(LockType.S, LockType.X));
        assertTrue(LockType.compatible(LockType.S, LockType.IS));
        assertFalse(LockType.compatible(LockType.S, LockType.IX));
        assertFalse(LockType.compatible(LockType.S, LockType.SIX));
        assertFalse(LockType.compatible(LockType.X, LockType.S));
        assertTrue(LockType.compatible(LockType.IS, LockType.S));
        assertFalse(LockType.compatible(LockType.IX, LockType.S));
        assertFalse(LockType.compatible(LockType.SIX, LockType.S));
    }

    @Test
    @Category(PublicTests.class)
    public void testParentReal() {
        assertEquals(LockType.NL, LockType.parentLock(LockType.NL));
        assertEquals(LockType.IS, LockType.parentLock(LockType.S));
        assertEquals(LockType.IX, LockType.parentLock(LockType.X));
    }

    @Test
    @Category(PublicTests.class)
    public void testSubstitutableReal() {
        assertTrue(LockType.substitutable(LockType.S, LockType.S));
        assertTrue(LockType.substitutable(LockType.X, LockType.S));
        assertFalse(LockType.substitutable(LockType.IS, LockType.S));
        assertFalse(LockType.substitutable(LockType.IX, LockType.S));
        assertTrue(LockType.substitutable(LockType.SIX, LockType.S));
        assertFalse(LockType.substitutable(LockType.S, LockType.X));
        assertTrue(LockType.substitutable(LockType.X, LockType.X));
        assertFalse(LockType.substitutable(LockType.IS, LockType.X));
        assertFalse(LockType.substitutable(LockType.IX, LockType.X));
        assertFalse(LockType.substitutable(LockType.SIX, LockType.X));
    }

}

