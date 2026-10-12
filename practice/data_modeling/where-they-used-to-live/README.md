# Where They Used to Live

*They moved. The data stayed behind.*

[Data Modeling · Medium · on DataDriven](https://datadriven.io/problems/where_they_used_to_live)

## How it went

| | |
|---|---|
| Solved | 2026-10-12 |
| Accepted | on the first submission |
| Hints | none |
| Concepts | Constraints, Entities, Foreign Keys, Junction Tables, Many-to-Many, One-to-Many, Primary Keys, SCD Type 2, Surrogate Keys, 3NF |

## The design

```mermaid
erDiagram
    Customer_Address {
        INT cus_id FK
        INT Add_id FK
        DATE moved_on
        DATE moved_out
    }
    Address {
        INT id PK
        INT zipcode
        VARCHAR street
    }
    Customer {
        INT id PK
        VARCHAR name
    }
    Address only one optionally to zero or more Customer_Address : "Add_id = id"
    Customer only one optionally to zero or more Customer_Address : "cus_id = id"
```

The accepted design is in [`schema.sql`](./schema.sql) as DDL and in [`schema.json`](./schema.json) as JSON.
