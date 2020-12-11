/*创建数据库data*/
create database data;
use data;
/*在data数据库中创建loan表*/
create table loan(
    id varchar(255),
    shop varchar(255),
    username varchar(255),
    Manufacturers varchar(255),
    brand varchar(255),
    series varchar(255),
    models varchar(255),
    loandate timestamp(6),
    company varchar(255),
    price char(255)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*将数据表loan中的price数据类型由char更改为double */
alter table loan modify column price double(6,1);
desc loan;
/*计算表loan中price平均数，并命名为AVG*/
select AVG(price) AVG from loan ;
/*筛选出price大于price平均数的用户名称以及他们的price*/
select username,price from loan where price>(select avg(price) from loan);
/*selct count(column_name)与select count(*)的区别：
  count(*) 在执行时无论是否含有null值都将被列入计数
  count(column_name)在执行时，如果为null则不进行计数，如果不为null则不进行计数
  */
select count(username) from loan;
select count(3) from loan;/*由于此表中的username字段不含null值，因此count(column_name与count(*)的执行结果相同*/
select count(distinct Manufacturers)  as Manufacturers from loan;/*从loan表格中筛选出厂商的个数*/
select distinct Manufacturers from loan;
select Manufacturers, count(1) from loan group by Manufacturers;
/*first以及last 仅在MS Access中支持使用，在mysql中使用正逆排序来获取第一条以及最后一条数据*/
select username from loan order by id ASC limit 1;
select username from loan order by id DESC limit 1;
select price from loan order by price desc;
/*筛选出指定列最大的数*/
select max(price) from loan;
select max(username) from loan;
select max(id) from loan;
select min(Manufacturers) as min,max(Manufacturers) as max from loan;
select sum(price) from loan;
select Manufacturers,sum(price) as num  from loan group by Manufacturers;
select Manufacturers,sum(price) as num  from loan left join  group by Manufacturers;
select Manufacturers,count(distinct series) as seriesNUM,sum(price) as nums  from loan group by Manufacturers;

show grants;
create user su identified by 'su';

flush privileges;
show grants for su;
#删除用户
delete from mysql.user where user='su';
drop user 'su'@'localhost';
create user 'su'@'127.0.0.1' identified by 'su';
#刷新用户权限
flush privileges;
show grants for su;
revoke delete on *.* from su@'127.0.0.1';
grant insert on *.* to 'su'@'127.0.0.1';
grant update on data.a to 'su'@'localhost';
grant all privileges on *.* to 'su'@'localhost';
select host, user from mysql.user;
