ex1: datalemur-yoy-growth-rate.
WITH CTE AS
(
  SELECT 
    Date_Part('year', UT.transaction_date) AS year,
    UT.product_id,
    UT.spend AS curr_year_spend
  FROM user_transactions UT
  ORDER BY Date_Part('year', UT.transaction_date)
)

SELECT
  *,
  ROUND((T.curr_year_spend - T.prev_year_spend) * 100.0 / T.prev_year_spend, 2) AS yoy_rate
FROM
(
  SELECT
    CT.year,
    CT.product_id,
    CT.curr_year_spend,
    LAG(CT.curr_year_spend) OVER(PARTITION BY CT.product_id ORDER BY CT.year) AS prev_year_spend 
  FROM CTE CT  
  ORDER BY CT.product_id, CT.year
) T

ex2: datalemur-card-launch-success.
WITH firstmonth AS (
SELECT card_name, issued_amount, 
ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS issue_order
FROM monthly_cards_issued
)

SELECT card_name, issued_amount
FROM firstmonth 
WHERE issue_order=1
ORDER BY issued_amount DESC;

ex3: datalemur-third-transaction.
select user_id, spend, transaction_date
from (
SELECT *, 
row_number() over(partition by user_id order by transaction_date) as b 
FROM transactions) a
where b = 3;

ex4: datalemur-histogram-users-purchases.
with cte as (select max(transaction_date) as transaction_date,
user_id
from user_transactions
group by user_id)

select a.transaction_date, a.user_id,
count(u.product_id) as purchase_count
from user_transactions u   
JOIN cte a ON a.transaction_date = u.transaction_date
and a.user_id = u.user_id
GROUP BY a.transaction_date, a.user_id
ORDER BY a.transaction_date, a.user_id;

ex5: datalemur-rolling-average-tweets.
select user_id,tweet_date,
ROUND(AVG(tweet_count)
        OVER(PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2)
        AS rolling_avg_3d
from tweets;

ex6: datalemur-repeated-payments.
with cte AS
(SELECT 
transaction_id, merchant_id, credit_card_id, amount, 
transaction_timestamp-lag(transaction_timestamp) over( PARTITION BY merchant_id, credit_card_id, amount order by transaction_timestamp ) as diff_time
FROM transactions)

select count(*) as payment_count
from cte
where diff_time <= '00:10:00';

ex7: datalemur-highest-grossing.
select X.category,
       X.product,
       X.total_spend
from
    (select DISTINCT product,
            total_spend,
            category,
            DENSE_RANK()over(PARTITION BY category order by total_spend desc) as rnk
      from
          (select category,
                  product,
                  spend,
                  transaction_date,
                  sum(spend) over(partition by product order by category) as total_spend
            from product_spend
            group by 1,2,3,4
            having to_char(transaction_date::timestamp, 'yyyy')='2022') as T
      group by category,product,total_spend
      order by category,total_spend DESC) as X
where X.rnk<=2

ex8: datalemur-top-fans-rank.
with compute_rankings_cte as (
  select a.artist_name,
        Dense_Rank() over (ORDER BY COUNT(s.song_id) DESC) as rnk
  from global_song_rank gsk
    inner join 
        songs s on
      gsk.song_id=s.song_id
    inner join 
        artists a on
      a.artist_id=s.artist_id
  where gsk.rank<=10
  group by a.artist_name
)


select compute_rankings_cte.artist_name, 
      compute_rankings_cte.rnk as artist_rank
from compute_rankings_cte
where compute_rankings_cte.rnk<=5
