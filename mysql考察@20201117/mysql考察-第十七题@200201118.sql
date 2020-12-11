use test;
# 题目17、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
/*
分析：
通过学生id将学生表与成绩表关联
使用学生id进行分组
根据学生的平均分从高到低输出学生成绩
 */
# 学生平均成成绩从高到低排序
select
     t.*                    /*学生信息*/
    ,if(round(avg(t1.s_score),2) is null,0,round(avg(t1.s_score),2))        /*平均成绩*/
from
    student t               /*学生表*/
left join
    score t1                /*成绩表*/
on
    t.s_id = t1.s_id
group by
    t1.s_id
order by
    avg(t1.s_score) desc;
# 依据学生平均成绩进行排序输出
select
    t.*,                     /*学生信息*/
    GROUP_CONCAT(t1.s_score) score   /*学生成绩*/
from
    student t               /*学生表*/
left join
    score t1                /*成绩表*/
on
    t.s_id = t1.s_id
group by
    t.s_id
order by
 avg(t1.s_score) desc;


