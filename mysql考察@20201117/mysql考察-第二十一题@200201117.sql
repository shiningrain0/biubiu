# 题目21、写一个函数，checkScore(s_id) 返回该s_id的分数最高的科目对应的教师ID。
use test;
/*
写出查询语句
根据查询语句创建函数
调用函数
 */
 */
 */
DELIMITER $             /*定义结束符为$*/
create function checkScore(sid varchar(10))  /*定义函数名及其传入的参数名*/
returns varchar(10)                          /*设置返回值类型*/
begin
return (
    select
    t2.t_id                                 /*教师id*/
from
    course t                                /*课程表*/
inner join
    score t1                                /*成绩表*/
on
    t.c_id = t1.c_id and t1.s_id = sid
inner join
    teacher t2                              /*教师表*/
on
    t.t_id = t2.t_id
order by
    t1.s_score desc limit 1
        );

end$
/*调用函数*/
select checkScore('04')$
