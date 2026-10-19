# The Last Mile

*Order placed. Now track it to the door.*

[Data Modeling · Medium · on DataDriven](https://datadriven.io/problems/the_last_mile)

## How it went

| | |
|---|---|
| Solved | 2026-10-19 |
| Accepted | on the first submission |
| Hints | none |
| Concepts | Attributes, Data Types, Dimension Tables, Entities, Fact Tables, Foreign Keys, Grain Definition, One-to-Many, Primary Keys, Snowflake Schema |

## The design

```mermaid
erDiagram
    dim_products {
        INT product_id PK
        VARCHAR name
        VARCHAR category
    }
    dim_packages {
        INT package_id PK
        TIMESTAMP time PK
        INT order_id FK
        unspecified location
        unspecified status
    }
    dim_customers {
        INT customer_id PK
        VARCHAR Fname
        VARCHAR Lname
        INT age
    }
    dim_date {
        INT datekey PK
        INT year
        INT month
        INT day
    }
    fact_orders {
        INT order_id PK
        INT package_id FK
        unspecified customer_id FK
        INT product_id FK
        INT datekey FK
        DECIMAL price
        INT quantitiy
        DECIMAL total_sale
        VARCHAR status
    }
    dim_packages only one optionally to zero or more fact_orders : "package_id"
    fact_orders only one optionally to only one dim_packages : "order_id"
    fact_orders only one to zero or more dim_customers : "customer_id"
    fact_orders only one to zero or more dim_products : "product_id"
    dim_date only one optionally to zero or more fact_orders : "datekey"
```

The accepted design is in [`schema.sql`](./schema.sql) as DDL and in [`schema.json`](./schema.json) as JSON.
