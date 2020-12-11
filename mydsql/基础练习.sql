use runoob;
select * from websites;
select * from access_log;

select * from websites where name like '_oogle';
select * from websites where name regexp '^[GFs]';
select * from websites where name regexp '^[^A-H]';

select * from websites where name in ('Google', '菜鸟教程');

select * from access_log;
select * from access_log where date between '20160510' and '20160514';
select date from access_log;
select * from websites  where url like '%www%';
select * from websites where url like '%fac%';
select * from websites where url like '%t_o_%';
select * from websites where name regexp '^[A-H]';
select * from websites where name in ('Google');
select * from websites where alexa between 1 and 4;
select name as names,country as city from websites;
select name,concat(url,',',alexa,',',country) as site_info from websites;
select w.name,w.url,a.count,a.date from websites as w,access_log as a where a.site_id = w.id and w.name ="菜鸟教程";

select websites.id, websites.name, access_log.count, access_log.date
from websites
         inner join access_log on websites.id = access_log.site_id;
select websites.id,websites.name,access_log.count,access_log.date from websites left join access_log on websites.id=access_log.site_id;
select websites.name,access_log.count,access_log.date from websites inner join access_log on websites.id=access_log.site_id order by access_log.count;
select websites.name,access_log.count,access_log.date from websites left join access_log on websites.id = access_log.site_id order by access_log.count desc;

select websites.name, access_log.count, access_log.date
from websites
         right join access_log on (websites.id = access_log.site_id)
where websites.name is null
order by access_log.count desc;
delete from websites where id = 7;
select count(*) from websites;
select * from websites where country = 'USA' and alexa > 10;
select * from websites where id = 6 or name = '菜鸟教程';
select * from websites order by alexa asc;
select * from websites order by name desc;
/*SELECT DISTINCT 列中仅选取唯一不同的值*/
select distinct country from websites;
select id,url,alexa from websites where name in ('Google','淘宝','菜鸟');
select count(country) from websites where country ='CN';
select * from websites where name like'%oo%';
select country,sum(alexa) from websites group by country having sum(alexa)>100;
insert into websites(id,name,url,alexa,country) values (8,'特警','www.bing.com',26564,'JP');
insert into websites(id,name,url,alexa,country) values (9,'特警','www.bing.com',26564,'JP');
insert into websites(id,name,url,alexa,country) values (10,'特警','www.bing.com',26564,'JP');

update websites set name = '数码宝贝' where name = '特警';
create table book(
    id int(100),
    names varchar(255),
    price char(255),
    dates DATE,
    primary key(id)
);
show create table book;
drop table book;
show tables;
/*创建表索引*/
create index bo on book (names);
/*查看所有的表索引*/
show index from book;
/*删除表索引*/
drop index bo on book ;
/*创建表的唯一索引*/
create unique index bo on book(names);
create index max on websites(alexa desc);
show index from websites;
drop index max on websites;
select * from websites;
/*选择显示信息的条数*/
select * from websites limit 2;
/*select * from website where rownum <= 2;  oracle用法*/
/*选取包含指定内容的数据*/
select * from websites where url like '%oo%';
select * from websites where name like 'F%';
select * from websites where url like '%.com';
/*选取不包含指定内容的数据*/
select * from websites where url not like '%.com';
select * from websites where name like'Face_ook';
/*以指定内容范围内开头的数据*/
select * from websites where name regexp '^[GF]';
/*不以指定内容范围内开头的数据*/
select * from websites where name regexp '^[^GF]';
select * from websites where country in ('CN','JP');
select * from websites where alexa between 100 and 1000;
/*为列名称以及表名称指定别名*/
select url from websites as web;
select url as web from websites;
select name,url,country from websites as se  where alexa = 13 or name = '菜鸟';
/*将两个表的数据进行连接*/
select * from websites,access_log where websites.id = access_log.aid;
/*使用join将两个表的数据进行连接*/
select *
from websites
         inner join access_log on websites.id = access_log.aid
order by alexa;
select * from websites left join access_log on websites.id = access_log.site_id;
select * from websites right join access_log on websites.id = access_log.site_id;
select id from websites union select date from access_log;
alter table access_log add city varchar(100);
select id from websites union all select date from access_log;
select distinct id from (select id from websites union all select date as id from access_log) as tmp;
/*mysql不支持select into from 语句，因此使用西你的方式代替*/
create table newTable (select * from websites);
select * from book;
/*将只当数据表中的摸一张字段数据加入另一张表中（必须有ID,id为主键）*/
insert into book (id, names)  select 3 as id, country as names from websites where id = 1;
create table books(
    id int not null check(0 < id <20),
    name varchar not null,
)
insert into book(id,names) values (4,'desert');
insert into book(id,price) values (5,20.3);
insert into book(id,names) values (7,'动物庄园');
select book.id,book.names,websites.name from book inner join websites on book.id = websites.id;
select book.id,book.names,websites.name from book left join websites on book.id = websites.id;
select book.id,book.names,websites.name from websites left join book on book.id = websites.id;
/*mysql不支持full join
  select * from book full join websites on book.id= websites.id;*/
/*当表已经被创建，给某一列数据增加unique约束*/
alter table book add unique(names);
/*删除表中某个关键字的约束*/
alter table book drop index names;
/*修改unique约束名称 */
alter table book add constraint sd unique(names);
desc book;
/*撤销primary key 约束*/
alter table websites drop primary key;
alter table websites add primary key(id);
desc websites;
desc access_log;
desc book;
desc newTable;
/*alter table boo
alter table newTable add foreign key (id) reference book (id);
alter table access_log add constraint fk foregin key(id) reference book(id);*/??

desc book;
describe book;
show full fields from book;
alter table book add check( id > 0);
/*insert into book(id,names) values (-1,'sds'); 约束条件未生效，在mysql8以前没有强制检查*/
select * from book;
/*向列中插入默认值，当在插入表中内容时，没有该值，会直接插入默认值*/
alter table book alter dates set default '2020-11-4';
insert into book(id,names) values (6,'sds');
desc book;
show index from book;
drop index sd on book;
/*清空表数据*/
truncate table newTable;
select * from newTable;
/*清楚表字段*/
alter table newTable drop column alexa;
update book set dates  = null where id = 6;
alter table book add country varchar(255);
alter table book drop country;
delete from book where id = 1;
/*在修改字段吗名称时必须加上字段的数据类型*/
alter table book change da date int;
/*在mysql中更改数据类型需要使用modify 不能支持使用change以及alter */
alter table book modify column dates int;
/*auto increrment自增字段*/
create table person(
    id int not null auto_increment,
    firstName varchar(255) not null,
    lastName varchar(255),
    age smallint(130),
    city varchar(255),
    primary key(id)
)engine InnoDB default charset utf8mb4;
insert into person(firstName,age,city) values('Toms',26,'中国');
insert into person(firstName,age,city) values('Toms',32,'法国');
insert into person set lastName = 'Edision',firstName = 'Charli' ;
select * from person;
/*视图*/??
create view full_name as select firstName,lastName from person where city is not null;
create or replace view full_name as select firstName,lastName from person where city is null;
select * from full_name;
drop view full_name;
/*查看数据库中含有指定字段的表名 也可使用模糊查询*/
select * from information_schema.columns where column_name = 'date';
/*使用查询指定数据库中的字段名时将数据库名信息加入where条件中 同时还可加入数据类型table_type*/
select table_name from information_schema.columns where table_schema='runoob' and column_name = 'city';
select * from access_log;
select * from book;
alter table book modify column date  datetime;
select * from access_log where date ='2016-05-15';
insert into access_log(aid,date) values(12,now());
insert into book(id,date) values(8,'2020-2-23 12:22:36');
select curdate();
select now();
select curtime();
select date(now());
select day('2020-12-3') day,
       month('2020-12-3') month,
       quarter('2020-12-3') quarter,
       year('2020-12-3') year;
select datediff('2012-2-3','2012-3-6');
/*计算两个日期之间的间隔天数以及周数使用timestampdiff*/
select timestampdiff(day,'2012-5-23','2020-11-3') day;
select timestampdiff(week,'2012-6-30','2020-11-7') week;
select to_days('2020-5-23') - to_days('2020-3-22');/*等价于select timestampdiff(day,'2012-5-23','2020-11-3')*/
select timestampdiff(hour,'2012-6-30','2020-11-7') hour;
select timestampdiff(minute,'2012-6-30','2020-11-7') minute;
select timestampdiff(second,'2012-6-30','2020-11-7') second;
/*mysql内置函数 实现两日期间的秒数差*/
select unix_timestamp('2020-11-4') - unix_timestamp('2020-3-12');
select sec_to_time(unix_timestamp('2020-11-6') - unix_timestamp('2020-3-2'));/*返回秒参数，转化为小时，分钟，秒*/
select sec_to_time(235);
select '2020-11-4' start,date_sub('2020-11-4',interval 3 hour);/*在未指定日期时间时，默认是从00：00：00开始算*/
select '2020-3-5 12:23:11' start,date_sub('2020-3-5 12:23:11',interval 5 hour);
select '2020-6-5' start,date_sub('2020-6-5',interval 3 week) 'there weeks before';
select * from access_log;
select * from book where price is null;
select * from book where price is not null;
update access_log set count = null where count = 0;
select date,aid*(site_id+isnull(count,0)) from access_log;
select websites.name,count(access_log.aid) as num from access_log left join websites
on access_log.site_id = websites.id group by websites.name;
select * from websites full join access_log;
select count(*) from access_log;
/*以websites.name为分组依据，查询access_log中访问量大于200的数据*/
select websites.name,sum(access_log.count) as num from (access_log inner join  websites
on access_log.site_id=websites.id) group by websites.name having sum(access_log.count)>200;
/*查询websites表中国url访问次数超过两百的数据*/
select websites.name,websites.url from websites where exists(select count from access_log where
websites.id = access_log.site_id and count >200);
/*在sql中的ucase 函数相当于mysql中的upper 将字段值转换为大写格式*/
select upper(url) as upperUrl from websites;
/*在sql中的lcase 函数相当于mysql中的lower 将字段值转换为大写格式*/
select lower(url) as lowerUrl from websites;
/*截取指定字符串的长度*/
select mid(name,1,3) as short from websites;
select RIGHT('NAME',2) as rightname;
select left('NAME',2) AS RIGHTNAME;
/*从字符串第三个字符开始截取四个字符*/
select substring('www.baidu.com',3,4);
/*从字符串的倒数第三个字符开始截取四个字符，若长度不够则仅显示有的部分 在此函数substring(str,pos,len)中，pos可以取负但是length不能*/
select substring('www.baidu.com',-3,4);
/*截取特定字符前后的字符使用substring_index()函数，取字符前还是字符后使用正负来进行区分*/
select substring_index('www.baidu.com','.',2);
select substring_index('www.baidu.com','.',-1);

select substring_index('www.baidu.com','com');
/*在指定字符传中查找指定字符若该字符不存在（返回1，则表示返回原字符串，返回0则表示返回一个空的结果集）*/
select substring_index('www.baidu.com','.cn',1);
select substring_index('www.baidu.com','.cn',0);
select substring_index('www.baidu.com','.com',1);
select name,length(name) from websites;
select ceil(2.3);
select floor(2.3);
/*将websites表中的date更新为当前系统时间*/
select name ,url,now() as date from websites;
select name ,url,date_format(now(),'%Y/%m/%d') as date from websites;






