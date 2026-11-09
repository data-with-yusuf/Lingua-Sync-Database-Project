# Run Order

Run in this order. Order matters.

1. Create a database and connect to it:

   ```sql
   CREATE DATABASE linguasync;
   ```

2. Run the schema: `linguasync_schema.sql`
   (or the numbered files 01 to 07 in order).
   This creates the tables, then triggers and functions, then
   indexes, then views.
3. Run the demo data in `sql/demo_data/`, files 01 to 09 in order.
4. Optionally run the tests in `sql/tests/`.

## Why this order

- Triggers must exist before data is loaded, so that automatic
  behaviour (timestamps, assignment status) applies to the demo rows.
- Views read from tables, so the tables must exist first.
- Reference data is loaded before data that points to it, because of
  foreign keys.

## Check after loading

```sql
SELECT COUNT(*) FROM pg_tables  WHERE schemaname = 'public'; -- 24
SELECT COUNT(*) FROM pg_views   WHERE schemaname = 'public'; -- 19
SELECT COUNT(*) FROM pg_indexes WHERE schemaname = 'public'; -- 66
SELECT COUNT(*) FROM pg_trigger WHERE NOT tgisinternal;      -- 35
```

Expected demo rows: 687 across all 24 tables (51 languages,
60 projects, 53 assignments, 53 work records, 60 invoices,
40 payments).