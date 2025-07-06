-- 1. Rename existing bookings table to keep data safe
ALTER TABLE bookings RENAME TO bookings_old;

-- 2. Create new partitioned bookings table
CREATE TABLE bookings (
    booking_id      SERIAL PRIMARY KEY,
    property_id     INTEGER NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
    user_id         INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    total_price     NUMERIC(10,2) NOT NULL CHECK (total_price >= 0),
    status          VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Creating partitions (by year)
CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Migrating data from old table
INSERT INTO bookings
SELECT * FROM bookings_old;

-- Dropping old table 
DROP TABLE bookings_old;

-- Creating individual indices on each partition
CREATE INDEX idx_bookings_2023_user_id ON bookings_2023(user_id);
CREATE INDEX idx_bookings_2023_property_id ON bookings_2023(property_id);

CREATE INDEX idx_bookings_2024_user_id ON bookings_2024(user_id);
CREATE INDEX idx_bookings_2024_property_id ON bookings_2024(property_id);

CREATE INDEX idx_bookings_2025_user_id ON bookings_2025(user_id);
CREATE INDEX idx_bookings_2025_property_id ON bookings_2025(property_id);



