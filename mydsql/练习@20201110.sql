
# 使用dshop_alpha数据库
use dshop_alpha;
/*1.	在用户表查询供应商”西藏演示供应商”的所有用户(通过供应商ID查询)，展示字段如下:
  （可能涉及的表:ddd_usr,ddd_provr,ddd_br）*/
select column_name,column_comment from information_schema.columns where table_schema='dshop_alpha' and table_name = 'ddd_provr';
/*
分析：
1、根据ddd_provr供应商表查询出西藏供应商的id以及分公司id
2、根据所查询出的西藏供应商id在ddd_usr表中查询供应商为西藏供应商的用户名、用户手机号
4、根据所查询出的西藏供应商id在ddd_br表中查询子公司供应商的名称及状态
 */
select Provr_Id,Br_Id from ddd_provr where Provr_Nm = '西藏演示供应商';--查询
select
     t.Usr_Nm    /*用户名*/
    ,t.Mobl_Num  /*用户手机号*/
    ,t2.Br_Nm     /*--子公司名称*/
    ,t1.Provr_Nm   /*供应商名称*/
    ,t2.Is_Del    /*--状态*/
from
     ddd_usr t   /*--用户表*/
inner join
     ddd_provr t1  /*--供应商表*/
on
     t.Provr_Id = t1.Provr_Id
inner join
     ddd_br t2    /*子公司表*/
on
     t.Br_Id = t2.Br_Id
where
     Provr_Nm = '西藏演示供应商';

/*
2.	查询商品列表，展示所有类目为”休闲零食”，且商品名称有关键字”测试”的所有商品，字段如下:(可能涉及的表:
ddd_gds_info,ddd_gds_cls_info,ddd_gds_item_invty,ddd_provr_gds_cls_def)
*/

/*
分析：
1：根据商品分类信息表ddd_gds_cls_info查找商品分类名称（Cls_Nm)为休闲零食的父分类ID(Par_Cls_Id)
2：在商品信息表ddd_gds_info查找商品名称（Gds_Nm)含有"测试"的所有商品名称，商品id（Gds_Id） 及品牌名称(Brand_Nm) 商品名称(Gds_Nm)
3：在商品分项库存表ddd_gds_item_invty中查找对应商品id(Gds_Id) 的库存数量(Invty_Cnt)
4：在供应商商品分类信息表ddd_provr_gds_cls_def中通过父分类id(Par_Cls_Id)查看对应的分类名称(Cls_Nm)
*/
select
     t1.Brand_Nm             /*品牌名称*/
    ,t1.Gds_Nm               /*商品名称*/
    ,t2.Cls_Nm               /*id*/
    ,t1.Gds_Lmt_Prc          /*价格下限*/
    ,t1.Gds_Ceil_Prc         /*价格上限*/
    ,t4.Invty_Cnt            /*库存数量*/

from
    ddd_gds_info t1          /*商品信息表*/
inner join
    ddd_gds_cls_info t2      /*商品分类信息表*/
on
    t2.Cls_Id = t1.Lvl3_Cls_id
left join
    ddd_provr_gds_cls_def t3    /*供应商表*/
on
    t3.Cls_Id = t1.Provr_Tail_Cls_id
left join
    ddd_gds_item_invty t4       /*商品库存信息表*/
on
    t4.Gds_Id = t1.Gds_Id
where
      t2.Cls_Nm = '休闲零食' and t1.Gds_Nm like '%测试%';
/*
3.	查询订单列表，展示所有小店”测试0609店铺”在2020年下的单，展示字段为:(可能涉及的表为:
ddd_ordr_info,ddd_ordr_shop_rel),并计算小店”测试0609店铺”在2020年下的订单中待发货订单的笔数及待发货订单的订单总金额
*/
/*
分析：
1、根据订单信息表ddd_ordr_info查询出订单信息为2020年下单的店铺
2、依据已筛选出的店铺在订单小店关系表ddd_ordr_shop_rel中找出Shop_Nm ='测试0609店铺'的店铺
3、根据订单信息表ddd_ordr_info查询出订单信息为2020年下单且状态为待发货的的订单
4、依据筛选出的订单在订单小店关系表ddd_ordr_shop_rel找出店铺名称为'测试0609店铺'的店铺，对以上结果中的待发货总金额，以及待发货订单数进行统计
*/
select
     t.Ordr_Id          /*订单id*/
    ,t1.Ordr_Typ         /*订单类型*/
    ,t.Provr_Nm          /*供应商*/
    ,t.Shop_Nm           /*下单小店*/
    ,t.Ordr_Busi_Nm      /*下单业务员*/
    ,t1.Gds_Totl_Amt     /*商品总金额*/
    ,t1.Gds_Serv_Chrg    /*订单手续费*/
    ,t1.Provr_Recvbl_Amt /*应收金额*/
    ,t1.Provr_Actl_Amt   /*实收金额*/
    ,t1.Term_Tm_Typ      /*账期类型*/
from
    ddd_ordr_info t1    /*订单信息表*/

inner join
    ddd_ordr_shop_rel t /*订单小店关系表*/
on
    t.Ordr_Id = t1.Ordr_Id
where
    t.Shop_Nm ='测试0609店铺' and year(t1.Crt_Tm)=2020;
# 小店”测试0609店铺”在2020年下的订单中待发货订单的笔数及待发货订单的订单总金额
select
     sum(t.Ordr_Totl_Amt) sum_Order /*待发货总金额*/
    ,count(*) count_Ordr /*待发货订单数*/
from
     ddd_ordr_info t  /*订单信息表*/
inner join
     ddd_ordr_shop_rel t1  /*订单小店关系表*/
on
     t.Ordr_Id = t1.Ordr_Id
where
     t1.Shop_Nm ='测试0609店铺' and year(t.Crt_Tm)=2020 and t.Ordr_Stat=03;

/*
4.	查询供应商”西藏演示供应商”管理区域内的所有小店。(提示:在表ddd_provr_regn_rel中查出所有的管理区域，
再在ddd_dshop_info表中查询Lvl4_Regn_Id在管理区域内的数据)，展示数据为:(可能涉及的表:ddd_provr_busi_asgn,
ddd_provr,ddd_provr_regn_rel)
*/

select
     t1.Shop_Nm  /*店铺名称*/
    ,t2.Provr_Logo /*供应商logo*/
    ,t1.Crt_Tm     /*创建时间*/
    ,t1.Shop_Addr  /*商店地址*/
    ,t5.Asgn_Id   /*指派人*/
from
     ddd_dshop_info t1   /*小店信息表*/
inner join
    ddd_provr_regn_rel t  /*ddd_provr_regn_rel*/
on
    t.Regn_Id = t1.Lvl4_Regn_Id
inner join
    ddd_provr t2    /*供应商*/
on
    t.Provr_Id = t2.Provr_Id
left join
     ddd_regn t4     /*区域表*/
on
    t4.Regn_Id = t.Regn_Id
left join
    ddd_provr_busi_asgn t5
on
    t5.Shop_Id = t1.Shop_Id
where
    t2.Provr_Nm = '西藏演示供应商' and t4.Regn_Hrcy = 4;





