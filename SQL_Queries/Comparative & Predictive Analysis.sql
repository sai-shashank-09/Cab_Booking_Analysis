use cab_bookings;
show tables;
describe uber_rides;
select * from uber_rides;


-- Compare the revenue generated from 'Sedan' and 'SUV' cabs.
SELECT Vehicle_Type, COUNT(*) AS total_rides, SUM(CAST(Booking_Value AS DECIMAL(10,2))) AS total_revenue, 
ROUND(AVG(CAST(Booking_Value AS DECIMAL(10,2))),2) AS avg_revenue_per_ride
FROM uber_rides
WHERE Booking_Status = 'Completed' AND Booking_Value IS NOT NULL
GROUP BY Vehicle_Type
ORDER BY total_revenue DESC;


-- Predict which customers are likely to stop using the service based on their last booking date and frequency of rides.
SELECT Customer_ID, MAX(ride_date) AS last_ride_date, 
DATEDIFF((SELECT MAX(ride_date) FROM uber_rides), MAX(ride_date)) AS Days_Without_Ride, COUNT(*) AS total_rides
FROM uber_rides
WHERE Booking_Status = 'Completed'
GROUP BY Customer_ID
ORDER BY Days_Without_Ride DESC, total_rides ASC;


-- Analyze whether weekend bookings differ significantly from weekday bookings.
SELECT IF(DAYOFWEEK(ride_date) IN (1,7), 'Weekend', 'Weekday') AS Day_Type, COUNT(*) AS Total_Bookings, 
SUM(Booking_Value) AS Total_Revenue, ROUND(AVG(Booking_Value), 2) AS Avg_Booking_Value
FROM uber_rides
WHERE Booking_Status = 'Completed'
GROUP BY Day_Type;
