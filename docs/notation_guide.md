# Notation Guide

LinguaSync uses two diagram styles: Chen notation for the conceptual
model, and Crow's Foot for the relational schema.

## 1. Chen notation (conceptual model)

| Symbol | Meaning |
|---|---|
| Rectangle | Entity, such as COLLABORATOR |
| Oval | Attribute |
| Underlined attribute | Primary key |
| Diamond | Relationship, such as "Is Assigned To" |
| Attribute on a diamond | Attribute of the relationship |
| Lines labelled 1 and N | Cardinality |

Example: proficiency level belongs to the relationship between
collaborator and language, so it became its own table,
`collaborator_skill`.

Some entities connect to the same entity twice, for example
LANGUAGE to LANGUAGE_PAIR as source and as target. Each role has its
own diamond.

## 2. Crow's Foot notation (relational schema)

Each end of a line describes the table at that end.

| Symbol | Meaning |
|---|---|
| `\|\|` | Exactly one (mandatory) |
| `\|<` | One or many (mandatory) |
| `O\|` | Zero or one (optional) |
| `O<` | Zero or many (optional) |

**How to read a line:** cover one table with your hand and read the
symbol next to the other table. That tells you how many of the
uncovered table relate to one row of the covered one.

Example:

```
agency  ||----O<  translation_project
```

- Each project belongs to exactly one agency.
- An agency can have zero or many projects.

## 3. Deciding the symbols

1. Look at the foreign key column on the child table.
2. NOT NULL foreign key: the parent end is `||`.
3. Nullable foreign key: the parent end is `O|`.
4. A parent can usually have many children: the child end is `O<`.
5. Use `|<` only when the business requires at least one child **and**
   it is meant to be shown. The database itself does not enforce a
   minimum number of children.

## 4. The three optional lines

Only three of the 36 relationships have a nullable foreign key:

| Child column | Parent | Why optional |
|---|---|---|
| communication_log.manager_sender_id | project_manager | Only filled when a manager sent the message |
| communication_log.collaborator_sender_id | collaborator | Only filled when a collaborator sent it |
| revision_log.resolved_record_id | work_record | Empty until the revision is resolved |

These three show `O|` at the parent end. Every other line shows `||`.

## 5. Tables with two lines to the same table

| Child | Parent | Columns |
|---|---|---|
| language_pair | language | source_language_id, target_language_id |
| exchange_rate | currency | from_currency_id, to_currency_id |
| revision_log | work_record | record_id, resolved_record_id |

Draw one line per column, and use two aliases when querying.

## 6. Junction tables

`project_pair`, `account_pair` and `collaborator_skill` have composite
primary keys made of their two foreign keys, so they have no
surrogate id. Each shows two lines, one to each parent.

## 7. Naming used in the diagrams

Tables are lower case with underscores, matching the database, for
example `translation_project`, `billing_unit`, `manager_role`,
`platform_account`, `project_assignment`, `project_pair`,
`account_pair` and `collaborator_skill`. Relationship labels in the
Chen diagram include Is Assigned To, Has Assignment, Used In, Assigns,
Generates, Has Skill In and Denominated In.

## 8. Checking a diagram

- Every one of the 36 foreign keys has a line.
- Parent end symbols follow the nullable rule above.
- Table and column names match `data_dictionary.md`.