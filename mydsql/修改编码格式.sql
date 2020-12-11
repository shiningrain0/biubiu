use runoob;
select * from websites;
select * from access_log;
select * from book;
show create table websites;
insert into book (id) values (1);
select * from access_log;
select * from book;
show create table book;
/*修改表的编码格式,但表中字段的编码格式并未被改变*/
alter table book default character set utf8;

# 修改整张表所有字段的编码格式
alter table book convert to character set utf8mb4;
show full columns from websites;
/*修改表字段的类型*/
alter table websites modify column alexa int(3) ;
