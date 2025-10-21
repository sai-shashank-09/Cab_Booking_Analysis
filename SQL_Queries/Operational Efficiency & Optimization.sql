use cab_bookings;
show tables;
describe uber_rides;
select * from uber_rides;


-- Analyze the average waiting time (difference between booking time and trip start time) for different pickup locations.
SELECT Pickup_Location, AVG(CAST(Avg_VTAT AS DECIMAL(5,2))) AS avg_waiting_time_minutes
FROM uber_rides
WHERE Booking_Status = 'Completed'
GROUP BY Pickup_Location
ORDER BY avg_waiting_time_minutes DESC;


-- Identify the most common reasons for trip cancellations from customer feedback
SELECT Reason_for_cancelling_by_Customer AS cancellation_reason, COUNT(*) AS total_cancellations
FROM uber_rides
WHERE Booking_Status = 'Cancelled by Customer' AND Reason_for_cancelling_by_Customer IS NOT NULL
GROUP BY cancellation_reason
ORDER BY total_cancellations DESC
LIMIT 10;
 
 
 -- Find out whether shorter trips (low-distance) contribute significantly to revenue.
SELECT IF(Ride_Distance <= 5, 'Short Trip (≤5 km)', 'Long Trip (>5 km)') AS Distance_Category, COUNT(*) AS Total_Trips,
SUM(Booking_Value) AS Total_Revenue, ROUND(AVG(Booking_Value), 2) AS Avg_Revenue_Per_Trip
FROM uber_rides
WHERE Booking_Status = 'Completed'
GROUP BY Distance_Category;
