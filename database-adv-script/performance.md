# Partitioning Performance Report

## Observed Improvements

- **Query Performance:**  
  Queries filtering on `start_date` (e.g., bookings within a specific month or year) showed **significant reduction in execution time**.  
  - Before partitioning, queries performed **sequential scans** on the entire bookings table, resulting in high I/O and CPU usage.  
  - After partitioning, the query planner limited scans to **only the relevant partitions**
    (e.g., the 2024 partition for queries on 2024 dates), drastically reducing the number of rows scanned.
