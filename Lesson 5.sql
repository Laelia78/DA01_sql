ex1: hackerrank-weather-observation-station-3.
Select distinct city from station
where ID%2=0;

ex2: hackerrank-weather-observation-station-4.
Select count(CITY) - COUNT(distinct CITY)
from STATION;

ex3: hackerrank-the-blunder.
select ceiling(avg(salary) - avg(replace(salary,'0',""))) AS error_salary
from EMPLOYEES;

ex4: datalemur-alibaba-compressed-mean.
SELECT
ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences) AS DECIMAL),1) AS mean
FROM items_per_order;

ex5: datalemur-matching-skills.
SELECT candidate_id 
FROM candidates
WHERE skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id 
HAVING COUNT(skill) =3;

ex6: datalemur-verage-post-hiatus-1.
SELECT user_id,
DATE(MAX(post_date))-DATE(MIN(post_date)) AS days_between
FROM posts
WHERE post_date>= '2021-01-01' AND post_date<= '2022-01-01'
GROUP BY user_id
HAVING COUNT(post_id) >=2;

ex7: datalemur-cards-issued-difference.
SELECT card_name,
MAX(issued_amount)-MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name 
ORDER BY difference DESC;

ex8: datalemur-non-profitable-drugs.
SELECT manufacturer,
COUNT(drug) AS drug_count,
ABS(SUM(cogs-total_sales)) AS total_loss
FROM pharmacy_sales
WHERE total_sales<cogs
GROUP BY manufacturer
ORDER BY total_loss DESC;

ex9: leetcode-not-boring-movies.
Select * from Cinema
where id%2=1 and description<>'boring'
order by rating desc

ex10: leetcode-number-of-unique-subject.
Select teacher_id,
Count(distinct subject_id) AS cnt
From Teacher
Group by teacher_id;

ex11: leetcode-find-followers-count.
Select user_id,
COUNT(follower_id) AS followers_count
From Followers
Group by user_id
Order by user_id;

ex12:leetcode-classes-more-than-5-students.
Select class 
From Courses
group by class
having count(student)>=5;
