 /*
梁浩 2016118087
实验3
作业:
*/ -- 1.插入学生记录

INSERT INTO student
VALUES('980101','陈红','女',
       21,
       '4',
       '2303');

 -- 2.插入院系

INSERT INTO department
VALUES('5',
       '历史系',
       );

 -- 3.创建, 插入 Grade1

CREATE TABLE grade1(sno char(6), cno char(2), score decimal(4, 1));


INSERT INTO grade1
SELECT *
FROM grade
WHERE sno like '99%'
  AND cno=01
  AND score IS NULL;

 -- 4.修改陈红

UPDATE student
SET sname='陈弘',
          sage=20
WHERE sno=980101;

 -- 5.course

UPDATE course
SET credit=credit+2
WHERE cpno IS NULL;

 -- 6.0

UPDATE grade
SET score=0
WHERE sno=
    (SELECT sno
     FROM student
     WHERE dno=3)
  AND cno=01;

 -- 7.0 删除 98 级

DELETE
FROM student
WHERE sno LIKE '98%';
