create table employee
(
    id           int auto_increment comment '主键ID'
        primary key,
    dep_id       int                                  not null comment '部门ID',
    name         varchar(50)                          not null comment '员工名称',
    gender       tinyint(2) default 1                 null comment '性别，1=男，2=女，3=未知',
    age          int(5)                               null comment '员工年龄',
    mobile       varchar(15)                          null comment '手机号',
    position     varchar(50)                          null comment '职位',
    gmt_create   datetime   default CURRENT_TIMESTAMP not null comment '记录创建时间',
    gmt_modified datetime   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '记录修改时间',
    sub_create   char(32)                             null comment '记录创建人',
    sub_modified char(32)                             null comment '记录修改人',
    is_deleted   tinyint(2) default 0                 not null comment '类型: 0-未删除 1-删除 默认未删除'
)
    comment '员工表' charset = utf8mb4;

create table department
(
    id           int auto_increment comment '主键ID'
        primary key,
    name         varchar(50)                          not null comment '部门名称',
    gmt_create   datetime   default CURRENT_TIMESTAMP not null comment '记录创建时间',
    gmt_modified datetime   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '记录修改时间',
    sub_create   char(32)                             null comment '记录创建人',
    sub_modified char(32)                             null comment '记录修改人',
    is_deleted   tinyint(2) default 0                 not null comment '类型: 0-未删除 1-删除 默认未删除'
)
    comment '员工表' charset = utf8mb4;

# SQL 统计各部门的员工人数
select d.id, d.name, count(1) as 人数
from department d
         left join employee e on d.id = e.dep_id
group by d.id;

# SQL 查询每个部门年龄最大的员工。
select a.*
from (
         select d.id,
                d.name,
                e.id as eId,
                e.name as eName,
                case e.gender
                    when 1 then '男'
                    when 2 then '女'
                    end '未知',
                e.age,
                CONCAT(LEFT(e.mobile,3), '*****' ,RIGHT(e.mobile,3)) as 脱敏手机号,
                e.position
         from department d
                  left join employee e on d.id = e.dep_id
         order by d.id, e.age desc
         limit 10000
     ) a
group by a.id;

# SQL 手机号模糊查询
select d.id, d.name, e.*
from department d
         left join employee e on d.id = e.dep_id
where e.mobile like '%188%';
