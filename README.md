code .# 🍕 Pizza Sales — Oracle SQL Database Engineering Project

A Database Engineering Lab project that analyzes pizza sales and order data using Oracle SQL.

This project demonstrates relational database design, data loading, SQL querying, joins, aggregation, subqueries, and advanced analytical functions.

---

## 📌 Project Objective

The objective of this project is to design and implement a relational database using Oracle Database and perform SQL-based analysis on pizza sales data.

The project uses four related tables:

- pizza_types
- pizzas
- orders
- order_details

The database stores pizza information, pizza variants, customer orders, order details, quantities, and prices.

The project performs 13 analytical SQL queries divided into:

- Basic Analysis
- Intermediate Analysis
- Advanced Analysis

---

## 🗄️ Database Schema

The database consists of four tables.

### 1. pizza_types

Stores information about different types of pizzas.

| Column | Description |
|---|---|
| pizza_type_id | Unique identifier for each pizza type |
| name | Name of the pizza |
| category | Pizza category |

Categories include:

- Classic
- Chicken
- Supreme
- Veggie

---

### 2. pizzas

Stores different pizza variants based on pizza type and size.

| Column | Description |
|---|---|
| pizza_id | Unique identifier for each pizza variant |
| pizza_type_id | Foreign key referencing pizza_types |
| size | Size of the pizza |
| price | Price of the pizza |

A single pizza type can have multiple sizes and prices.

---

### 3. orders

Stores information about customer orders.

| Column | Description |
|---|---|
| order_id | Unique identifier for each order |
| order_date | Date on which the order was placed |
| order_time | Time at which the order was placed |

---

### 4. order_details

Stores the individual pizza items included in each order.

| Column | Description |
|---|---|
| order_details_id | Unique identifier for each order-detail record |
| order_id | Foreign key referencing orders |
| pizza_id | Foreign key referencing pizzas |
| quantity | Number of pizzas ordered |

---

## 🔗 Entity Relationships

pizza_types
     |
     | 1 : Many
     v
pizzas
     |
     | 1 : Many
     v
order_details
     ^
     | Many : 1
     |
orders

### Relationship Explanation

pizza_types → pizzas

One pizza type can have multiple pizza variants.

pizzas → order_details

One pizza variant can appear in multiple order-detail records.

orders → order_details

One order can contain multiple order-detail records.

---

## 🔑 Keys and Constraints

### Primary Keys

The following columns are primary keys:

- pizza_types.pizza_type_id
- pizzas.pizza_id
- orders.order_id
- order_details.order_details_id

A primary key uniquely identifies each record in a table.

### Foreign Keys

The following foreign-key relationships are used:

pizzas.pizza_type_id
        ↓
pizza_types.pizza_type_id

order_details.order_id
        ↓
orders.order_id

order_details.pizza_id
        ↓
pizzas.pizza_id

Foreign keys maintain referential integrity between related tables.

---

## 📊 Dataset

| Table | Number of Records |
|---|---:|
| pizza_types | 32 |
| pizzas | 96 |
| orders | 21,350 |
| order_details | 48,620 |

The dataset contains 49,574 pizzas ordered in total.

---

## 🛠️ Technologies Used

- Oracle Database
- Oracle SQL
- Oracle SQL Developer
- SQL*Plus
- SQL*Loader
- Git
- GitHub
- CSV Dataset

---

## 📁 Project Structure

pizza-sales-oracle/
|
├── data/
│   ├── order_details.csv
│   ├── orders.csv
│   ├── pizza_types.csv
│   └── pizzas.csv
|
├── loader/
│   ├── loader_order_details.ctl
│   ├── loader_orders.ctl
│   ├── loader_pizza_types.ctl
│   └── loader_pizzas.ctl
|
├── sql/
│   ├── 01_schema.sql
│   ├── 02_load_pizza_types.sql
│   ├── 02_load_pizzas.sql
│   ├── 02_load_orders.sql
│   ├── 02_load_order_details.sql
│   └── 03_queries.sql
|
├── .gitattributes
├── .gitignore
└── README.md

---

# ▶️ How to Run the Project

## Method 1 — Oracle SQL Developer / SQL*Plus

Run the SQL scripts in the following order.

### Step 1 — Create the database schema

@sql/01_schema.sql

### Step 2 — Load pizza types

@sql/02_load_pizza_types.sql

### Step 3 — Load pizzas

@sql/02_load_pizzas.sql

### Step 4 — Load orders

@sql/02_load_orders.sql

### Step 5 — Load order details

@sql/02_load_order_details.sql

### Step 6 — Run analytical queries

@sql/03_queries.sql

### Important

The schema should be created before loading the data because the database contains primary-key and foreign-key constraints.

---

# 📥 SQL*Loader Method

If bulk data loading is required, SQL*Loader control files are provided in the loader/ directory.

First create the database schema:

@sql/01_schema.sql

Then run:

cd data

Load the data using:

sqlldr userid=USER/PASS@DB control=../loader/loader_pizza_types.ctl skip=1

sqlldr userid=USER/PASS@DB control=../loader/loader_pizzas.ctl skip=1

sqlldr userid=USER/PASS@DB control=../loader/loader_orders.ctl skip=1

sqlldr userid=USER/PASS@DB control=../loader/loader_order_details.ctl skip=1

Replace USER/PASS@DB with the appropriate Oracle database credentials.

---

# 🔎 SQL Analysis

The project contains 13 analytical SQL queries divided into three levels.

---

## 🟢 Basic Analysis

### Query 1 — Total Number of Orders

Determines the total number of orders placed.

Concepts used:

- COUNT()
- SELECT

---

### Query 2 — Total Revenue

Calculates the total revenue generated from pizza sales.

Revenue is calculated using:

Revenue = Quantity × Pizza Price

Concepts used:

- SUM()
- JOIN
- Arithmetic operations

---

### Query 3 — Highest-Priced Pizza

Identifies the pizza with the highest price.

Concepts used:

- JOIN
- ORDER BY
- FETCH FIRST

---

### Query 4 — Most Commonly Ordered Pizza Size

Determines which pizza size has the highest total quantity ordered.

Concepts used:

- JOIN
- GROUP BY
- SUM()
- ORDER BY

---

### Query 5 — Top Five Most Ordered Pizza Types

Identifies the five pizza types with the highest total quantity ordered.

Concepts used:

- Multiple JOINs
- GROUP BY
- SUM()
- ORDER BY
- FETCH FIRST

---

# 🟡 Intermediate Analysis

### Query 6 — Quantity Ordered by Category

Calculates the total quantity of pizzas ordered for each pizza category.

Concepts used:

- Multiple JOINs
- GROUP BY
- SUM()

---

### Query 7 — Orders by Hour

Analyzes the distribution of orders based on the hour of the day.

Oracle extracts the hour using:

TO_CHAR(order_time, 'HH24')

Concepts used:

- TO_CHAR()
- GROUP BY
- COUNT()
- Date/time analysis

---

### Query 8 — Pizza Variants by Category

Determines the number of pizza variants available in each category.

Concepts used:

- JOIN
- COUNT()
- GROUP BY

---

### Query 9 — Average Pizzas Ordered Per Day

Calculates the average number of pizzas ordered per day.

Concepts used:

- Subquery
- GROUP BY
- SUM()
- AVG()

---

### Query 10 — Top Three Pizza Types by Revenue

Identifies the three pizza types generating the highest revenue.

Revenue is calculated as:

Quantity × Price

Concepts used:

- Multiple JOINs
- SUM()
- GROUP BY
- ORDER BY
- FETCH FIRST

---

# 🔴 Advanced Analysis

### Query 11 — Revenue Contribution by Category

Calculates the percentage contribution of each pizza category to total revenue.

The query uses a window aggregate to calculate total revenue across all categories.

Example concept:

SUM(SUM(revenue)) OVER ()

Concepts used:

- Aggregate functions
- Window functions
- SUM() OVER()
- Percentage calculation

---

### Query 12 — Cumulative Revenue Over Time

Calculates running cumulative revenue based on order date.

The query uses:

SUM(daily_revenue) OVER (
    ORDER BY order_date
)

This produces a running total of revenue.

Concepts used:

- Window functions
- SUM() OVER()
- ORDER BY
- Date-based analysis

---

### Query 13 — Top Three Pizza Types by Revenue Within Each Category

Identifies the top three revenue-generating pizza types within each pizza category.

The query uses:

RANK() OVER (
    PARTITION BY category
    ORDER BY revenue DESC
)

Concepts used:

- Window functions
- RANK()
- PARTITION BY
- ORDER BY
- Multiple JOINs
- Aggregation

---

# 📈 Key Results

The project dataset contains:

| Metric | Result |
|---|---:|
| Total Orders | 21,350 |
| Total Pizza Quantity | 49,574 |
| Total Revenue | $817,860.05 |
| Pizza Types | 32 |
| Pizza Variants | 96 |
| Order Details | 48,620 |
| Average Pizzas per Day | 138.47 |

---

# 💰 Revenue by Pizza Category

| Category | Revenue | Percentage |
|---|---:|---:|
| Classic | $220,053.10 | 26.91% |
| Supreme | $208,197.00 | 25.46% |
| Chicken | $195,919.50 | 23.96% |
| Veggie | $193,690.45 | 23.68% |

---

# 🍕 Top Pizza Types by Revenue

| Pizza Type | Revenue |
|---|---:|
| The Thai Chicken Pizza | $43,434.25 |
| The Barbecue Chicken Pizza | $42,768.00 |
| The California Chicken Pizza | $41,409.50 |

---

# 🎓 Database Concepts Demonstrated

This project demonstrates practical knowledge of:

- DDL
- DML
- Primary Keys
- Foreign Keys
- Referential Integrity
- Constraints
- Relational Database Design
- Normalization
- SELECT
- WHERE
- JOIN
- GROUP BY
- ORDER BY
- Aggregate Functions
- COUNT()
- SUM()
- AVG()
- Subqueries
- Window Functions
- RANK()
- PARTITION BY
- FETCH FIRST
- Date and Time Functions
- SQL*Loader
- Indexes

---

# 🎯 Learning Outcomes

Through this project, the following skills were practiced:

1. Designing relational database tables.
2. Creating primary-key and foreign-key relationships.
3. Maintaining referential integrity.
4. Loading structured CSV data into Oracle Database.
5. Writing SQL queries for data analysis.
6. Combining data from multiple tables using joins.
7. Performing aggregation using SQL functions.
8. Grouping and sorting analytical results.
9. Using subqueries for multi-step analysis.
10. Using window functions for advanced analytics.
11. Performing revenue analysis.
12. Performing time-based order analysis.
13. Using SQL*Loader for bulk data loading.

---

# 👨‍💻 Project Information

Project Title: Pizza Sales — Oracle SQL Database Engineering Project

Domain: Sales and Food Ordering Analytics

Database: Oracle Database

Language: SQL

Number of Tables: 4

Number of Analytical Queries: 13

Repository: GitHub

---

# 📜 License

This project is intended for academic and educational purposes.