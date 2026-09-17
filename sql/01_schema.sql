-- =====================================================================
-- PIZZA SALES DATABASE - ORACLE SQL SCHEMA
-- Database Engineering Lab Project
-- =====================================================================
-- Run this script first in SQL*Plus / SQL Developer to create the
-- schema, then run 02_load_data.sql to load data via SQL*Loader/CSV,
-- then run 03_queries.sql for the analysis.
-- =====================================================================

-- Drop tables if they already exist (child tables first, FK order)
DROP TABLE order_details CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE pizzas CASCADE CONSTRAINTS;
DROP TABLE pizza_types CASCADE CONSTRAINTS;

-- ---------------------------------------------------------------------
-- Table: pizza_types
-- ---------------------------------------------------------------------
CREATE TABLE pizza_types (
    pizza_type_id   VARCHAR2(30)   PRIMARY KEY,
    name            VARCHAR2(60)   NOT NULL,
    category        VARCHAR2(20)   NOT NULL
);

-- ---------------------------------------------------------------------
-- Table: pizzas
-- ---------------------------------------------------------------------
CREATE TABLE pizzas (
    pizza_id        VARCHAR2(30)   PRIMARY KEY,
    pizza_type_id   VARCHAR2(30)   NOT NULL,
    size            VARCHAR2(5)    NOT NULL,
    price           NUMBER(6,2)    NOT NULL,
    CONSTRAINT fk_pizzas_type FOREIGN KEY (pizza_type_id)
        REFERENCES pizza_types (pizza_type_id)
);

-- ---------------------------------------------------------------------
-- Table: orders
-- ---------------------------------------------------------------------
CREATE TABLE orders (
    order_id        NUMBER          PRIMARY KEY,
    order_date      DATE            NOT NULL,
    order_time      DATE            NOT NULL   -- time-only value stored in DATE (Oracle has no pure TIME type)
);

-- ---------------------------------------------------------------------
-- Table: order_details
-- ---------------------------------------------------------------------
CREATE TABLE order_details (
    order_details_id  NUMBER        PRIMARY KEY,
    order_id          NUMBER        NOT NULL,
    pizza_id          VARCHAR2(30)  NOT NULL,
    quantity          NUMBER        NOT NULL,
    CONSTRAINT fk_od_order FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT fk_od_pizza FOREIGN KEY (pizza_id)
        REFERENCES pizzas (pizza_id)
);

-- Helpful indexes for join-heavy analytics
CREATE INDEX idx_od_order_id ON order_details(order_id);
CREATE INDEX idx_od_pizza_id ON order_details(pizza_id);
CREATE INDEX idx_pizzas_type_id ON pizzas(pizza_type_id);

COMMIT;
