create database car;
drop database car;
show databases;
use data;
show create table loan;
/*创建a表*/
create table a(
    id int(20),
    name varchar(10)
)ENGINE = InnoDB default charset = utf8;
alter table a add primary key(id);/*为id 添加主键*/
select * from a;
/*向a表中插入数据*/
insert into a(id,name) values(1,'a1'),(2,'a2'),(3,'a3'),(4,'a4');
/*创建b表*/
create table b(
    id int(20) not null,
    name varchar(20)
)ENGINE = InnoDB default charset = utf8;
/*向b表中插入数据*/
insert into b(id,name) values(1,'a1'),(2,'a5'),(3,'a2'),(4,'a1');
select * from b;
/*以a表为主表,b表为副表,进行内关联*/
select * from a inner join b on a.name = b.name;
/*以a表为主表,b表为副表,进行左关联*/
select a.name,b.name from a left join b on a.name = b.name;
/*以a表为主表,b表为副表,进行右关联*/
select a.name,b.name from a right join b on a.name = b.name;
/*以a表为主表,b表为副表,进行右关联*/
select * from a full join b;
select a.id,a.name,b.id,b.name from a,b;