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

SELECT ROUND(SUM(TIV_2016),2) TIV_2016 FROM
(SELECT TIV_2016, COUNT(1) OVER (PARTITION BY TIV_2015) NUM1, COUNT(1) OVER (PARTITION BY LAT,LON) NUM2
FROM INSURANCE) I
WHERE I.NUM1 > 1 AND I.NUM2 = 1
-- 601
SELECT DISTINCT S1.* FROM STADIUM S1,STADIUM S2,STADIUM S3
WHERE S1.PEOPLE >= 100 AND S2.PEOPLE >= 100 AND S3.PEOPLE >= 100
AND ((S1.ID = S2.ID - 1 AND S1.ID = S3.ID - 2) OR (S1.ID = S2.ID - 1 AND S1.ID = S3.ID + 1) OR (S1.ID = S2.ID + 1 AND S1.ID = S3.ID + 2))
ORDER BY S1.ID