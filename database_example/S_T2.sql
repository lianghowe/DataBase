/*
author: lianghowe
*/
CREATE DATABASE S_T DEFAULT character
SET utf8;

 USE S_T
CREATE TABLE student(sno char(9) PRIMARY KEY, sname char(20) UNIQUE, ssex char(2),sage smallint, sdept char(20));

insert into student values('2001001','zhangsan','F',20,'IS')

insert into student values('2001002','lisi','F',21,'IS')

insert into student values('2001003','wangwu','M',22,'MATH')

insert into student values('2001004','liming','F',20,'IS')

insert into student values('2001005','zhaosi','M',21,'MATH')

insert into student values('2001006','zhangtao','F',20,'PHISIC')

alter table student add s_entrance datetime;

alter table student alter column sage int;

select * from student into outfile 'd:/l/github/数据库_例题/student.txt';


CREATE TABLE  Course
       ( Cno       CHAR(4) PRIMARY KEY,
         Cname  CHAR(40),
         Cpno     CHAR(4),               	                      
         Ccredit  SMALLINT,
        FOREIGN KEY (Cpno) REFERENCES  Course(Cno) 
    ); 

insert into course values('1','C',null,3)
insert into course values('2','C++','1',3)
insert into course values('3','DataStructure',null,3)
insert into course values('4','english',null,2)
insert into course values('5','write','4',3)
insert into course values('6','PHY',null,3)

alter table course add unique(cname)

select * from course into outfile 'd:/l/github/数据库_例题/course.txt';

insert into course values('7','PHY',null,3)

CREATE TABLE  SC
       	(Sno  CHAR(9),
       	Cno  CHAR(4),  
       	Grade    SMALLINT,
       	PRIMARY KEY (Sno,Cno),
                     /* 主码由两个属性构成，必须作为表级完整性进行定义*/
       	FOREIGN KEY (Sno) REFERENCES Student(Sno),
                    /* 表级完整性约束条件，Sno是外码，被参照表是Student */
       	FOREIGN KEY (Cno) REFERENCES Course(Cno)
                   /* 表级完整性约束条件， Cno是外码，被参照表是Course*/
		); 
insert into sc values('2001001','1',85)
insert into sc values('2001001','2',75)
insert into sc values('2001001','3',null)
insert into sc values('2001002','1',65)
insert into sc values('2001002','3',75)
insert into sc values('2001006','4',75)
insert into sc values('2001006','6',95)

select * from sc into outfile 'd:/l/github/数据库_例题/sc.txt';

CREATE VIEW IS_Student
	AS
	SELECT Sno,Sname,Sage
	FROM  Student
	WHERE Sdept='IS'

select * from IS_student

CREATE TABLE ttt          
	      (	Sno   CHAR(9) , /* 列级完整性约束条件*/                  
            	Sname  CHAR(20) UNIQUE,     /* Sname取唯一值*/
            	Ssex    CHAR(2),
            	Sage   SMALLINT,
            	Sdept  CHAR(20)
               );


CREATE CLUSTERED INDEX Stusname 
           ON   ttt(Sname);

insert into ttt values('2001001','zhangsan','F',20,'IS')

insert into ttt values('2001002','lisi','F',21,'IS')


select * from ttt into outfile 'd:/l/github/数据库_例题/ttt.txt';


select sno,sname,'birth day:' aaa,2014-sage birthday from student

select sname from student where sdept='IS'

select * from student where sage>20

select distinct sno from sc where grade<60

select sname,sage,sdept from student where sage not between 20 and 23

select sname,ssex from student where sdept not in ('IS','PHISIC')