-- INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT
    bookings.booking_id,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status,
    users.user_id,
    users.first_name,
    users.last_name,
    users.email
FROM
    bookings
INNER JOIN users ON bookings.user_id = users.user_id;

-- LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT
    properties.property_id,
    properties.name AS property_name,
    properties.description,
    properties.location,
    reviews.review_id,
    reviews.user_id AS reviewer_id,
    reviews.rating,
    reviews.comment
FROM
    properties
LEFT JOIN reviews ON properties.property_id = reviews.property_id
ORDER BY
    properties.property_id;

-- FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    bookings.booking_id,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date,
    bookings.total_price,
    bookings.status
FROM
    users
FULL OUTER JOIN bookings ON users.user_id = bookings.user_id;
