---
# Vehicle Rental System: SQL Queries Explanation

This project implements a simple **Vehicle Rental System** using SQL.
It includes database creation, data insertion, and multiple queries based on given requirements.
---

## Database Schema

The database contains three tables:

- **users** – stores customer and admin information
- **vehicles** – stores vehicle details and availability
- **bookings** – stores rental records linking users and vehicles

Relationships:

- One user can have many bookings
- One vehicle can have many bookings
- Each booking belongs to one user and one vehicle

---

---

## Query 1: Retrieve Booking Information Using JOIN

### Concept:

- `INNER JOIN`

Join the **bookings**, **users**, and **vehicles** tables using their foreign keys. The `user_id` links bookings to users, and the `vehicle_id` links bookings to vehicles.

By using `INNER JOIN`, the query returns complete booking details that are required in the example output

---

## Query 2: Find Vehicles That Have Never Been Booked

### Concept:

- `NOT EXISTS`

This query checks each vehicle and looks for a matching record in the **bookings** table. If no booking exists for a vehicle, it means the vehicle has never been rented.

The `NOT EXISTS` condition ensures that only vehicles without any bookings are returned. For 1 vehicle_id, subquery checks it agiainst all the booking_id to see if it matches (exists in bookings) or not (like a search loop)

---

## Query 3: Retrieve Available Vehicles of a Specific Type

### Concept:

- `SELECT`
- `WHERE`

This query filters the **vehicles** table using the `WHERE` clause that checks two things:

(1). The vehicle type is `car`
(2). The vehicle status is `available`

`and` operator ensures only vehicles that satisfy both conditions are displayed.

---

## Query 4: Find Vehicles With More Than 2 Bookings

### Concept:

- `GROUP BY`
- `HAVING`
- `COUNT`

'Group By' creates a pile for every unique value of the column mentioned. This query groups booking records by vehicle name and uses the aggregate `count` function to find how many times each vehicle appears in the bookings table. Then `HAVING` filters the results based on a condition to show only vehicles with more than two bookings.

---
