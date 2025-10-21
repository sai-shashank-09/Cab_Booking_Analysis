use cab_bookings;
show tables;
describe uber_rides;
select * from uber_rides;


-- Identify customers who have completed the most bookings
SELECT customer_id, COUNT(*) AS completed_bookings
FROM uber_rides
WHERE booking_status = 'Completed'
GROUP BY customer_id
ORDER BY completed_bookings DESC;


-- Find customers who have canceled more than 30% of their total bookings
SELECT Customer_ID, COUNT(*) AS Total_Rides, SUM(CASE WHEN Booking_Status LIKE 'Cancelled%' THEN 1 ELSE 0 END) AS Cancelled_Rides,
ROUND((SUM(CASE WHEN Booking_Status LIKE 'Cancelled%' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Cancel_Percentage
FROM uber_rides
GROUP BY Customer_ID
HAVING Cancel_Percentage > 30
ORDER BY Cancel_Percentage DESC;


-- Determine the busiest day of the week for bookings.
select DAYNAME(ride_date) as day_of_week FROM uber_rides;
SELECT DAYNAME(ride_date) AS day_of_week, COUNT(*) AS total_bookings
FROM uber_rides
GROUP BY DAYNAME(ride_date)
ORDER BY total_bookings DESC;
