/*==============================================================*/
/* Database name:  db-air                                       */
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/10/25 星期三 15:35:33                      */
/*==============================================================*/


drop database if exists "db-air";

/*==============================================================*/
/* Database: "db-air"                                           */
/*==============================================================*/
create database "db-air";

use "db-air";

/*==============================================================*/
/* Table: t_air_apply                                           */
/*==============================================================*/
create table t_air_apply
(
   id                   int not null auto_increment,
   user_id              varchar(64) not null comment '个人id或企业id',
   user_name            varchar(50) not null comment '个人姓名或企业名',
   user_type            tinyint(4) not null default 1 comment '用户类型：1个人，2企业',
   number               varchar(11) not null comment '说明：该编号由系统自动生成，如2017年6月12日递交的空域使用申请编号为KY170612001,即KY表示空域申请，170612表示日期，001表示该申请的编号',
   task_type            varchar(255) comment '任务性质',
   plan_begin_time      datetime default NULL comment '计划开始时间',
   plan_end_time        datetime default NULL comment '计划结束时间',
   weather_condition    varchar(255) comment '气象条件',
   flight_rule          varchar(10) default NULL comment '飞行规则',
   plan_type            varchar(10) not null default '0' comment '计划类型：0其他，1技能培训，2产品试飞',
   contact_info         varchar(255) default NULL comment '联系人信息',
   emergency_contact_info varchar(255) comment '紧急联系人信息',
   create_time          datetime default NULL comment '申请时间',
   status               tinyint(4) default 0 comment '状态：0审核中，1审核通过，2未通过审核,3撤销申请,4草稿',
   audit_time           datetime default NULL comment '审核时间',
   reason               varchar(255) default NULL comment '审核失败原因',
   remark               varchar(255) default NULL comment '备注',
   auditor              varchar(50) comment '审核人',
   primary key (id),
   unique key tb_airspace_apply_PK (number)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空域申请信息表';

alter table t_air_apply comment '空域申请信息表';

/*==============================================================*/
/* Table: t_air_plan                                            */
/*==============================================================*/
create table t_air_plan
(
   id                   int not null auto_increment,
   number               varchar(20) not null comment '编号，该编号由系统自动生成，如2017年6月12日广州大学城一类报告空域的计划编号为170612gzA01001,即170612表示日期，GZ代表区域，A代表一类报告空域，01表示一类报告空域编号，001表示计划编号',
   apply_user           varchar(50) not null comment '申请者名',
   user_id              varchar(64) not null comment '个人id或企业id',
   user_type            tinyint(2) not null default 1 comment '用户类型：1个人，2企业',
   type                 tinyint(2) not null default 0 comment '飞行计划申请类型，0为管制飞行计划，1为一类飞行计划，2为二类飞行计划',
   plan_type            varchar(10) not null default '0' comment '计划类型：0其他，1技能培训，2产品试飞',
   plan_begin_time      datetime not null default '0000-00-00 00:00:00' comment '计划开始时间',
   plan_end_time        datetime not null default '0000-00-00 00:00:00' comment '计划结束时间',
   actual_begin_time    datetime default NULL comment '实际开始时间',
   actual_end_time      datetime default NULL comment '实际结束时间',
   contact_info         varchar(255) default NULL comment '联系人信息',
   emergency_contact_info varchar(255) comment '紧急联系人信息',
   weather_condition    varchar(255) default NULL comment '气象条件',
   flight_rule          varchar(255) comment '飞行规则',
   create_time          datetime default NULL comment '申请时间',
   audit_time           datetime default NULL comment '审批时间',
   status               tinyint(2) not null default 0 comment '审核状态：0审核中，1通过审核，2未通过审核，3执行中，4已完成，5计划超时，6撤销申请',
   remark               varchar(255) default NULL comment '备注',
   reason               varchar(255) default NULL comment '审核失败原因',
   task_type            varchar(255) comment '任务性质',
   auditor              varchar(50) comment '审核人',
   primary key (id),
   unique key tb_air_plan_PK (number)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='飞行计划表';

alter table t_air_plan comment '飞行计划申请表';

/*==============================================================*/
/* Table: t_airspace                                            */
/*==============================================================*/
create table t_airspace
(
   id                   int not null auto_increment,
   type                 tinyint(4) default NULL comment '0-管制 1-一类 2二类',
   name                 varchar(50) default NULL comment '空域名称',
   sketch_map           varchar(255) default NULL comment '示意图路径',
   scope_type           tinyint(4) default 0 comment '空域范围类型,1圆形，2多边形',
   scope_info           varchar(2000) default NULL comment '空域范围信息',
   height               varchar(20) default '0' comment '真高，单位为米',
   capacity             int comment '空域容量',
   location             varchar(255) comment '位置',
   location_desc        varchar(255) default NULL comment '位置描述',
   effective_time       datetime default NULL comment '生效时间',
   expire_date          datetime default NULL comment '失效时间',
   apply_official_no    varchar(255) not null comment '空域批文编号',
   creator_id           varchar(64) not null comment '创建者ID',
   create_time          datetime comment '创建时间',
   status               varchar(10) comment '空域状态：start开始 stop停止 pause暂停',
   creator_type         char(2) comment '创建者类型',
   primary key (id),
   unique key tb_airspace_info_PK (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空域信息表';

alter table t_airspace comment '空域信息表';

/*==============================================================*/
/* Table: t_airspace_air_apply_landing_ref                      */
/*==============================================================*/
create table t_airspace_air_apply_landing_ref
(
   id                   int not null auto_increment,
   airspace_id          int comment '空域信息ID',
   air_apply_id         int default NULL comment '空域申请编号',
   landing_id           int default NULL comment '起降场id',
   primary key (id),
   unique key tb_plan_landing_ref_PK (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空域申请与起降场关系表';

alter table t_airspace_air_apply_landing_ref comment '空域与空域申请与起降场关系表';

/*==============================================================*/
/* Table: t_airspace_jurisdiction_ref                           */
/*==============================================================*/
create table t_airspace_jurisdiction_ref
(
   id                   int not null auto_increment comment 'rowid',
   jurisdiction_id      int comment '管辖区ID',
   airspace_id          int comment '空域ID',
   primary key (id)
);

alter table t_airspace_jurisdiction_ref comment '空域与管辖区关系表';

/*==============================================================*/
/* Table: t_apply_official_no                                   */
/*==============================================================*/
create table t_apply_official_no
(
   id                   int not null auto_increment comment 'rowid',
   apply_unit           varchar(255) comment '批复单位',
   apply_name           varchar(255) comment '字号',
   apply_no             varchar(255) comment '编号',
   actual_begin_time    datetime default NULL comment '实际开始时间',
   actual_end_time      datetime default NULL comment '实际结束时间',
   weather_condition    varchar(255) default NULL comment '气象条件',
   planes               varchar(255) not null comment '使用机型信息，以json存储，格式为{"name":"直升机","number":3}',
   flight_rule          varchar(255) comment '飞行规则',
   height               varchar(20) default '0' comment '真高，单位为米',
   apply_official_no    varchar(255) not null comment '空域批文编号',
   task_type            varchar(255) comment '任务性质',
   primary key (id)
);

alter table t_apply_official_no comment '批文信息表';

/*==============================================================*/
/* Table: t_apply_official_no_landing_ref                       */
/*==============================================================*/
create table t_apply_official_no_landing_ref
(
   id                   int not null auto_increment comment 'rowid',
   landing_id           int comment '起降场ID',
   apply_official_no_id int comment '空域批文编号ID',
   primary key (id)
);

alter table t_apply_official_no_landing_ref comment '批文与起降场关系表';

/*==============================================================*/
/* Table: t_dictionary                                          */
/*==============================================================*/
create table t_dictionary
(
   id                   int(11) not null auto_increment,
   name                 varchar(64) default NULL comment '字典名称',
   code                 varchar(64) default NULL comment '字典ID',
   parent_code          varchar(64) default NULL comment '上级ID',
   is_parent            bit(1) default NULL comment '是否有下级(0为没有，1为有)',
   remark               varchar(64) default NULL comment '备注',
   primary key (id)
)
ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='数据字典表';

alter table t_dictionary comment '数据字典表';

/*==============================================================*/
/* Table: t_jurisdiction                                        */
/*==============================================================*/
create table t_jurisdiction
(
   id                   int not null auto_increment comment 'ROWID',
   jurisdiction_level   char(1) comment '管辖区级别
            1（一级行政区）省级行政区 
            2（二级行政区）地级行政区
            3（三级行政区）县级行政区
            4（四级行政区）乡级行政区
            5（五级行政区）村级行政区
            6（六级行政区）组级行政区
            ----------------------------------------------
            1 战区级	
            2 分区级	
            3 场站级
            
            ',
   jurisdiction_id      varchar(255) comment '地域ID',
   parent_jurisdiction_id varchar(255) comment '上级ID',
   dministrative_area_name varchar(10) comment '行政区：
            xx省
            xx市
            xx县
            xx乡
            xx村
            xx组
            
            战区：
            xx管制处
            xx管制分区
            xx分区直辖区域/xx机场管制室
            ',
   jurisdiction_type    varchar(20) comment '管辖类型:administrative行政区 Theater战区',
   primary key (id)
);

alter table t_jurisdiction comment '管辖区表';

/*==============================================================*/
/* Table: t_landing                                             */
/*==============================================================*/
create table t_landing
(
   id                   int not null auto_increment,
   name                 varchar(50) not null comment '起降场名称',
   lng                  varchar(12) not null comment '经度',
   lat                  varchar(12) not null comment '纬度',
   location             varchar(255) not null comment '位置描述',
   langding_sources     char(1) comment '起降场信息来源，0批文信息导入，1系统填入，2用户输入',
   creator_id           varchar(64) not null comment '创建者ID',
   create_time          datetime comment '创建时间',
   primary key (id),
   unique key tb_landing_PK (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='起降场信息表';

alter table t_landing comment '起降场信息表';

/*==============================================================*/
/* Table: t_location                                            */
/*==============================================================*/
create table t_location
(
   location_type        int comment '地域级别：0直辖市，1省，2市，3区......',
   location_id          int not null auto_increment comment '地域ID',
   location_name        varchar(20) comment '地域名称：广东省，广州市，越秀区',
   primary key (location_id)
);

alter table t_location comment '地理位置';

/*==============================================================*/
/* Table: t_operation_log                                       */
/*==============================================================*/
create table t_operation_log
(
   id                   int not null auto_increment comment 'rowid',
   operation_id         int comment '被操作数据的rowid',
   modify_user          varchar(50) comment '操作人',
   modify_time          datetime comment '操作时间',
   pre_status           tinyint comment '操作前状态：0审核中，1审核通过，2未通过审核,3撤销申请''',
   post_status          tinyint comment '操作后状态：0审核中，1审核通过，2未通过审核,3撤销申请''',
   ip_address           varchar(20) comment 'IP地址:127.0.0.1',
   operation_type       char(1) comment '操作类型：C:新增, R:查询,U:修改,D:删除',
   operation_result     char(1) comment '操作结果：F：失败，S：成功',
   operation_obj        varchar(100) comment '操作实例：air_plan飞行计划，air_apply空域申请',
   primary key (id)
);

alter table t_operation_log comment '操作日志表';

/*==============================================================*/
/* Table: t_plan_airspace_ref                                   */
/*==============================================================*/
create table t_plan_airspace_ref
(
   id                   int not null auto_increment comment 'rowid',
   airspace_id          int not null comment '空域信息表id',
   plan_id              int not null comment '飞行计划编号',
   primary key (id),
   unique key tb_plan_airspace_ref_PK (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计划与空域关系表';

alter table t_plan_airspace_ref comment '计划与空域关系表';

/*==============================================================*/
/* Table: t_serial_number                                       */
/*==============================================================*/
create table t_serial_number
(
   id                   int not null auto_increment comment 'rowid',
   max_serial_number    int comment 'max_serial_number',
   name                 varchar(255) comment '名字',
   type                 char(1) comment '类型：0每天不需重置 1 每天需要重置',
   primary key (id)
);

alter table t_serial_number comment '流水号存储表';

/*==============================================================*/
/* Table: t_uav                                                 */
/*==============================================================*/
create table t_uav
(
   id                   int not null auto_increment,
   user_id              varchar(64) not null,
   uav_model_id         int(11) not null,
   sn                   varbinary(255),
   registration_number  varbinary(255),
   remark               varbinary(255),
   primary key (id)
);

alter table t_uav comment '无人机表';

/*==============================================================*/
/* Table: t_uav_air_apply_ref                                   */
/*==============================================================*/
create table t_uav_air_apply_ref
(
   id                   int not null auto_increment comment 'rowid',
   uav_id               int comment '无人机ID',
   air_apply_id         int comment '空域申请表ID',
   primary key (id)
);

alter table t_uav_air_apply_ref comment '无人机与空域申请信息关系表';

/*==============================================================*/
/* Table: t_uav_air_plan_ref                                    */
/*==============================================================*/
create table t_uav_air_plan_ref
(
   id                   int not null auto_increment,
   uav_id               int not null,
   air_plan_id          int(11) not null,
   primary key (id)
);

/*==============================================================*/
/* Table: t_uav_manufacturer                                    */
/*==============================================================*/
create table t_uav_manufacturer
(
   id                   int not null auto_increment,
   name                 varchar(64) not null,
   description          varchar(255),
   contact_name         varchar(30),
   contact_phone        varchar(30),
   create_time          datetime,
   primary key (id)
);

alter table t_uav_manufacturer comment '无人机厂商表';

/*==============================================================*/
/* Table: t_uav_model                                           */
/*==============================================================*/
create table t_uav_model
(
   id                   int not null auto_increment,
   uav_manufacturer_id  int(11) not null,
   type                 tinyint(4),
   model                tinyint(4),
   img_url              varchar(255),
   description          varchar(255),
   primary key (id)
);

alter table t_airspace_air_apply_landing_ref add constraint FK_Reference_3 foreign key (air_apply_id)
      references t_air_apply (id) on delete restrict on update restrict;

alter table t_airspace_air_apply_landing_ref add constraint FK_Reference_4 foreign key (landing_id)
      references t_landing (id) on delete restrict on update restrict;

alter table t_airspace_air_apply_landing_ref add constraint FK_Reference_6 foreign key (airspace_id)
      references t_airspace (id) on delete restrict on update restrict;

alter table t_airspace_jurisdiction_ref add constraint FK_Reference_8 foreign key (jurisdiction_id)
      references t_jurisdiction (id) on delete restrict on update restrict;

alter table t_airspace_jurisdiction_ref add constraint FK_Reference_9 foreign key (airspace_id)
      references t_airspace (id) on delete restrict on update restrict;

alter table t_apply_official_no_landing_ref add constraint FK_Reference_12 foreign key (apply_official_no_id)
      references t_apply_official_no (id) on delete restrict on update restrict;

alter table t_apply_official_no_landing_ref add constraint FK_Reference_13 foreign key (landing_id)
      references t_landing (id) on delete restrict on update restrict;

alter table t_plan_airspace_ref add constraint FK_Reference_1 foreign key (plan_id)
      references t_air_plan (id) on delete restrict on update restrict;

alter table t_plan_airspace_ref add constraint FK_Reference_2 foreign key (airspace_id)
      references t_airspace (id) on delete restrict on update restrict;

alter table t_uav add constraint FK_Reference_7 foreign key (uav_model_id)
      references t_uav_model (id) on delete restrict on update restrict;

alter table t_uav_air_apply_ref add constraint FK_Reference_14 foreign key (uav_id)
      references t_uav (id) on delete restrict on update restrict;

alter table t_uav_air_apply_ref add constraint FK_Reference_15 foreign key (air_apply_id)
      references t_air_apply (id) on delete restrict on update restrict;

alter table t_uav_air_plan_ref add constraint FK_Reference_10 foreign key (uav_id)
      references t_uav (id) on delete restrict on update restrict;

alter table t_uav_air_plan_ref add constraint FK_Reference_11 foreign key (air_plan_id)
      references t_air_plan (id) on delete restrict on update restrict;

alter table t_uav_model add constraint FK_Reference_5 foreign key (uav_manufacturer_id)
      references t_uav_manufacturer (id) on delete restrict on update restrict;

