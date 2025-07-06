## SQL Query for perfomance
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = 123 AND status = 'confirmed';

## Index Perfomance before indexing
- Seq Scan on bookings (cost=0.00..1.04 rows=1 width=118) (actual time=0.024..0.024 rows=0 loops=1)
- Filter: ((user_id = 123) AND ((status)::text = 'confirmed'::text))
- Rows Removed by Filter: 3
- Planning Time: 1.108 ms
- Execution Time: 0.078 ms
## Query for Indexing
CREATE INDEX idx_bookings_user_status ON bookings(user_id, status);

## Index Performance After Indexing
- Seq Scan on bookings (cost=0.00..1.04 rows=1 width=118) (actual time=0.019..0.019 rows=0 loops=1)
- Filter: ((user_id = 123) AND ((status)::text = 'confirmed'::text))
- Rows Removed by Filter: 3
- Planning Time: 1.005 ms
- Execution Time: 0.041 ms
