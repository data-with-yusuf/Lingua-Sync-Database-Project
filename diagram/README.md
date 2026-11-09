# Diagrams

All diagrams describe the LinguaSync database (24 tables).

- `er_diagram_chen.png`: conceptual model in Chen notation.
- `relational_schema_crowsfoot.png`: tables, keys and relationships
  in Crow's Foot notation.
- `er_core_detail.png`: close-up of the core tables (optional,
  include only if you exported it).

## Reading Crow's Foot
Cover one table and read the symbol next to the other.
`||` exactly one, `|<` one or many, `O|` zero or one, `O<` zero or many.
A mandatory (NOT NULL) foreign key gives `||` on the parent side.
A nullable one gives `O|`.

For the full explanation, see `docs/notation_guide.md`.