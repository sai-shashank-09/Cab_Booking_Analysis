use cab_bookings;
show tables;
describe uber_rides;
describe uber_drivers;
select * from uber_rides;
select * from uber_drivers;


-- Identify drivers who have received an average rating below 3.0 in the past three months
SELECT d.Driver_ID, d.Driver_Name, ROUND(AVG(r.Driver_Ratings), 2) AS Avg_Rating
FROM uber_rides AS r
JOIN uber_drivers AS d ON r.Driver_ID = d.Driver_ID
WHERE r.ride_date >= DATE_SUB((SELECT MAX(ride_date) FROM uber_rides), INTERVAL 3 MONTH)
GROUP BY d.Driver_ID, d.Driver_Name
HAVING Avg_Rating < 3.0
ORDER BY Avg_Rating desc;


--  Find the top 5 drivers who have completed the longest trips in terms of distance
SELECT d.Driver_ID, d.Driver_Name,  ROUND(SUM(d.Total_Distance_km),2) AS Total_Distance, COUNT(r.Booking_ID) AS Total_Rides
FROM Uber_rides AS r
JOIN uber_drivers AS d ON r.Driver_ID = d.Driver_ID
GROUP BY d.Driver_ID, d.Driver_Name
ORDER BY Total_Distance DESC
LIMIT 5;


--  Identify drivers with a high percentage of canceled trips
SELECT d.Driver_ID, d.Driver_Name, ROUND((SUM(r.Cancelled_Rides_by_Driver)/COUNT(r.Booking_ID))*100, 2) AS Cancellation_Percentage
FROM uber_rides AS r
JOIN uber_drivers AS d ON r.Driver_ID = d.Driver_ID
GROUP BY d.Driver_ID, d.Driver_Name
ORDER BY Cancellation_Percentage DESC
LIMIT 10;
