# 题目18、查询各科成绩最高分、最低分和平均分：
# 以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
# 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
use test;
/*
分析：
通过课程id将成绩表与课程表进项关联
依据课程id进行分组
使用max()函数计算课程最高分
使用min()函数计算课程最低分
使用avg()函数计算课程平均分
通过case when语句进行条件筛选计算及格率、中等率、优良率、优秀率
此处在计算中等率以及优良率采用的是左闭右开
*/
select
     t.c_id                  /*课程id*/
    ,t1.c_name               /*课程名称*/
    ,max(t.s_score)  max     /*最高分*/
    ,min(t.s_score)  min     /*最低分*/
    ,avg(t.s_score)  avg     /*平均分*/
    ,round(sum(case when t.s_score >= 60 then 1 else 0 end)/count(s_id),2) a1                        /*及格率*/
    ,round(sum(case when t.s_score >= 70 && t.s_score < 80 then 1 else 0 end)/count(s_id),2) a4      /*中等率*/
    ,round(sum(case when t.s_score >= 80 && t.s_score < 90 then 1 else 0 end)/count(s_id),2) a3      /*优良率*/
    ,round(sum(case when t.s_score > 90 then 1 else 0 end)/count(s_id),2) a2                         /*优秀率*/
from
    score t                 /*成绩表*/
left join
    course t1               /*课程表*/
on
    t.c_id = t1.c_id
group by
    t.c_id;



