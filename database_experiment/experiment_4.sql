 /*
 梁浩 2016118087
实验四
作业:
*/ -- 1.

SELECT sno,
       sname,
       dorm.*
FROM dorm,
     student
WHERE dno=1
  AND student.dormno=dorm.dormno
ORDER BY dorm.dormno;

-- 2
SELECT*
FROM student
WHERE dno=1
ORDER BY sex,
         sage DESC;
-- 3
SELECT sname,
       2003-sage BIRTHDAY
FROM student
WHERE dno=2;

-- 4
SELECT DISTINCT cno
FROM grade;

-- 5
SELECT sname,
       dormno
FROM student
WHERE sage BETWEEN 21 AND 23;


SELECT sname
FROM student
WHERE dno IN ('2',
              '3',
              '4');


SELECT *
FROM student
WHERE sname LIKE '张%';


SELECT *
FROM student
WHERE sname LIKE '__明%';


SELECT cname,
       teacher
FROM course
WHERE cpno IS NULL;


SELECT *
FROM student
WHERE dno=1
  AND sex='男';


SELECT count(sno)
FROM student
WHERE dno=1;


SELECT max(score),
       min(score),
       avg(score)
FROM grade,
     student
WHERE student.sno=grade.sno
  AND student.dno=1
  AND cno=01;


SELECT sname,
       sno
FROM student
GROUP BY sno HAVING count(*)>4;


SELECT DISTINCT head,
                dorm.dormno
FROM department,
     dorm,
     student
WHERE department.dno=student.dno
  AND student.dormno=dorm.dormno;


SELECT student.*,
       tele
FROM student,
     dorm
WHERE student.dormno=dorm.dormno;


SELECT first.cno Cno,
       second.cpno Pcno
FROM course FIRST,
            course SECOND
WHERE FIRST.cpno=SECOND.cno;


SELECT student.*,
       course.*
FROM student LEFT OUT
JOIN course ON (student.sno=grsde.sno
                AND course.cno=grade.cno);


SELECT sname,
       student.sno,
       cname,
       teacher
FROM student,
     grade,
     course
WHERE student.sno=grade.sno
  AND course.cno=grade.cno;


SELECT sname,
       tele
FROM student,
     dorm,
     department
WHERE student.dno=department.dno
  AND department.head='秦峰'
  AND dorm.dormno=student.dormno;


SELECT sname,
       sage
FROM student x,
     department
WHERE department.dname='计算机系'
  AND x.dno<>department.dno
  AND sage>
    (SELECT max(sage)
     FROM student y
     WHERE department.dname='计算机系'
       AND y.dno=department.dno);


SELECT sno
FROM grade
GROUP BY sno HAVING min(score)>=60;


SELECT DISTINCT sno
FROM grade
WHERE EXISTS
    (SELECT*
     FROM grade
     WHERE cno='01')
  AND EXISTS
    (SELECT*
     FROM grade
     WHERE cno='02');


SELECT DISTINCT sno
FROM grade x
WHERE NOT EXISTS
    (SELECT *
     FROM grade y
     WHERE y.sno=990102
       AND NOT EXISTS
         (SELECT *
          FROM grade z
          WHERE z.sno=x.sno
            AND z.cno=y.cno));


SELECT *
FROM student
WHERE cno=1 EXCEPT
  SELECT *
  FROM student WHERE sage>20;


SELECT*
FROM student s
WHERE s.sno=grade.sno
  AND grade.cno=course.cno
  AND course.cname='数据库原理' INTERSECT WHERE s.sno=grade.sno
  AND grade.cno=course.cno
  AND course.cname='高等数学';


CREATE VIEW view_1(sno, sname, sex, birth, sage, dno, dormno) AS
SELECT sno,
       sname,
       sex,
       2003-sage,
       sage,
       department.dno,
       dormno
FROM student s,
     department
WHERE s.dno=department.dno
  AND department.dname='计算机系';


SELECT sno,
       sname,
       dormno
FROM view_1
WHERE sname LIKE '%原%';


UPDATE view_1
SET sage=23,
    dormno=2202
WHERE sname='李军';

