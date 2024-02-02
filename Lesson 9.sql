ex1: datalemur-laptop-mobile-viewership.
SELECT
SUM(CASE
  WHEN device_type='laptop' THEN 1
  ELSE 0
END) AS laptop_reviews,
SUM(CASE
  WHEN device_type in ('tablet','phone') THEN 1
  ELSE 0
END) AS mobile_views
FROM viewership;

ex2: datalemur-triangle-judgement.
SELECT x,y,z,
CASE
    WHEN x+y>z AND x+z>y AND y+z>x THEN 'Yes'
    ELSE 'No'
END AS triangle
FROM Triangle;

ex3: datalemur-uncategorized-calls-percentage.
SELECT
  ROUND(100.0 * 
    SUM(CASE 
    WHEN call_category IS NULL  THEN 1
    WHEN call_category = 'n/a' THEN 1
    ELSE 0
  END)/COUNT(*), 1) AS uncategorised_call_pct
FROM callers;

ex4: datalemur-find-customer-referee.
SELECT name FROM Customer
WHERE referee_id !=2 OR referee_id is null;

ex5: stratascratch the-number-of-survivors.
select survived,
count(case
when pclass = 1 then pclass
end) as first_class,
count(case
when pclass = 2 then pclass
end) as second_class,
count(case
when pclass = 3 then pclass
end) as third_class
from titanic
group by survived;
