# Pizza Sales — Oracle SQL Database Engineering Project

Analysis of Pizza Hut order data using Oracle SQL: schema design,
data loading, and 13 analytical queries (Basic / Intermediate / Advanced).

## Structure
```
sql/
  01_schema.sql              -- DDL: 4 tables, PK/FK constraints, indexes
  02_load_pizza_types.sql    -- INSERTs for pizza_types (32 rows)
  02_load_pizzas.sql         -- INSERTs for pizzas (96 rows)
  02_load_orders.sql         -- INSERTs for orders (21,350 rows)
  02_load_order_details.sql -- INSERTs for order_details (48,620 rows)
  03_queries.sql              -- all 13 analysis queries
loader/
  loader_*.ctl                -- SQL*Loader control files (bulk-load alternative)
data/
  *.csv                       -- source data
```

## Run order (SQL Developer / SQL*Plus)
```sql
@sql/01_schema.sql
@sql/02_load_pizza_types.sql
@sql/02_load_pizzas.sql
@sql/02_load_orders.sql
@sql/02_load_order_details.sql
@sql/03_queries.sql
```

## Run order (SQL*Loader, if your lab requires sqlldr)
```bash
cd data
sqlldr userid=USER/PASS@DB control=../loader/loader_pizza_types.ctl   skip=1
sqlldr userid=USER/PASS@DB control=../loader/loader_pizzas.ctl        skip=1
sqlldr userid=USER/PASS@DB control=../loader/loader_orders.ctl        skip=1
sqlldr userid=USER/PASS@DB control=../loader/loader_order_details.ctl skip=1
```
Run `sql/01_schema.sql` first regardless of load method.

## Notes on Oracle-specific syntax
- `LIMIT n` → `FETCH FIRST n ROWS ONLY`
- `HOUR(time)` → `TO_CHAR(order_time, 'HH24')`
- No native `TIME` type — order time stored in a `DATE` column (date part is a dummy value, ignore it)
- Percentage-of-revenue query uses `SUM(x) OVER ()` window aggregate

## Data
| Table | Rows |
|---|---|
| pizza_types | 32 |
| pizzas | 96 |
| orders | 21,350 |
| order_details | 48,620 |
