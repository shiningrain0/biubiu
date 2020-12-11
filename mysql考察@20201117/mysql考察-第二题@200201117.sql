# 题目2、查询"01"课程比"02"课程成绩低的学生的信息及课程分数
use test;
/*
分析：
1、此题会用到的表有学生表(Student)、成绩表(Score)
2、将Score表进行自关联,分别查找课程号为01 和课程号为02 的学生id 创建临时表
3、对查找出来的结果通过where条件进行筛选，得到课程01成绩高于课程02的学生信息及分数
*/
select
     t1.s_id                    /*学生号*/
    ,t1.s_name                  /*学生姓名*/
    ,t1.s_birth                 /*学生生日*/
    ,t1.s_sex                   /*学生性别*/
    ,t2.c_id                    /*课程01*/
    ,t2.s_score                 /*学生成绩*/
    ,t3.c_id                    /*课程02*/
    ,t3.s_score                 /*学生成绩*/
from
     Student t1                /*学生表*/
inner join
     Score t2                 /*成绩表*/
on
    t1.s_id = t2.s_id and t2.c_id =01
inner join
    Score t3                  /*成绩表*/
on
    t1.s_id = t3.s_id and t3.c_id = 02
where
    t2.s_score < t3.s_score;