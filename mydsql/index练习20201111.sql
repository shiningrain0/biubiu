use data;
# 查看loan表结构
desc loan;
# 为loan表的username创建索引Um
create index Um on loan(username);
# 查看表loan的索引
show index from loan;
# 由于；loan表重复数据较多，因此不在loan表中添加主键，为b表的id添加主键
alter table b add primary key(id);
create unique index nm on a(name);
# 查看b表的索引
show index from b;
show index from a;
# 创建联合索引
create index index_nm on loan(shop,series);
# 创建全文索引
create fulltext index index_ab on a(name);
alter  table b add fulltext index_ab(name);
# 删除表索引
drop index index_ab on b;
alter table a drop index index_ab;
# 显示表结构等信息
explain a;
#给出相关索引信息
explain select * from a;
desc  a;
select * from a;
update a set id = 9 where id = 4;
# 创建银行账户表
create table if not exists savemoney(
    `name` varchar(20) not null primary key comment'账户人姓名',
    `account` decimal(20,2) comment'账户余额',
    sex varchar(2) comment'性别',
    age tinyint(20) comment'年龄'
)engine=InnoDB default charset=utf8 comment'银行账户表';
# 创建理财账户
create table if not exists finace(
    `name` varchar(20) not null primary key comment'账户人姓名',
    `ammount`decimal(20,2) not null default 0 comment'账户',
    sex varchar(2) comment'性别'
)engine=InnoDB default charset=utf8 comment'理财表';
# 向银行账户表中插入数据
insert into
    savemoney(name,account,sex,age)
values
    ('张三',2500,'男',23),
    ('李四',20,'男',22),
    ('王五',500,'女',19),
    ('陈尔',5000,'男',28);
select * from person_account;
# 向理财账户中插入数据
insert into
    finace(name,sex)
values
    ('张三','男'),
    ('李四','男'),
    ('王五','女'),
    ('陈尔','男');
select * from finace;
# 给表重命名
rename table savemoney to person_account;
# 增加字段
alter table b add per_account decimal(20,2) comment'取钱数量';
# 删除字段
alter table b drop column per_account;
desc b;
# 创建事务
start transaction;
update person_account set account = account - 200 where name='张三';
update finace set ammount = ammount + 200 where name = '张三';
commit;
# 创建事务并执行
 set autocommit=0;
begin;
update person_account set account = account - 200 where name='张三';
update finace set ammount = ammount + 200 where name = '是的供货商';
rollback;
commit;
# 查看person_account
select * from person_account;
select * from finace;
# 设置字段值必须大于等于0
alter table person_account add check(account >= 0);
set session transaction isolation level read uncommitted;
start transaction;
select * from person_account;
update person_account set account = account -50 where name = '李四';
commit;