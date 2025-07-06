-- Finding all properties where the average rating is greater than 4.0
SELECT
    p.property_id,
    p.name,
    AVG(r.rating) AS avg_rating
FROM
    properties p
JOIN
    reviews r ON p.property_id = r.property_id
GROUP BY
    p.property_id, p.name
HAVING
    AVG(r.rating) > 4.0;

-- Finding users who have made more than 3 bookings.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    (
        SELECT COUNT(*)
        FROM bookings b
        WHERE b.user_id = u.user_id
    ) AS booking_count
FROM
    users u
WHERE
    (
        SELECT COUNT(*)
        FROM bookings b
        WHERE b.user_id = u.user_id
    ) > 3;

