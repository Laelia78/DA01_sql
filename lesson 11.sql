--- ex1: hackerrank-average-population-of-each-continent.
select COUNTRY.continent as Continent_name,
floor(avg(CITY.population))
from COUNTRY
join CITY
on CITY.CountryCode = COUNTRY.Code
group by Continent_name;

---ex2: datalemur-signup-confirmation-rate.
select 
round(1.0*count(CASE
WHEN signup_action ='Confirmed' then 1
End) /count(*),2) as activation_rate
from texts

--- ex3: datalemur-time-spent-snaps.
SELECT age_bucket,
ROUND(100.0*SUM(CASE
WHEN activity_type = 'send' THEN time_spent
END)/SUM(CASE
WHEN activity_type IN ('send','open') THEN time_spent
END),2) AS send_perc,
ROUND(100.0*SUM(CASE
WHEN activity_type = 'open' THEN time_spent
END)/SUM(CASE
WHEN activity_type IN ('send','open') THEN time_spent
END),2) AS open_perc
FROM activities
JOIN age_breakdown
ON age_breakdown.user_id=activities.user_id
GROUP BY age_bucket;

--- ex4: datalemur-supercloud-customer.
SELECT DISTINCT customer_id
FROM customer_contracts
JOIN products
ON products.product_id=customer_contracts.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category)>=3;

--- ex5: leetcode-the-number-of-employees-which-report-to-each-employee.
SELECT t1.employee_id, t1.name,
COUNT(t2.employee_id) AS reports_count,
ROUND(AVG(t2.age)) AS average_age
FROM Employees AS t1
LEFT JOIN Employees AS t2
ON t1.employee_id=t2.reports_to
GROUP BY t1.employee_id
HAVING reports_count>0
ORDER BY employee_id;

---ex6: leetcode-list-the-products-ordered-in-a-period.
SELECT t1.product_name,
SUM(t2.unit) AS unit
FROM Products AS t1
INNER JOIN Orders AS t2
ON t1.product_id=t2.product_id
WHERE order_date between '2020-02-01' and '2020-02-29'
GROUP BY t1.product_id
HAVING unit>=100;

---ex7: leetcode-sql-page-with-no-likes.
SELECT t1.page_id 
FROM pages AS t1
LEFT JOIN page_likes AS t2
ON t1.page_id=t2.page_id
WHERE user_id IS NULL
ORDER BY t1.page_id ASC;

--- Question 1:
SELECT DISTINCT 
MIN(replacement_cost) AS min_cost
FROM film;

--- Question 2:
SELECT
CASE 
	WHEN replacement_cost between 9.99 and 19.99 THEN 'LOW'
	WHEN replacement_cost between 20.00 and 24.99 THEN 'MEDIUM'
	WHEN replacement_cost between 25.00 and 29.99 THEN 'HIGH'
END AS category,
COUNT (*) AS so_luong 
FROM film
WHERE CASE 
	WHEN replacement_cost between 9.99 and 19.99 THEN 'LOW'
	WHEN replacement_cost between 20.00 and 24.99 THEN 'MEDIUM'
	WHEN replacement_cost between 25.00 and 29.99 THEN 'HIGH'
END ='LOW'
GROUP BY category;

--- Question 3:
SELECT t3.name, t1.length
FROM film AS t1
JOIN film_category AS t2
ON t1.film_id=t2.film_id
JOIN category AS t3
ON t2.category_id=t3.category_id
WHERE name='Drama' OR name='Sports'
ORDER BY t1.length DESC
LIMIT 1;

--- Question 4:
SELECT t3.name AS category,
COUNT(t1.title) || ' ' || 'titles' AS titles
FROM film AS t1
JOIN film_category AS t2
ON t1.film_id=t2.film_id
JOIN category AS t3
ON t2.category_id=t3.category_id
GROUP BY category
ORDER BY titles DESC
LIMIT 1;

--- Question 5:
SELECT 
first_name || ' ' || last_name AS full_name,
COUNT(title) || ' ' || 'movies' AS movies
FROM actor AS t1
JOIN film_actor AS t2
ON t1.actor_id=t2.actor_id
JOIN film AS t3
ON t2.film_id=t3.film_id
GROUP BY full_name
ORDER BY movies DESC
LIMIT 1;

--- Question 6:
SELECT 
COUNT(1) FILTER(WHERE customer_id is NULL)
FROM address AS t1
LEFT JOIN customer AS t2
ON t1.address_id=t2.address_id;

--- Question 7:
SELECT t1.city, SUM(t4.amount) AS total
FROM city AS t1
JOIN address AS t2
ON t1.city_id=t2.city_id
JOIN customer AS t3
ON t2.address_id=t3.address_id
JOIN payment AS t4
ON t3.customer_id=t4.customer_id
GROUP BY t1.city
ORDER BY total DESC
LIMIT 1;

--- Question 8:
/*Topic: JOIN & GROUP BY
Task: Tạo danh sách trả ra 2 cột dữ liệu:
cột 1: thông tin thành phố và đất nước ( format: “city, country")
cột 2: doanh thu tương ứng với cột 1
Question: thành phố của đất nước nào đat doanh thu cao nhất => CÁI NÀY PHẢI LÀ "THẤP NHẤT" nha
Answer: United States, Tallahassee : 50.85.*/
SELECT t5.country || ',' || ' ' || t1.city AS Col1, SUM(t4.amount) AS total
FROM city AS t1
JOIN address AS t2
ON t1.city_id=t2.city_id
JOIN customer AS t3
ON t2.address_id=t3.address_id
JOIN payment AS t4
ON t3.customer_id=t4.customer_id
JOIN country AS t5
ON t1.country_id=t5.country_id
GROUP BY t1.city, t5.country
ORDER BY total ASC
LIMIT 1;
