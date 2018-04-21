/*
author: lianghowe
*/
CREATE DATABASE S_T DEFAULT character
SET utf8;

 USE S_T
DROP TABLE student,
           course,
           sc;


CREATE TABLE student(sno char(9) PRIMARY KEY, sname char(20) UNIQUE, ssex char(2), sage smallint, sdept char(20));


CREATE TABLE course(cno char(4) PRIMARY KEY, cname char(40), cpno char(40), ccredit smallint,
                    FOREIGN KEY (cpno) REFERENCES course(cno));


CREATE TABLE sc(sno char(9), cno char(4), grade smallint, PRIMARY KEY (sno,cno),
                FOREIGN KEY (sno) REFERENCES student(sno),
                FOREIGN KEY (cno) REFERENCES course(cno));


ALTER TABLE student ADD s_entrance date;


ALTER TABLE student
ALTER COLUMN sage int;


ALTER TABLE course ADD UNIQUE(cname);


CREATE UNIQUE INDEX stusno ON student(sno);


CREATE UNIQUE INDEX coucno ON course(cno);


CREATE UNIQUE INDEX scno ON sc(sno ASC, cno DESC);


DROP INDEX stusno;


SELECT sno,
       sname
FROM student;


SELECT sname,
       sno,
       sdept
FROM student;


SELECT sname,
       2004-sage
FROM student;


SELECT sname,
       'Year of Birth:',
       2004-sage,
       lower(sdept)
FROM student;


SELECT sname Name,
       'Year of Birth:' BIRTH,
                        2004-sage BIRTHDAY,
                        lower(sdept) DEPARTMENT
FROM student;


SELECT DISTINCT sno
FROM sc;


SELECT sname,
       sdept,
       sage
FROM student
WHERE sage BETWEEN 20 AND 23;


SELECT sname,
       sdept,
       sage
FROM student
WHERE sage NOT BETWEEN 20 AND 23;


SELECT sname,
       ssex
FROM student
WHERE sdept IN ('cs',
                'ma',
                'is');


SELECT sname,
       ssex
FROM student
WHERE sdept NOT IN ('cs',
                    'ma',
                    'is');


SELECT *
FROM student
WHERE sno LIKE '200215121';


SELECT sname,
       sno,
       ssex
FROM student
WHERE sname LIKE '刘%';


SELECT sname
FROM student
WHERE sname LIKE '欧阳__';


SELECT sname,
       sno
FROM student
WHERE LIKE '__阳%';


SELECT sname,
       ssex,
       sno
FROM student
WHERE sname NOT LIKE '刘%';


SELECT cno,
       ccredit
FROM course
WHERE cname LIKE 'DB\_Design'ESCAPE"\";


SELECT sno,
       cno
FROM sc
WHERE cname LIKE 'DB\_%i__'ESCAPE"\";


SELECT sno,
       grade
FROM sc
WHERE cno-'3'
ORDER BY grade DESC;


SELECT *
FROM student
ORDER BY sdept ,
         sage DESC;


SELECT count(*)
FROM student;


SELECT count(DISTINCT sno)
FROM sc;


SELECT avg(grade)
FROM sc
WHERE cno='1';


SELECT max(grade)
FROM sc
WHERE cno='1';


SELECT sum(ccredit)
FROM sc,
     course
WHERE sno='200215012'
  AND sc.cno=course.cno;

 #
WHERE 不能用聚集函数作为条件表达式
  SELECT cno,
         count(sno)
  FROM sc
GROUP BY cno;


SELECT sno
FROM sc
GROUP BY sno HAVING count(*)>3;


SELECT student.*,
       sc.*
FROM student,
     sc
WHERE student.sno=sc.sno;


SELECT student.*,
       cno,
       grade
FROM student,
     sc
WHERE student.sno=sc.sno;


SELECT first.cno,
       second.cpno
FROM course FIRST,
            course SECOND
WHERE FIRST.cpno=SECOND.cno;


SELECT student.sno,
       sname,
       ssex,
       sage,
       sdept,
       cno,
       grade
FROM student LEFT OUT
JOIN sc ON (student.sno=sc.sno);


SELECT student.sno,
       sname
FROM student,
     sc
WHERE student.sno=sc.sno
  AND sc.cno='2'
  AND sc.grade>90;


SELECT student.sno,
       sname,
       cname,
       grade
FROM student,
     sc,
     course
WHERE student.sno=sc.sno
  AND sc.cno=course.cno;


SELECT sname
FROM student
WHERE sno IN
    (SELECT sno
     FROM sc
     WHERE cno='2');

 # 嵌套循环 子查询不能使用
ORDER BY 子句 # 子查询一定跟在比较符后
SELECT sno,
       cno
FROM sc x
WHERE grade>=
    (SELECT avg(grade)
     FROM sc y
     WHERE x.sno=y.sno);

 # 相关子查询
SELECT sname,
       sage
FROM student
WHERE sage< ANY
    (SELECT sage
     FROM student
     WHERE sdept='cs')
  AND sdept<>'cs';


SELECT sname,
       sage
FROM student
WHERE sage< ALL
    (SELECT sage
     FROM student
     WHERE sdept='cs')
  AND sdept<>'cs';

 # 用 聚集函数 比直接用 ANY /ALL 效率高
SELECT sname
FROM student
WHERE EXISTS
    (SELECT *
     FROM sc
     WHERE sno=student.sno
       AND cnoo='1');


SELECT sname
FROM student
WHERE NOT EXISTS
    (SELECT *
     FROM sc
     WHERE sno=student.sno
       AND cno=course.cno);

 # 全称量词
SELECT DISTINCT sno
FROM sc scx
WHERE NOT EXISTS
    (SELECT *
     FROM sc scy
     WHERE scy.sno='200215122'
       AND NOT EXISTS
         (SELECT *
          FROM sc scz.sno=scx.sno
          AND scz.cno=scy.cno));


SELECT *
FROM student
WHERE sdept='cs'
UNION
SELECT *
FROM student
WHERE sage<=19;


SELECT sno
FROM sc
WHERE cno='1'
UNION
SELECT sno
FROM sc
WHERE cno='2';


SELECT *
FROM student
WHERE sdept='cs' INTERSECT
  SELECT *
  FROM student WHERE sage<=19;


SELECT sno
FROM sc
WHERE cno='1' INTERSECT
  SELECT sno
  FROM sc WHERE cno='2';


SELECT *
FROM student
WHERE sdept='cs' EXCEPT
  SELECT *
  FROM student WHERE student WHERE sage<=19;


CREATE TABLE dept_age (sdept char(15), avg_age smallint);


INSERT INTO dept_age
SELECT sdept,
       avg(sage)
FROM student
GROUP BY sdept;


CREATE VIEW is_student AS
SELECT sno,
       sname,
       sage
FROM student
WHERE sdept='is' WITH CHECK OPTION;


CREATE VIEW is_s1(sno, sname, grade) AS
SELECT student.sno,
       sname,
       grade
FROM student,
     sc
WHERE sdept='is'
  AND student.sno=sc.sno
  AND sc.cno='1';


CREATE VIEW is_s2 AS
SELECT sno,
       sname,
       grade
FROM is_s1
WHERE grade>=90;


CREATE VIEW bt_s(sno, sname, sbirth) AS
SELECT sno,
       sname,
       2004-sage
FROM student;


CREATE VIEW s_g(sno, gavg) AS
SELECT sno,
       avg(grade)
FROM student
WHERE ssex='女';


DROP VIEW bt_s;


DROP VIEW is_s1 CASCADE;

 # 还删除了导出视图
INSERT INTO is_student
VALUES('200215129',
       '赵新',
       '20');

