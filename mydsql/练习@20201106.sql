use dshop_alpha;
select * from ddd_acty_info;
desc ddd_provr;
/*查看库中的表信息*/
select * from information_schema.tables where table_schema = 'dshop_alpha' and table_name = 'ddd_provr';
select column_name, column_comment from information_schema.columns where table_schema = 'dshop_alpha' and table_name = 'ddd_provr';
/*1.	在供应商表(ddd_provr)查询供应商”西藏演示供应商”的ID,供应商ID,供应商名称,供应商地址,供应商手机号码。*/
explain select ID,Provr_Id,Provr_Nm,Provr_Addr,Provr_Mobl_Num from ddd_provr where Provr_Nm = '西藏演示供应商';
/*2.	在用户表(ddd_usr)查询供应商”西藏演示供应商”的所有用户(通过供应商ID查询)*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_usr';
select Provr_Id from ddd_usr;
select Usr_Id from ddd_usr where Provr_Id = 'PR102400000000000195' ;

select * from ddd_usr t1 inner join ddd_provr t2 on t2.Provr_Id = t1.Provr_Id where t2.Provr_Nm = '西藏演示供应商';

/*3.	在用户表(ddd_usr)查询用户名称为”江河”的用户的用户名称和用户密码*/
select Usr_Nm,Logon_Pwd from ddd_usr where Usr_Nm = '江河';
/*4.	在订单表(ddd_ordr)查询创建时间为今年的所有订单*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_ordr_info';
select * from ddd_ordr_info where YEAR(Crt_Tm)=Year(now());
/*5.	在订单表，订单关系表(ddd_ordr和ddd_ordr_shop_rel)查询小店”测试0609店铺”的所有订单(小店表为ddd_dshop_info)*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_ordr_info';
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_ordr_shop_rel';
select *  from ddd_ordr_info,ddd_ordr_shop_rel where ddd_ordr_info.Ordr_Id = ddd_ordr_shop_rel.Ordr_Id and Shop_Nm = '测试0609店铺';

select * from ddd_ordr_info t inner join ddd_ordr_shop_rel t1 on t.Ordr_Id = t1.Ordr_Id where t1.Shop_Nm= '测试0609店铺';

/*6.	在小店表(ddd_dshop_info)中查询所有名称带有”测试”的小店*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_dshop_info';
select ddd_dshop_info.Shop_Nm from ddd_dshop_info where Shop_Nm like '%测试%';
/*7.	在小店表(ddd_dshop_info)中查询所有创建时间在2020年的小店*/
select * from ddd_dshop_info where year(Crt_Tm) = 2020;
/*8.	在订单表(ddd_ordr_info)中查询所有发货时间在2020年8月到2020年11月之间的订单*/
select * from ddd_ordr_info where month(Delv_Tm) between '8' and '11' and year(Delv_Tm) = 2020;
/*9.	在订单表(ddd_ordr_info)中查询所有状态为待发货的订单。*/
desc ddd_ordr_info;
show columns from ddd_ordr_info;
describe ddd_ordr_info;
#需要注意数据类型
select * from ddd_ordr_info where Ordr_Stat = 03;
/*10.	在订单表(ddd_ordr_info)中查询所有现付订单*/
select  * from ddd_ordr_info where Ordr_Typ = 1;
/*11.	在订单表(ddd_ordr_info)查询所有商品数量(Ordr_Qty)大于10的订单并计算这些订单的应收金额,实收金额(Provr_Recvbl_Amt,Provr_Actl_Amt)*/
select Ordr_Id,sum(Provr_Recvbl_Amt) as pcmount,sum(Provr_Actl_Amt) as rcmount from ddd_ordr_info where Ordr_Qty > 10 group by Ordr_Id;
/*12.	在订单支付表(ddd_ordr_pmt)查询所有已经支付成功的订单并计算支付总金额*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_ordr_pmt';
select Ordr_Pmt_Id,sum(Pmt_Totl_Prc) from ddd_ordr_pmt where Pmt_Stat = 1;
/*13.	在订单表(ddd_ordr_info)表查询所有更改过商品数量的订单*/
select * from Modi_Ordr_Qty Ordr_Qty
select * from ddd_ordr_info where Modi_Ordr_Qty != Ordr_Qty;
/*14.	在商品表(ddd_gds_info)查询所有供应商”西藏演示供应商”的商品(展示字段为:商品名称,品牌名称,三级分类名称)*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_gds_info';
select Gds_Nm,Brand_Nm,Lvl3_Cls_id from ddd_gds_info,ddd_provr where ddd_provr.Provr_Id = ddd_gds_info.Provr_Id;

select * from ddd_gds_info t inner join ddd_provr t1 on t.Provr_Id = t1.Provr_Id where t1.Provr_Nm ='西藏演示供应商';

/*15.	在分类表(ddd_gds_cls_info)表查询”食品果蔬”分类下的所有分类*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_gds_cls_info';
select Cls_Id from ddd_gds_cls_info where Cls_Nm = '食品果蔬' ;

select App_Cls_Nm from ddd_gds_cls_info where Par_Cls_Id =(select Cls_Id from ddd_gds_cls_info where Cls_Nm = '食品果蔬') ;
/*16.	在小店供应商合作表(ddd_dshop_fst_co)查询供应商”西藏演示供应商”所有的合作小店(展示字段为:供应商名称,小店名称,首次下单时间)*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_dshop_fst_co';
select * from ddd_dshop_info;
select Provr_Nm,Shop_Nm,Fst_Ordr_Tm from ddd_dshop_fst_co,ddd_provr,ddd_dshop_info where ddd_dshop_fst_co.Provr_Id = ddd_provr.Provr_Id and ddd_dshop_info.Shop_Id = ddd_dshop_fst_co.Shop_Id;

select * from ddd_dshop_fst_co t inner join ddd_provr t1 on t.Provr_Id = t1.Provr_Id inner join ddd_dshop_info t2 on  t.Shop_Id = t2.Shop_Id where t1.Provr_Nm = '西藏演示供应商';

/*17.	品牌”清水”是谁创建的？(品牌表:ddd_gds_brand)*/
select column_name,column_comment from information_schema.columns where table_schema ='dshop_alpha' and table_name = 'ddd_gds_brand';
select Usr_Nm from ddd_usr where Usr_Id =(select Crtr_Id from ddd_gds_brand where Brand_Nm = '清水');
select ddd_usr.Usr_Nm FROM ddd_usr inner join ddd_gds_brand on ddd_usr.Usr_Id = ddd_gds_brand.Crtr_Id where ddd_gds_brand.Brand_Nm = '清水';

select table_name,column_comment from information_schema.columns where table_schema='dshop_alpha' and column_name = 'Brand_Id';

/*18.	删除测试表(ddd_test)中所有name为”中”的数据*/
delete  from ddd_test where name = '中';
select * from ddd_test;
/*19.	在品牌表添加一个”中国移动”品牌，且品牌状态为审批中*/
insert  into  ddd_gds_brand(Brand_Id,Brand_Nm,Brand_Stat,Crt_Tm) values('BD102400000000000548','中国移动',1,now());
/*20.	在活动表(ddd_acty_info)查询所有还未过期的活动且按时间倒序排列*/
select * from ddd_acty_info where Acty_End_Tm > now() order BY Acty_End_Tm DESC;
/*21.	在表(ddd_test)添加一个age字段*/
alter table ddd_test  add age int(20);
/*22.	将表(ddd_test)的引擎改为MyISAM*/
ALTER table ddd_test ENGINE=MyISAM;
/*23.	为表(ddd_test)的name字段创建唯一索引*/
create unique index namew on ddd_test(name);
/*24.	将用户名称为”江河”的用户密码改为”111111”（密码字段使用md5加密）*/
select * from ddd_usr where Usr_Nm = '江河';
update ddd_usr set Logon_Pwd = MD5(111111) where Usr_Nm = '江河';
desc ddd_usr;
show create table ddd_usr;




