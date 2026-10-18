# A Number for the Seller

*They want a total. Give them the right schema first.*

[Data Modeling · Easy · on DataDriven](https://datadriven.io/problems/a_number_for_the_seller)

## How it went

| | |
|---|---|
| Solved | 2026-10-18 |
| Accepted | on the 2nd submission |
| Hints | none |
| Concepts | Attributes, Dimension Tables, Fact Tables, Foreign Keys, Grain Definition, Metric Additivity, One-to-Many, Pre-Aggregation, Primary Keys, Star Schema, Surrogate Keys |

## The design

```mermaid
erDiagram
    Sellers {
        INT seller_id PK
        VARCHAR first_name
        VARCHAR last_name
        INT age
        VARCHAR location
    }
    Products {
        INT product_id PK
        TEXT user_id FK
        VARCHAR status
        TIMESTAMP publish_date
    }
    Sales {
        INT sale_id PK
        INT product_id PK
        INT seller_id FK
        DECIMAL price
        INT quantity
        DECIMAL total_price
        DECIMAL discount
        DECIMAL revenue
        TIMESTAMP occur_at
    }
    Products only one to zero or more Sellers : "seller_id = user_id"
    Products only one to only one Sales : "product_id"
    Sellers only one optionally to only one Sales : "seller_id"
```

The accepted design is in [`schema.sql`](./schema.sql) as DDL and in [`schema.json`](./schema.json) as JSON.
