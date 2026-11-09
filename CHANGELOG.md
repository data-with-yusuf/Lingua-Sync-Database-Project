# Changelog

## v1.1 (verification release)
- Verified all object counts against the live database:
  24 tables, 176 columns, 36 foreign keys, 25 CHECK constraints,
  14 UNIQUE constraints, 66 indexes, 35 triggers (11 functions),
  19 views, 687 demo rows.
- Rebuilt the data dictionary from the actual schema.
- Reconciled financial totals: 12,027.40 received, 7,951.30 paid out,
  margin 4,076.10.
- Confirmed the repository rebuilds on a blank database with no errors.

## v1.0 (initial build)
- Designed the schema (ER model, functional dependencies, BCNF).
- Implemented tables, constraints, triggers, indexes and views.
- Loaded fictional demo data and ran 53 verification tests.
