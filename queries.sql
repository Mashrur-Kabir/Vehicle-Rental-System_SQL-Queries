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
