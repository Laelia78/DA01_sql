---ex1: datalemur-duplicate-job-listings.
Select COUNT(DISTINCT company_id) As duplicate_companies
From ( SELECT company_id, title, description, 
COUNT(job_id) As job_count
From job_listings
GROUP BY company_id, title, description)
As job_count_cte
WHERE job_count >1;
---ex2: datalemur-highest-grossing.
SELECT category, product, total_spend
FROM (SELECT category, product, 
SUM(spend) AS total_spend,
RANK() OVER(PARTITION BY category
ORDER BY SUM(spend) DESC) AS ranking
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product) AS ranked_spending
WHERE ranking <=2
ORDER BY category, ranking;
---ex3: datalemur-frequent-callers.
SELECT COUNT(policy_holder_id) AS member_count
FROM (SELECT policy_holder_id,
COUNT(case_id) AS call_count
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >=3) AS call_records;
---ex4: datalemur-page-with-no-likes.
SELECT t1.page_id 
FROM pages AS t1
LEFT JOIN page_likes AS t2
ON t1.page_id=t2.page_id
WHERE user_id IS NULL
ORDER BY t1.page_id ASC;
---ex5: datalemur-user-retention
SELECT
  EXTRACT(MONTH FROM curr_month.event_date) AS mth,
  COUNT(DISTINCT curr_month.user_id) AS monthly_active_users
FROM user_actions AS curr_month
WHERE EXISTS (
  SELECT last_month.user_id
  FROM user_actions AS last_month
  WHERE last_month.user_id = curr_month.user_id
    AND EXTRACT(MONTH FROM last_month.event_date) =
    EXTRACT(MONTH FROM curr_month.event_date - interval '1 month'))
  AND EXTRACT(MONTH FROM curr_month.event_date) =7
  AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date);
---ex6: leetcode-monthly-transactions.
SELECT 
    SUBSTR(trans_date, 1, 7) AS month, country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country;
---ex7: leetcode-product-sales-analysis.
SELECT Sales.product_id, SubSales.first_year, Sales.quantity, Sales.price
FROM Sales
JOIN (SELECT product_id, MIN(year) AS first_year
FROM Sales
GROUP BY product_id) AS SubSales
ON Sales.product_id = SubSales.product_id AND Sales.year = SubSales.first_year;
---ex8: leetcode-customers-who-bought-all-products.
SELECT  customer_id FROM Customer GROUP BY customer_id
HAVING COUNT(distinct product_key) = (SELECT COUNT(product_key) FROM Product);
---ex9: leetcode-employees-whose-manager-left-the-company.
SELECT DISTINCT E2.Employee_id FROM Employees E1,Employees E2 WHERE E2.Salary<30000 AND
E2.Manager_id NOT IN(SELECT Employee_id FROM Employees) ORDER BY Employee_id;
---ex10: leetcode-primary-department-for-each-employee.
Select COUNT(DISTINCT company_id) As duplicate_companies
From ( SELECT company_id, title, description, 
COUNT(job_id) As job_count
From job_listings
GROUP BY company_id, title, description)
As job_count_cte
WHERE job_count >1;
---ex11: leetcode-movie-rating.
# Write your MySQL query statement below
(select u.name as results
from Users u
join MovieRating m on u.user_id = m.user_id
group by u.user_id
order by count(movie_id) desc, name asc
limit 1)
union all
(select title as results
from Movies u
join MovieRating m on u.movie_id = m.movie_id
where year(created_at) = '2020' and month(created_at) = '02'
group by u.movie_id
order by avg(rating) desc, title asc
limit 1);
---ex12: leetcode-who-has-the-most-friends.
SELECT id, COUNT(*) AS num 
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS friends_count
GROUP BY id
ORDER BY num DESC 
LIMIT 1;
