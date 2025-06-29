-- 1. User Table
CREATE TABLE users (
    user_id         SERIAL PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100) NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    phone_number    VARCHAR(20),
    role            ENUM ('guest', 'host', 'admin') NOT NULL CHECK (role IN ('host', 'guest', 'admin')),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Unique constraint
    CONSTRAINT unique_email UNIQUE (email)
);

-- 2. Property Table
CREATE TABLE properties (
    property_id     SERIAL PRIMARY KEY,
    host_id         INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    name            VARCHAR(100) NOT NULL,
    description     TEXT NOT NULL,
    location        VARCHAR(255) NOT NULL,
    price_per_night DECIMAL NOT NULL CHECK (price_per_night >= 0),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- 3. Booking Table
CREATE TABLE bookings (
    booking_id      SERIAL PRIMARY KEY,
    property_id     INTEGER NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
    user_id         INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    total_price     DECIMAL NOT NULL CHECK (total_price >= 0),
    status          ENUM('pending', 'confirmed', 'canceled') NOT NULL 
        CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 4. Payment Table
CREATE TABLE payments (
    payment_id      SERIAL PRIMARY KEY,
    booking_id      INTEGER NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    amount          DECIMAL NOT NULL CHECK (amount >= 0),
    payment_date    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method  ENUM ('credit_card', 'paypal, stripe') NOT NULL
);

-- 5. Review Table
CREATE TABLE reviews (
    review_id       SERIAL PRIMARY KEY,
    property_id     INTEGER NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
    user_id         INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    rating          INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment         TEXT NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 6. Message Table
CREATE TABLE messages (
    message_id      SERIAL PRIMARY KEY,
    sender_id       INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    recipient_id    INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    message_body    TEXT NOT NULL,
    sent_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Additional Indexes
-- Email index for users
CREATE INDEX idx_users_email ON users(email);

-- Property ID indexes
CREATE INDEX idx_properties_property_id ON properties(property_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Booking ID indexes
CREATE INDEX idx_bookings_booking_id ON bookings(booking_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);








