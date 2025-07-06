# Optimization Report

## Overview

This report summarizes the analysis and optimization recommendations for key SQL queries involving the **users**, 
**bookings**, **properties**, **payments**, and related tables in the property rental platform database. 
The focus is on improving query performance through indexing, query refactoring, and efficient join strategies.

---

## Identified High-Usage Columns for Indexing

Based on query patterns involving `WHERE`, `JOIN`, and `ORDER BY` clauses, the following columns are critical for indexing:

| Table      | Columns for Indexing                       | Purpose                             |
|------------|-------------------------------------------|-----------------------------------|
| users      | `user_id` (PK), `email`, `role`           | Fast user lookups and filtering   |
| bookings   | `booking_id` (PK), `user_id`, `property_id`, `status`, `(start_date, end_date)` | Efficient joins, filtering, and date range queries |
| properties | `property_id` (PK), `host_id`, `location`, `price_per_night` | Quick property searches and joins |
| payments   | `payment_id` (PK), `booking_id`            | Efficient payment lookups          |

**Indexes Created:**

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_start_end_date ON bookings(start_date, end_date);

CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price_per_night);

CREATE INDEX idx_payments_booking_id ON payments(booking_id);


---

## Query Optimization Examples

### a) Retrieving Bookings with User, Property, and Payment Details

**Initial Query:**

- Joins `bookings`, `users`, `properties`, and `payments` tables without filters.
- Potentially scans large data volumes causing slow performance.

**Performance Analysis:**

- `EXPLAIN ANALYZE` showed sequential scans and nested loop joins on large tables.
- High execution time due to lack of indexes on join columns.

**Optimizations:**

- Added indexes on `bookings.user_id`, `bookings.property_id`, and `payments.booking_id`.
- Refactored query to filter on `bookings.status = 'confirmed'` and limited results with `ORDER BY start_date DESC LIMIT 100`.
- Created composite index on `(status, start_date DESC)` for efficient filtering and sorting.

**Refactored Query:**

SELECT
b.booking_id, b.start_date, b.end_date, b.total_price, b.status,
u.user_id, u.first_name, u.last_name, u.email,
p.property_id, p.name AS property_name, p.location, p.price_per_night,
pay.payment_id, pay.amount, pay.payment_date, pay.payment_method
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed'
ORDER BY b.start_date DESC
LIMIT 100;


### b) Queries with Aggregations and Joins

- Used `GROUP BY` and `HAVING` clauses to find properties with average rating > 4.0.
- Applied correlated subqueries to find users with more than 3 bookings.
- Used window functions (`RANK()`) to rank properties by booking counts.

**Indexes on join and filter columns** significantly improved aggregation and ranking query performance.

---

## Output Insights

- Before indexing, queries performed **sequential scans** on large tables, causing high execution times
- After indexing, queries used **index scans**, reducing execution time drastically
- Join methods improved from nested loops on large datasets to efficient hash or merge joins.
- Filtering and ordering benefited from composite indexes.

---
