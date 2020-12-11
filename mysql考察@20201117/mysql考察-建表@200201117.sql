# 创建新的数据库test
create database test;
# 使用数据库test
use test;
#创建学生表
CREATE TABLE `Student`(
	`s_id` VARCHAR(20)  comment'学生号',
	`s_name` VARCHAR(20) NOT NULL DEFAULT '' comment'学生姓名',
	`s_birth` VARCHAR(20) NOT NULL DEFAULT '' comment'学生生日',
	`s_sex` VARCHAR(10) NOT NULL DEFAULT '' comment'学生性别',
	PRIMARY KEY(`s_id`)
)engine = InnoDB default charset=utf8 comment'学生表';
# 创建课程表
CREATE TABLE `Course`(
	`c_id`  VARCHAR(20) comment'课程ID',
	`c_name` VARCHAR(20) NOT NULL DEFAULT '' comment'课程名称',
	`t_id` VARCHAR(20) NOT NULL comment'老师ID',
	PRIMARY KEY(`c_id`)
)engine = InnoDB default charset=utf8 comment'课程表';
# 教师表
CREATE TABLE `Teacher`(
	`t_id` VARCHAR(20) comment'老师ID',
	`t_name` VARCHAR(20) NOT NULL DEFAULT '' comment'教师姓名',
	PRIMARY KEY(`t_id`)
)engine = InnoDB default charset=utf8 comment'教师表';
# 成绩表
CREATE TABLE `Score`(
	`s_id` VARCHAR(20) comment'学生ID',
	`c_id`  VARCHAR(20) comment'课程ID',
	`s_score` INT(3) comment'课程分数',
	PRIMARY KEY(`s_id`,`c_id`)
)engine = InnoDB default charset=utf8 comment'成绩表';
# 插入学生表测试数据
insert into
    Student
values('01' , '赵雷' , '1990-01-01' , '男'),
      ('02' , '钱电' , '1990-12-21' , '男'),
      ('03' , '孙风' , '1990-05-20' , '男'),
      ('04' , '李云' , '1990-08-06' , '男'),
      ('05' , '周梅' , '1991-12-01' , '女'),
      ('06' , '吴兰' , '1992-03-01' , '女'),
      ('07' , '郑竹' , '1989-07-01' , '女'),
      ('08' , '王菊' , '1990-01-20' , '女');
# 课程表测试数据
insert into
    Course
values
       ('01' , '语文' , '02'),
       ('02' , '数学' , '01'),
       ('03' , '英语' , '03');
# 教师表测试数据
insert into
    Teacher
values
       ('01' , '张三'),
       ('02' , '李四'),
       ('03' , '王五');
# 成绩表测试数据
insert into
    Score
values
        ('01' , '01' , 80),
        ('01' , '02' , 90),
        ('01' , '03' , 99),
        ('02' , '01' , 70),
        ('02' , '02' , 60),
        ('02' , '03' , 80),
        ('03' , '01' , 80),
        ('03' , '02' , 80),
        ('03' , '03' , 80),
        ('04' , '01' , 50),
        ('04' , '02' , 30),
        ('04' , '03' , 20),
        ('05' , '01' , 76),
        ('05' , '02' , 87),
        ('06' , '01' , 31),
        ('06' , '03' , 34),
        ('07' , '02' , 89),
        ('07' , '03' , 98);

