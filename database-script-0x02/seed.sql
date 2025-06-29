-- 1. Users
INSERT INTO users (first_name, last_name, email, password_hash, phone_number, role)
VALUES
('Adetola', 'Adeyeye', 'ade.tola@example.com', 'abcde', '+2345678900', 'host'),
('Adeyemi', 'Adesiyan', 'ade.siyan@example.com', 'fghij', '+2345678901', 'guest'),
('Adams', 'Ayoade', 'adams.ayoade@example.com', 'klmno', '+2345678902', 'guest'),
('Yaasir', 'Ibrahim', 'yaasir.ibrahim@example.com', 'pqrst', '+23456789303', 'host'),
('Yusuf', 'Ayoade', 'yus.ayoade@example.com', 'uvwxyz', '+2345678904', 'admin');

-- 2. Properties
INSERT INTO properties (host_id, name, description, location, price_per_night)
VALUES
(1, 'Maple Wood Estate', 'A lovely 2-bedroom apartment in the city center.', '123 GRA, Lagos', 75.00),
(1, 'Pent House', 'Spacious loft with great city views.', '456 Adelusi St, Ikoyi, Lagos', 180.00),
(4, 'Beachside Bungalow', 'Relaxing bungalow steps from the beach.', '789 Bar Beach Road, Lagos', 150.00);

-- 3. Bookings
INSERT INTO bookings (property_id, user_id, start_date, end_date, total_price, status)
VALUES
(1, 2, '2025-07-01', '2025-07-05', 300.00, 'confirmed'),
(2, 3, '2025-08-10', '2025-08-15', 600.00, 'pending'),
(3, 2, '2025-09-01', '2025-09-07', 1050.00, 'canceled');

-- 4. Payments
INSERT INTO payments (booking_id, amount, payment_method)
VALUES
(1, 300.00, 'Credit Card'),
(2, 600.00, 'PayPal');

-- 5. Reviews
INSERT INTO reviews (property_id, user_id, rating, comment)
VALUES
(1, 2, 5, 'Great location and very clean! Highly recommend.'),
(2, 3, 4, 'Nice loft but a bit noisy at night.');

-- 6. Messages
INSERT INTO messages (sender_id, recipient_id, message_body)
VALUES
(2, 1, 'Hi Adetola, is the apartment available for early check-in?'),
(1, 2, 'Hi Adeyemi, yes, early check-in is possible.'),
(3, 4, 'Hello Yaasir, can you provide more photos of the bungalow?'),
(4, 3, 'Hi Adams, I will upload more photos by tomorrow.');

