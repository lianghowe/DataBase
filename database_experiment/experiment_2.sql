/*
梁浩 2016118087
实验2
作业1: 创建 student_data数据库
*/
CREATE DATABASE student_data DEFAULT character
SET utf8;

 USE student_data
 drop TABLE course, student, department, dorm, grade;
CREATE TABLE student(sno char(6) NOT NULL UNIQUE, sname char(9) NOT NULL, sex char(3), sage int, dno char(4), dormno char(5));


CREATE TABLE course(cno char(2) NOT NULL UNIQUE, cname char(20) NOT NULL, cpno char(2), credit int, teachar char(8));


CREATE TABLE department(dno char(4) NOT NULL UNIQUE, dname char(20) NOT NULL, head char(20));


CREATE TABLE dorm(dormno char(5) NOT NULL UNIQUE, tele char(7));

CREATE TABLE grade(sno char(6), cno char(2), score decimal(4, 1));

 LOAD DATA LOCAL infile "D:/l/github/DataBase/database_experiment/course.txt" INTO TABLE course lines terminated BY '\r\n';

 LOAD DATA LOCAL infile "D:/l/github/DataBase/database_experiment/grade.txt" INTO TABLE grade;

 LOAD DATA LOCAL infile "D:/l/github/DataBase/database_experiment/dorm.txt" INTO TABLE dorm;

 LOAD DATA LOCAL infile "D:/l/github/DataBase/database_experiment/department.txt" INTO TABLE department lines terminated BY '\r\n';

 LOAD DATA LOCAL infile "D:/l/github/DataBase/database_experiment/student.txt" INTO TABLE student lines terminated BY '\r\n';


UPDATE grade
SET score=NULL
WHERE sno=990102
  AND cno=01;


UPDATE grade
SET score=NULL
WHERE sno=990105
  AND cno=06;


SELECT *
FROM course;


SELECT *
FROM grade;


SELECT *
FROM dorm;


SELECT *
FROM department;


SELECT *
FROM student;

 -- 作业2: 创建 student 聚簇索引

create cluster index stusno on student(sno);
 -- 创建 grade 复合索引

ALTER TABLE grade ADD INDEX index_name (sno, cno);


