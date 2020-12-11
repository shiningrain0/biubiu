#1.通过命令方式数据文件导入导出。文件单独给出。
# 创建数据库ddd
# 对于文件数据的导入导出操作均在终端完成
create database ddd;
# 使用ddd数据库
use ddd;
# 导入数据文件
source E:/店店店/文档/数据导入导出/dshop_public_20201112.sql
# 导出数据表文件
use data;
mysqldump -u root -p data a > E:/店店店/文档/数据导入导出/tx1.txt
#导出表a的结构
mysqldump -u root -p data -d a > E:/店店店/文档/数据导入导出/tx.sql
# 导出数据库
mysqldump -u root -p data > E:/店店店/文档/数据导入导出/data.sql
# 导出数据库结构
mysqldump -u root -p -d data > E:/店店店/文档/数据导入导出/data_des.sql
# 创建data_work表结构
CREATE TABLE `date_work` (
  vin varchar(255) DEFAULT NULL,
  vin_id varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  price double(6,1) DEFAULT NULL,
  shop varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

#使用load方法导入表格内容
load data local infile
     'C:/Users/biubiubiu/Desktop/date_work.csv'
into table
     date_work
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';
#将数据库中的表内容导出为csv文件
select *
from a                           /*表*/
into outfile 'E:/a.csv'          /*文件输出路径*/
fields terminated by ','         /*字段分隔符*/
optionally enclosed by '"'       /*字段括起字符*/
escaped by '"'                   /*字段转义字符*/
lines terminated by '\n';        /*行分割*/

# 2.自定义函数 "lcd_add", 输入为 a,b,c 实际获得效果是返回 a+b+c 的值。
create function lcd_add(a int,b int,c int)
returns int
begin
return a+b+c;
end
select lcd_add(3,2,3);
# 查看函数
show function status;
# 删除函数
drop function lcd_ddd;

# 3.通过命令方式进行远程备份mysql数据库. 以京桉数据库为例。
# 此命令在终端下操作
# 将远程数据库内容备份到本地
mysqldump --column-statistics=0 -h45.40.203.186 -ujakj -p qiye > E:/店店店/ 文档/数据导入导出/京桉.sql
#将本地数据库备份到远程
mysql -h212.64.40.20 -u licaidie -p runoob <  E:/店店店/文档/数据导入导出@20201112/京桉.sql
#将本地数据库中的表备份到远程
truncate table date_work;

