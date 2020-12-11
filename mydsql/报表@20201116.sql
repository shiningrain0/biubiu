use dshop_alpha;
# 销售报表
select
     t1.Gds_Id              /*商品ID*/
    ,t1.Gds_Nm              /*商品名称*/
    ,t2.Invty_Cnt           /*库存数量*/
    ,t3.Unit_Nm             /*基本单位*/
    ,t1.Ordr_Qty            /*商品规格数量*/
    ,t1.Gds_Prc             /*商品规格单价*/
    ,t1.Totl_Prc            /*商品规格价格*/
from
    ddd_ordr_gds_info t1    /*订单商品信息表*/
left join
    ddd_gds_item_invty t2    /*商品分项库存表*/
on
    t1.gds_Id = t2.Gds_Id
left join
    ddd_gds_unit   t3         /*商品单位表*/
on
    t1.gds_Id = t3.Gds_Id
inner join
    ddd_ordr_info  t4          /*订单信息表*/
on
    t1.Ordr_Id = t4.Ordr_Id
where month(t4.Recv_Tm) = 7;






