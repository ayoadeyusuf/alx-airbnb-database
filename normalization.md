## User Table
- Primary key: user_id
- Attributes: first_name,last_name, email, password_hash, phone_number, role, created_at
### 3NF Compliance
- All attributes are atomic and functionally dependent on the primary key user_id.
- No transitive dependencies exist

## Property Table
- Primary Key: property_id
- Attributes: host_id (FK to User), name, description, location, pricepernight, created_at, updated_at
### 3NF Compliance:
- All attributes depend directly on property_id.
- host_id is a foreign key (valid dependency), and no transitive dependencies are present.

## Booking Table
- Primary Key: booking_id
- Attributes: property_id (FK to Property), user_id (FK to User), start_date, end_date, totalprice, status, created_at
### 3NF Compliance:
- All attributes are functionally dependent on booking_id.
- Foreign keys (property_id, user_id) reference primary keys of other tables, avoiding transitive dependencies.
## Payment Table
- Primary Key: payment_id
- Attributes: booking_id (FK to Booking), amount, payment_date, payment_method
### 3NF Compliance:
- All attributes depend solely on payment_id.

- booking_id is a foreign key with no transitive chain.

## Review Table
- Primary Key: review_id
- Attributes: property_id (FK to Property), user_id (FK to User), rating, comment, created_at
### 3NF Compliance:
- Attributes are fully dependent on review_id.
- Foreign keys (property_id, user_id) do not introduce dependencies outside the primary key.

## Message Table
- Primary Key: message_id
- Attributes: sender_id (FK to User), recipeint_id (FK to User), message_body, sent_at
### 3NF Compliance:
- All attributes depend directly on message_id.
- Foreign keys (sender_id, recipeint_id) reference valid primary keys without transitive dependencies.
