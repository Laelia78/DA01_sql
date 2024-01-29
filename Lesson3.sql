--- ex1: hackerank-revising-the-select-query.
SELECT NAME
FROM CITY
WHERE POPULATION >120000 AND COUNTRYCODE ='USA';

--- ex2: hackerank-japanese-cities-attributes.
SELECT * FROM CITY
WHERE COUNTRYCODE ='JPN';

--- ex3: hackerank-weather-observation-station-1.
SELECT CITY, STATE FROM STATION;

--- ex4: hackerank-weather-observation-station-6.
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%';

--- ex5: hackerank-weather-observation-station-7.
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE '%A' OR CITY LIKE '%E' OR CITY LIKE '%I' OR CITY LIKE '%O' OR CITY LIKE '%U';

--- ex6: hackerank-weather-observation-station-9.
SELECT DISTINCT CITY FROM STATION
WHERE CITY NOT LIKE 'A%' AND CITY NOT LIKE 'I%' AND CITY NOT LIKE 'U%' AND CITY NOT LIKE 'E%' AND CITY NOT LIKE 'O%';

--- ex7: hackerank-name-of-employees.
SELECT name FROM Employee 
ORDER BY name ASC;

--- ex8: hackerank-salary-of-employees.
SELECT name FROM Employee
WHERE salary>2000 and months<10
ORDER BY employee_id ASC;

--- ex9: leetcode-recyclable-and-low-fat-products.
SELECT product_id FROM Products
WHERE low_fats='Y' AND recyclable='Y';

--- ex10: leetcode-find-customer-referee.
SELECT name FROM Customer
WHERE referee_id !=2 OR referee_id is null;

--- ex11: leetcode-big-countries.
select distinct name, population, area from World
where area>=3000000 or population>= 25000000;

--- ex12: leetcode-article-views.
Select distinct author_id as id from Views
Where author_id = viewer_id
Order by author_id ASC;

--- ex13: datalemur-tesla-unfinished-part.
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date is NULL;

--- ex14: datalemur-lyft-driver-wages.
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary >=70000;

--- ex15: datalemur-find-the-advertising-channel
select advertising_channel from uber_advertising
where money_spent >100000 and year =2019;
