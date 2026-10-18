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
    fact_sales {
        INT order_id PK
        INT product_id FK
        INT seller_id FK
        INT date_key FK
        DECIMAL price
        INT quantity
        DECIMAL gross_revenue
    }
    dim_date {
        INT date_key PK
        INT month
        INT day
        INT year
    }
    dim_products {
        INT product_id PK
        INT seller_id FK
        VARCHAR product_name
        TIMESTAMP listied_at
        BOOLEAN is_active
    }
    dim_sellers {
        INT seller_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR Country
        unspecified joined_at
    }
    dim_date only one optionally to zero or more fact_sales : "date_key"
    fact_sales only one to zero or more dim_sellers : "seller_id"
    dim_products only one to zero or more dim_sellers : "seller_id"
    dim_products only one optionally to zero or more fact_sales : "product_id"
```

The accepted design is in [`schema.sql`](./schema.sql) as DDL and in [`schema.json`](./schema.json) as JSON.
