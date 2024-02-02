ex1: hackerrank-more-than-75-marks.
Select Name
From STUDENTS
Where Marks>75
Order by Right(Name,3), ID;

ex2: leetcode-fix-names-in-a-table.
select user_id,
concat(upper(left(name,1)), lower(right(name, length(name)-1))) as name
from Users
order by user_id;

ex3: datalemur-total-drugs-sales.
SELECT manufacturer,
CONCAT('$' || ROUND(SUM(total_sales)/1000000,0) || ' ' || 'million') as sales_mil
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;

ex4: avg-review-ratings.
SELECT 
EXTRACT(month from submit_date) as mth,
product_id,
ROUND(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY mth, product_id
ORDER BY mth, product_id;

ex5: teams-power-users.
SELECT sender_id,
COUNT(message_id) as message_count
FROM messages
WHERE EXTRACT(month FROM sent_date)=8
AND EXTRACT(year FROM sent_date)=2022
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;

ex6: invalid-tweets.
Select tweet_id
From Tweets
Where length(content)>15;

ex7: user-activity-for-the-past-30-days.
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE (activity_date > "2019-06-27" AND activity_date <= "2019-07-27")
GROUP BY activity_date;

ex8: number-of-hires-during-specific-time-period.
select 
count(id) as number_employee
from employees
where extract(month from joining_date) between 1 and 7
and extract(year from joining_date)=2022;

ex9: positions-of-letter-a.
select position('a' in first_name) as position
from worker
where first_name='Amitah';

ex10: macedonian-vintages.
select substring(title, length(winery)+2, 4)
from winemag_p2
where country='Macedonia';
