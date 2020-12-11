use sys;
# 销售报表
drop table report_0;
create table if not exists report_0(
    pro_id varchar(20) not null primary key comment'产品编号',
    pro_nm varchar(20) not null comment'产品名称',
    res_nu int(11) default 0 comment'剩余库存数量',
    unit varchar(11) comment'基本单位'
)engine=InnoDB default charset=utf8 comment'基本表';
drop table report_1;
create table if not exists report_1(
    `date` datetime comment'时间',
    amount int(11) comment'数量',
    pri_sig decimal(28,2) comment'单价',
    price decimal(28,2) comment'金额',
    pro_id varchar(20) not null comment'产品编号',
    foreign key(pro_id)
    references report_0(pro_id)
)engine=InnoDB default charset=utf8 comment'月表';

select * from
    report_0 t1                                 /*基本表*/
inner join
    report_1 t2                                 /*月表*/
on
    month(t1.pro_id) = month(t2.pro_id)             /*当月表的月份等于基本表的月份*/
where
    month(t2.date) >1 and month(t2.date) < 10;  /*在此设定月份条件*/


# 基础进销存表
drop table basic;
create table if not exists basic(
    pro_id varchar(20) not null primary key comment'产品编号',
    pro_nm varchar(20) not null comment'产品名称',
    unit varchar(11) comment'基本单位',
    foreign key(pro_id)
    references report_0(pro_id)
)engine=InnoDB default charset=utf8 comment'进销存基本表';
# 初期存货
create table if not exists fir_sav(
    pro_id varchar(20) not null primary key comment'产品编号',
    amount int(11) comment'数量',
    pri_sig decimal(28,2) comment'单价',
    price decimal(28,2) comment'金额'
)engine=InnoDB default charset=utf8 comment'期初存货';
# 本月采购表
create table mon_buy like fir_sav ;
alter table fir_sav comment'本月采购';
#本月销售表
create table if not exists fir_sel(
    pro_id varchar(20) not null primary key comment'产品编号',
    amount int(11) comment'数量',
    all_amo decimal(28,2) comment'销售总额'
)engine=InnoDB default charset=utf8 comment'本月销售';
# 本月减退货
create table if not exists fir_sel_red(
    pro_id varchar(20) not null primary key comment'产品编号',
    amount int(11) comment'数量',
    amo_ret decimal(28,2) comment'合计退款'
)engine=InnoDB default charset=utf8 comment'本月减退货';
# 期末存货
create table if not exists sel_red(
    pro_id varchar(20) not null primary key comment'产品编号',
    amount int(11) comment'数量',
    amo_ret decimal(28,2) comment'总金额'
)engine=InnoDB default charset=utf8 comment'期末存货';
select * from
    basic t                     /*进销存基本表*/
left join
    mon_buy t1                  /*期初存货*/
on
    t.pro_id = t1.pro_id
left join
    fir_sav t2                  /*本月采购*/
on
    t.pro_id = t2.pro_id
left join
    fir_sel t3                  /*本月销售*/
on
    t.pro_id = t3.pro_id
left join
    fir_sel_red t4              /*本月减退货*/
on
    t.pro_id = t4.pro_id
left join
    sel_red t5                  /*期末存货*/
on
    t.pro_id = t5.pro_id;
# 进销存报表
create table if not exists sel_repo(
    id int(11) primary key comment'id',
    com_nm varchar(20) comment'公司名称',
    com_id varchar(20) comment'公司id',
    ear_str_acc int(11) default 0 comment'期初小店数量',
    las_str_acc int(11) default 0 comment'期末小店数量',
    per_mon_acc int(11) default 0 comment'本月新增小店数量',
    per_tran int(11) default 0 comment'本月交易小店数量'
)engine=InnoDB default charset=utf8 comment''
