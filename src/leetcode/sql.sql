-- 175
SELECT P.FirstName, P.LastName, A.City, A.State FROM PERSON P LEFT JOIN ADDRESS A ON P.PersonId = A.PersonId
-- 176
SELECT (SELECT DISTINCT SALARY FROM EMPLOYEE ORDER BY SALARY DESC LIMIT 1,1) 'SecondHighestSalary'
-- 177
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  DECLARE M INT; 
  SET M = N-1; 
  RETURN (
       SELECT DISTINCT SALARY FROM EMPLOYEE ORDER BY SALARY DESC LIMIT M,1
  );
END
-- 178
SELECT SCORE, DENSE_RANK() OVER(ORDER BY SCORE DESC) 'RANK' FROM SCORES
-- 180
SELECT DISTINCT A.NUM ConsecutiveNums FROM LOGS A, LOGS B, LOGS C WHERE A.ID + 1 = B.ID AND A.NUM = B.NUM AND A.ID + 2 = C.ID AND A.NUM = C.NUM
-- 181
SELECT E1.NAME 'Employee' FROM EMPLOYEE E1, EMPLOYEE E2 WHERE E1.MANAGERID = E2.ID AND E1.SALARY > E2.SALARY
-- 182
SELECT EMAIL FROM PERSON GROUP BY EMAIL HAVING COUNT(1) > 1
-- 183
SELECT NAME 'Customers' FROM CUSTOMERS C WHERE NOT EXISTS (SELECT 1 FROM ORDERS WHERE C.ID = ORDERS.customerId)

SELECT NAME 'Customers' FROM CUSTOMERS WHERE ID NOT IN (SELECT DISTINCT customerId FROM ORDERS)
-- 184
SELECT D.NAME DEPARTMENT, E.NAME EMPLOYEE, E.SALARY FROM
(SELECT ID, NAME, SALARY, DENSE_RANK() OVER(PARTITION BY DEPARTMENTID ORDER BY SALARY DESC) RANKING, DEPARTMENTID FROM EMPLOYEE) E,
DEPARTMENT D
WHERE E.RANKING = 1 AND E.DEPARTMENTID = D.ID

SELECT D.NAME DEPARTMENT, E.NAME EMPLOYEE, E.SALARY FROM
EMPLOYEE E JOIN DEPARTMENT D ON E.DEPARTMENTID = D.ID
WHERE (E.SALARY, E.DEPARTMENTID) IN (SELECT MAX(SALARY), DEPARTMENTID FROM EMPLOYEE GROUP BY DEPARTMENTID)
-- 185
SELECT D.NAME DEPARTMENT, E.NAME EMPLOYEE, E.SALARY FROM
(SELECT ID, NAME, SALARY, DENSE_RANK() OVER(PARTITION BY DEPARTMENTID ORDER BY SALARY DESC) RANKING, DEPARTMENTID FROM EMPLOYEE) E,
DEPARTMENT D
WHERE E.RANKING < 4 AND E.DEPARTMENTID = D.ID

SELECT D.NAME DEPARTMENT, E.NAME EMPLOYEE, E.SALARY FROM
EMPLOYEE E JOIN DEPARTMENT D ON E.DEPARTMENTID = D.ID
WHERE
(SELECT COUNT(DISTINCT SALARY) FROM EMPLOYEE WHERE SALARY > E.SALARY AND DEPARTMENTID = E.DEPARTMENTID) < 3
-- 196
-- MySQL 不允许在 DELETE 语句的 WHERE 子句中直接使用正在被更新的表
DELETE FROM PERSON
WHERE ID NOT IN
(SELECT A.ID FROM (SELECT MIN(ID) ID FROM PERSON GROUP BY EMAIL) A)

DELETE P1 FROM PERSON P1, PERSON P2 WHERE P1.EMAIL = P2.EMAIL AND P1.ID > P2.ID
-- 197
-- 上个月末是这个月月初的前一天，但差值不是1不能直接减法
SELECT W1.ID FROM WEATHER W1, WEATHER W2 WHERE DATEDIFF(W1.recordDate, W2.recordDate) = 1 AND W1.temperature > W2.temperature
-- 262
SELECT REQUEST_AT 'Day', ROUND(SUM(CASE T.STATUS WHEN 'completed' THEN 0 ELSE 1 END)/COUNT(1),2) 'Cancellation Rate'
FROM TRIPS T
JOIN USERS U1 ON T.CLIENT_ID = U1.USERS_ID AND U1.BANNED = 'No'
JOIN USERS U2 ON T.DRIVER_ID = U2.USERS_ID AND U2.BANNED = 'No'
WHERE
REQUEST_AT BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY REQUEST_AT
-- 511
SELECT PLAYER_ID,MIN(EVENT_DATE) 'first_login' FROM ACTIVITY GROUP BY PLAYER_ID

-- 还可用窗口函数
-- 550
SELECT ROUND(COUNT(1)/(SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY),2) 'fraction' FROM ACTIVITY A
WHERE
(A.PLAYER_ID,A.EVENT_DATE) IN (SELECT PLAYER_ID,MIN(EVENT_DATE) 'first_login' FROM ACTIVITY GROUP BY PLAYER_ID)
AND EXISTS (SELECT 1 FROM ACTIVITY WHERE A.PLAYER_ID = PLAYER_ID AND DATEDIFF(EVENT_DATE,A.EVENT_DATE) = 1)
-- 570
SELECT NAME FROM EMPLOYEE E WHERE (SELECT COUNT(1) FROM EMPLOYEE WHERE E.ID = MANAGERID) >= 5
-- 577
SELECT E.NAME,B.BONUS
FROM EMPLOYEE E
LEFT JOIN BONUS B ON E.EMPID = B.EMPID
WHERE B.BONUS < 1000 OR B.BONUS IS NULL
-- 584
SELECT NAME FROM CUSTOMER WHERE REFEREE_ID != 2 OR REFEREE_ID IS NULL
-- 585
SELECT ROUND(SUM(TIV_2016),2) TIV_2016 FROM INSURANCE I
WHERE EXISTS (SELECT 1 FROM INSURANCE WHERE PID != I.PID AND TIV_2015 = I.TIV_2015)
AND NOT EXISTS (SELECT 1 FROM INSURANCE WHERE PID != I.PID AND LAT = I.LAT AND LON = I.LON)

-- 窗口函数
SELECT ROUND(SUM(TIV_2016),2) TIV_2016 FROM
(SELECT TIV_2016, COUNT(1) OVER (PARTITION BY TIV_2015) NUM1, COUNT(1) OVER (PARTITION BY LAT,LON) NUM2
FROM INSURANCE) I
WHERE I.NUM1 > 1 AND I.NUM2 = 1
-- 586
SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(1) DESC
LIMIT 1
-- 595
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000
-- 596
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5
-- 601
SELECT DISTINCT S1.* FROM STADIUM S1,STADIUM S2,STADIUM S3
WHERE S1.PEOPLE >= 100 AND S2.PEOPLE >= 100 AND S3.PEOPLE >= 100
AND ((S1.ID = S2.ID - 1 AND S1.ID = S3.ID - 2) OR (S1.ID = S2.ID - 1 AND S1.ID = S3.ID + 1) OR (S1.ID = S2.ID + 1 AND S1.ID = S3.ID + 2))
ORDER BY S1.ID
-- 602 UNION ALL
SELECT id, COUNT(1) num
FROM
(
SELECT requester_id id FROM RequestAccepted
UNION ALL
SELECT accepter_id id FROM RequestAccepted
) t
GROUP BY id
ORDER BY num DESC
LIMIT 1
-- 607
SELECT NAME FROM SalesPerson S
WHERE NOT EXISTS
(SELECT 1 FROM Orders O JOIN Company C ON O.com_id = C.com_id
WHERE C.NAME = 'RED' AND O.SALES_ID = S.SALES_ID)

SELECT NAME FROM SalesPerson S
WHERE S.SALES_ID NOT IN
(SELECT O.SALES_ID FROM Orders O JOIN Company C ON O.com_id = C.com_id
WHERE C.NAME = 'RED')
-- 608
SELECT
ID,
CASE
WHEN (P_ID IS NULL) THEN 'Root'
WHEN NOT EXISTS (SELECT 1 FROM TREE WHERE P_ID = T.ID) THEN 'Leaf'
ELSE 'Inner'
END TYPE
FROM TREE T
-- 610
SELECT x,y,z,
CASE WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes' ELSE 'No' END triangle
FROM triangle
-- 619
SELECT MAX(num) num FROM
(SELECT num FROM MyNumbers GROUP BY num HAVING COUNT(1) = 1) t
-- 620
SELECT *
FROM cinema
WHERE description != 'boring' AND id % 2 = 1
ORDER BY rating DESC
-- 626
SELECT
CASE WHEN id % 2 = 1 AND id = seat_count.counts THEN id WHEN id % 2 = 1 THEN id + 1 ELSE id - 1 END id, student
FROM seat, (SELECT MAX(id) counts FROM Seat) seat_count
ORDER BY id

SELECT
id, IF(id % 2 = 1, LEAD(student, 1, student) OVER (ORDER BY id), LAG(student, 1) OVER (ORDER BY id)) student
FROM seat
ORDER BY id
-- 627 第四种有点意思
UPDATE Salary SET sex = CASE sex WHEN 'f' THEN 'm' ELSE 'f' END

UPDATE Salary SET sex = CASE WHEN sex = 'f' THEN 'm' ELSE 'f' END

UPDATE Salary SET sex = IF(sex = 'f', 'm', 'f')

UPDATE Salary SET sex = char(211 - ascii(sex))
-- 1045
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(1) FROM product)
-- 1050
SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(1) >= 3
-- 1068
-- USING 适用于两个表之间有同名列的情况，可以简化语法；
-- ON 适用于没有同名列或需要指定非等值匹配的情况，使用更灵活；
-- WHERE 可以实现连接效果，但不如使用 ON 或 USING 方便和直观。
SELECT product_name, year, price
FROM Sales s, Product p
WHERE s.product_id = p.product_id

SELECT product_name, year, price
FROM Sales s
JOIN Product p
ON s.product_id = p.product_id

SELECT product_name, year, price
FROM Sales
JOIN Product
USING (product_id)
-- 1070 分步或窗口函数
SELECT product_id, year first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN
(SELECT product_id, MIN(year) FROM Sales GROUP BY product_id)

SELECT product_id, year first_year, quantity, price
FROM
(SELECT product_id, year, quantity, price, RANK() OVER (PARTITION BY product_id ORDER BY year) rnk
FROM Sales) t
WHERE rnk = 1
ORDER BY product_id
-- 1075
SELECT p.project_id, ROUND(AVG(experience_years), 2) average_years
FROM Project p
JOIN Employee e
ON p.employee_id = e.employee_id
GROUP BY p.project_id
-- 1084 COUNT( OR NULL) SUM
SELECT product_id, product_name
FROM Product
WHERE product_id IN
(SELECT product_id
FROM Sales
GROUP BY product_id
HAVING MIN(sale_date) BETWEEN '2019-01-01' AND '2019-03-31'
AND MAX(sale_date) BETWEEN '2019-01-01' AND '2019-03-31')

SELECT p.product_id, product_name
FROM Product p
JOIN Sales s
ON p.product_id = s.product_id
GROUP BY product_id
HAVING SUM(sale_date BETWEEN '2019-01-01' AND '2019-03-31') = COUNT(1)
-- 1141 DATEDIFF DATE_ADD DATE_SUB
SELECT activity_date day, COUNT(DISTINCT user_id) active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date

SELECT activity_date day, COUNT(DISTINCT user_id) active_users
FROM Activity
WHERE DATEDIFF("2019-07-27", activity_date) BETWEEN 0 AND 29
GROUP BY activity_date

SELECT activity_date day, COUNT(DISTINCT user_id) active_users
FROM Activity
WHERE activity_date BETWEEN DATE_ADD('2019-07-27',INTERVAL -29 day) AND '2019-07-27'
GROUP BY activity_date

SELECT activity_date day, COUNT(DISTINCT user_id) active_users
FROM Activity
WHERE activity_date BETWEEN DATE_SUB('2019-07-27',INTERVAL 29 day) AND '2019-07-27'
GROUP BY activity_date
-- 1148 DISTINCT、GROUP BY 都可以去重，
-- MySQL 8.0之前的版本 DISTINCT 的效率要比 GROUP BY 的去重效率高，因为 GROUP BY 会有隐式排序，8.0之后移除了
SELECT DISTINCT author_id id
FROM Views
WHERE author_id = viewer_id
ORDER BY id

SELECT author_id id
FROM Views
WHERE author_id = viewer_id
GROUP BY author_id
ORDER BY id
-- 1158 条件放在 ON 或 WHERE
SELECT u.user_id buyer_id, u.join_date, COUNT(o.order_id) orders_in_2019
FROM Users u
LEFT JOIN Orders o
ON u.user_id = o.buyer_id AND order_date LIKE '2019%'
GROUP BY u.user_id

SELECT u.user_id buyer_id, u.join_date, IFNULL(SUM(order_date LIKE '2019%'), 0) orders_in_2019
FROM Users u
LEFT JOIN Orders o
ON u.user_id = o.buyer_id
GROUP BY u.user_id
-- 1164 最新用 GROUP BY MAX 也可以用窗口函数
SELECT p.product_id, IFNULL(t.new_price, 10) price
FROM
(SELECT DISTINCT product_id FROM Products) p
LEFT JOIN
(SELECT product_id, new_price FROM
(SELECT product_id, new_price, ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC) rk
FROM Products WHERE change_date <= '2019-08-16') t
WHERE rk = 1) t
ON p.product_id = t.product_id

SELECT p.product_id, IFNULL(t.new_price, 10) price
FROM
(SELECT DISTINCT product_id FROM Products) p
LEFT JOIN
(SELECT product_id, new_price
FROM Products
WHERE (product_id, change_date) IN
(SELECT product_id, MAX(change_date) FROM Products WHERE change_date <= '2019-08-16' GROUP BY product_id)) t
ON p.product_id = t.product_id
-- 1174
SELECT ROUND(SUM(order_date = customer_pref_delivery_date) / COUNT(1) * 100, 2) immediate_percentage
FROM delivery
WHERE (customer_id, order_date) IN
(SELECT customer_id, MIN(order_date) FROM delivery GROUP BY customer_id)

SELECT ROUND(SUM(order_date = customer_pref_delivery_date) / COUNT(1) * 100, 2) immediate_percentage
FROM
(SELECT order_date, customer_pref_delivery_date, RANK() OVER (PARTITION BY customer_id ORDER BY order_date) rk
FROM delivery) t1
WHERE rk = 1
-- 1193
SELECT
DATE_FORMAT(trans_date, '%Y-%m') month, country, COUNT(1) trans_count, SUM(state = 'approved') approved_count,
SUM(amount) trans_total_amount, SUM(IF(state = 'approved', amount, 0)) approved_total_amount
FROM transactions
GROUP BY country, month
-- 1179
SELECT id,
SUM(IF(month = 'Jan', revenue, NULL)) Jan_Revenue,
SUM(IF(month = 'Feb', revenue, NULL)) Feb_Revenue,
SUM(IF(month = 'Mar', revenue, NULL)) Mar_Revenue,
SUM(IF(month = 'Apr', revenue, NULL)) Apr_Revenue,
SUM(IF(month = 'May', revenue, NULL)) May_Revenue,
SUM(IF(month = 'Jun', revenue, NULL)) Jun_Revenue,
SUM(IF(month = 'Jul', revenue, NULL)) Jul_Revenue,
SUM(IF(month = 'Aug', revenue, NULL)) Aug_Revenue,
SUM(IF(month = 'Sep', revenue, NULL)) Sep_Revenue,
SUM(IF(month = 'Oct', revenue, NULL)) Oct_Revenue,
SUM(IF(month = 'Nov', revenue, NULL)) Nov_Revenue,
SUM(IF(month = 'Dec', revenue, NULL)) Dec_Revenue
FROM department
GROUP BY id
-- 1211
SELECT query_name,
ROUND(AVG(rating / position), 2) quality,
ROUND(SUM(rating < 3) * 100 / COUNT(1), 2) poor_query_percentage
FROM queries
WHERE query_name IS NOT NULL
GROUP BY query_name
-- 1204
SELECT q1.person_name
FROM queue q1, queue q2
WHERE q1.turn >= q2.turn
GROUP BY q1.person_name, q1.turn
HAVING SUM(q2.weight) <= 1000
ORDER BY q1.turn DESC
LIMIT 1

SELECT person_name
FROM
(SELECT turn, person_name, SUM(weight) OVER (ORDER BY turn) total FROM queue) t
WHERE total <= 1000
ORDER BY turn DESC
LIMIT 1
-- 1251
SELECT p.product_id, IFNULL(ROUND(SUM(p.price * u.units) / SUM(u.units), 2), 0) average_price
FROM Prices p LEFT JOIN UnitsSold u
ON p.product_id = u.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id
-- 1280
SELECT stu.student_id, stu.student_name, sub.subject_name, COUNT(e.subject_name) attended_exams
FROM Students stu
JOIN Subjects sub
LEFT JOIN Examinations e
ON stu.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY stu.student_id, sub.subject_name
ORDER BY stu.student_id, sub.subject_name
-- 1321
SELECT c1.visited_on, SUM(c2.amount) amount, ROUND(SUM(c2.amount) / 7, 2) average_amount
FROM (SELECT DISTINCT visited_on FROM Customer) c1
JOIN Customer c2
ON DATEDIFF(c1.visited_on, c2.visited_on) BETWEEN 0 AND 6
GROUP BY c1.visited_on HAVING COUNT(DISTINCT c2.visited_on) = 7

SELECT visited_on, SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) amount
FROM Customer
GROUP BY visited_on
-- 1327 日期可以模糊搜索
SELECT p.product_name, SUM(unit) unit
FROM Orders o
JOIN Products p
USING (product_id)
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING unit >= 100

SELECT p.product_name, SUM(unit) unit
FROM Orders o
JOIN Products p
USING (product_id)
WHERE o.order_date LIKE '2020-02%'
GROUP BY p.product_name
HAVING unit >= 100
-- 1341 UNION ALL
(SELECT name results
FROM MovieRating
JOIN Users
USING (user_id)
GROUP BY name
ORDER BY COUNT(1) DESC, name
LIMIT 1)
UNION ALL
(SELECT title results
FROM MovieRating
JOIN Movies
USING (movie_id)
WHERE created_at LIKE '2020-02%'
GROUP BY title
ORDER BY AVG(rating) DESC, title
LIMIT 1)
-- 1393 不需要买入卖出匹配相减
SELECT stock_name, SUM(IF(operation = 'Sell', price, -price)) capital_gain_loss
FROM Stocks
GROUP BY stock_name
-- 1407 重名的情况需要考虑 GROUP BY u.id，MySQL 可以取非聚合列
SELECT u.name, SUM(IFNULL(r.distance, 0)) travelled_distance
FROM Users u
LEFT JOIN Rides r
ON u.id = r.user_id
GROUP BY u.id
ORDER BY travelled_distance DESC, name
-- 1484 组内数据拼接 GROUP_CONCAT(DISTINCT expression1 ORDER BY expression2 SEPARATOR sep)
SELECT sell_date, COUNT(DISTINCT product) num_sold, GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date
-- 1517 REGEXP 正则，想输入\.需要用\\.
SELECT user_id, name, mail
FROM Users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*\\@leetcode\\.com$'
-- 1527 正则
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%' 

SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions REGEXP '\\bDIAB1'

SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions REGEXP '^DIAB1| DIAB1'
