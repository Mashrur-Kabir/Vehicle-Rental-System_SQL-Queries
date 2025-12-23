-- Creating Table:
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'customer')),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password TEXT,
    phone VARCHAR(20)
);

CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
    model VARCHAR(50),
    registration_number VARCHAR(50) UNIQUE NOT NULL,
    rental_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('available', 'rented', 'maintenance'))
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    vehicle_id INT NOT NULL REFERENCES vehicles(vehicle_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled')),
    total_cost DECIMAL(10,2) NOT NULL
);

-- Data Insertion:
INSERT INTO users (name, email, phone, role) VALUES
('Alice', 'alice@example.com', '1234567890', 'customer'),
('Bob', 'bob@example.com', '0987654321', 'admin'),
('Charlie', 'charlie@example.com', '1122334455', 'customer');


INSERT INTO vehicles (name, type, model, registration_number, rental_price, status) VALUES
('Toyota Corolla', 'car', '2022', 'ABC-123', 50, 'available'),
('Honda Civic', 'car', '2021', 'DEF-456', 60, 'rented'),
('Yamaha R15', 'bike', '2023', 'GHI-789', 30, 'available'),
('Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');


INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100);


-- Query 1: JOIN:
select booking_id, usr.name as customer_name, vcl.name as vehicle_name, start_date, end_date, bk.status as status from bookings as bk
  join users as usr using(user_id)
  join vehicles as vcl using(vehicle_id);
  

-- Query 2: EXISTS:
select vehicle_id, name, type, model, registration_number, round(vcl.rental_price) as rental_price, status
  from vehicles as vcl
  where not exists(
    select 1 from bookings as b
    where b.vehicle_id = vcl.vehicle_id
  )
  order by vehicle_id asc;


--- Query 3: WHERE
select vehicle_id, name, type, model, registration_number, round(rental_price) as rental_price, status
  from vehicles
where type = 'car' and status = 'available';


--- Query 4: GROUP BY and HAVING
select vcl.name as vehicle_name, count(*) as total_bookings from bookings as bk
  join vehicles as vcl on vcl.vehicle_id = bk.vehicle_id
  group by vcl.name
  having count(*) > 2;
