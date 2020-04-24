/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2020-04-23 22:24:07                          */
/*==============================================================*/


alter table T_TREE_USER
   drop constraint FK_T_TREE_U_REFERENCE_T_DEPART;

alter table "t_affiche"
   drop constraint FK_T_AFFICH_REFERENCE_T_TREE_U;

alter table "t_attendance"
   drop constraint FK_T_ATTEND_REFERENCE_T_TREE_U;

alter table "t_attendance"
   drop constraint FK_T_ATTEND_REFERENCE_T_DEPART;

alter table "t_evection"
   drop constraint FK_T_EVECTI_REFERENCE_T_TREE_U;

alter table "t_leave"
   drop constraint FK_T_LEAVE_REFERENCE_T_TREE_U;

alter table "t_overtim"
   drop constraint FK_T_OVERTI_REFERENCE_T_TREE_U;

alter table "t_pro_dimission"
   drop constraint FK_T_PRO_DI_REFERENCE_T_TREE_U;

alter table "t_pro_task"
   drop constraint FK_T_PRO_TA_REFERENCE_T_TREE_U;

alter table "t_tree_role_resource"
   drop constraint FK_T_TREE_R_REFERENCE_T_TREE_R;

alter table "t_tree_role_resource"
   drop constraint FK_T_TREE_R_REFERENCE_T_TREE_R;

alter table "t_tree_user_role"
   drop constraint FK_T_TREE_U_REFERENCE_T_TREE_U;

alter table "t_tree_user_role"
   drop constraint FK_T_TREE_U_REFERENCE_T_TREE_R;

alter table "t_wage"
   drop constraint FK_T_WAGE_REFERENCE_T_TREE_U;

alter table "t_wage"
   drop constraint FK_T_WAGE_REFERENCE_T_DEPART;

drop table T_TREE_USER cascade constraints;

drop table "t_affiche" cascade constraints;

drop table "t_attendance" cascade constraints;

drop table "t_department" cascade constraints;

drop table "t_evection" cascade constraints;

drop table "t_leave" cascade constraints;

drop table "t_overtim" cascade constraints;

drop table "t_pro_dimission" cascade constraints;

drop table "t_pro_task" cascade constraints;

drop table "t_tree_resource" cascade constraints;

drop table "t_tree_role" cascade constraints;

drop table "t_tree_role_resource" cascade constraints;

drop table "t_tree_user_role" cascade constraints;

drop table "t_wage" cascade constraints;

/*==============================================================*/
/* Table: T_TREE_USER                                           */
/*==============================================================*/
create table T_TREE_USER 
(
   USERID               NUMBER(11)           not null,
   USERNAME             VARCHAR2(100),
   PASSWORD             VARCHAR2(100),
   REALNAME             VARCHAR2(100),
   SALT                 VARCHAR2(100),
   DESCRIPTION          VARCHAR2(100),
   LOCKED               NUMBER(11),
   CREATETIME           DATE,
   DELETESTATUS         NUMBER(11),
   SEX                  VARCHAR2(4),
   AGE                  NUMBER(11),
   EDUCATION            VARCHAR2(100),
   TELEPHONE            VARCHAR2(100),
   EMAIL                VARCHAR2(100),
   PROVINCE             VARCHAR2(100),
   CITY                 VARCHAR2(100),
   AREA                 VARCHAR2(100),
   ADDRESS              VARCHAR2(100),
   UPNO                 NUMBER(11),
   DEPTID               NUMBER(11),
   constraint PK_T_TREE_USER primary key (USERID)
);

/*==============================================================*/
/* Table: "t_affiche"                                           */
/*==============================================================*/
create table "t_affiche" 
(
   "affiche_id"         number(11)           not null,
   USERID               NUMBER(11),
   "title"              varchar2(50),
   "affiche_content"    varchar2(300),
   constraint PK_T_AFFICHE primary key ("affiche_id")
);

/*==============================================================*/
/* Table: "t_attendance"                                        */
/*==============================================================*/
create table "t_attendance" 
(
   "attendanceId"       number(11)           not null,
   USERID               number(11),
   DEPTID               number(11),
   "morningHours"       DATE,
   "morningClosingtime" DATE,
   "afternoonHours"     DATE,
   "afternoonClosingtime" DATE,
   "recordDate"         DATE,
   "remark"             varchar2(50),
   constraint PK_T_ATTENDANCE primary key ("attendanceId")
);

/*==============================================================*/
/* Table: "t_department"                                        */
/*==============================================================*/
create table "t_department" 
(
   DEPTID               NUMBER(11)           not null,
   DEPTNAME             varchar2(50),
   constraint PK_T_DEPARTMENT primary key (DEPTID)
);

/*==============================================================*/
/* Table: "t_evection"                                          */
/*==============================================================*/
create table "t_evection" 
(
   "evectionID"         number(11)           not null,
   USERID               number(11),
   "evectionDate"       DATE,
   "evectionAddress"    varchar2(200),
   "evectionReason"     varchar2(50),
   "stoPevection"       DATE,
   "evectionState"      varchar2(5),
   constraint PK_T_EVECTION primary key ("evectionID")
);

/*==============================================================*/
/* Table: "t_leave"                                             */
/*==============================================================*/
create table "t_leave" 
(
   "leaveID"            number(11)           not null,
   USERID               number(11),
   "leaveReason"         varchar2(50),
   "leaveTime"          DATE,
   "stopLeave"          DATE,
   "context"            varchar2(200),
   "approval"           varchar2(20),
   "leaveState"         varchar2(5),
   "final"              varchar2(5),
   constraint PK_T_LEAVE primary key ("leaveID")
);

/*==============================================================*/
/* Table: "t_overtim"                                           */
/*==============================================================*/
create table "t_overtim" 
(
   "overtimID"          number(11)           not null,
   USERID               number(11),
   "overtimType"        VARCHAR2(50),
   "overtimeDate"       DATE,
   "stoPovertime"       DATE,
   "overtimeDated"      DATE,
   "overtimState"       varchar2(5),
   constraint PK_T_OVERTIM primary key ("overtimID")
);

/*==============================================================*/
/* Table: "t_pro_dimission"                                     */
/*==============================================================*/
create table "t_pro_dimission" 
(
   "dimission_id"       number(11)           not null,
   USERID               NUMBER(11),
   "dim_date"           DATE,
   "position"           varcahr2(50),
   "state"              varcahr2(10),
   "final"              varchar2(20),
   constraint PK_T_PRO_DIMISSION primary key ("dimission_id")
);

/*==============================================================*/
/* Table: "t_pro_task"                                          */
/*==============================================================*/
create table "t_pro_task" 
(
   "task_id"            number               not null,
   "task_name"          varchar2(255),
   "begin_date"         DATE,
   "end_date"           DATE,
   "status"             varchar2(20),
   "bonus"              NUMBER(11,2),
   USERID               number(11),
   "task_desc"          varchar2(255),
   constraint PK_T_PRO_TASK primary key ("task_id")
);

/*==============================================================*/
/* Table: "t_tree_resource"                                     */
/*==============================================================*/
create table "t_tree_resource" 
(
   RESOURCEID           NUMBER(11)           not null,
   NAME                 VARCHAR2(100),
   RESOURCECODE         VARCHAR2(1000),
   URL                  VARCHAR2(1000),
   DESCRIPTION          VARCHAR2(1000),
   ICON                 VARCHAR2(100),
   PID                  NUMBER(11),
   SEQ                  NUMBER(11),
   STATUS               VARCHAR2(100),
   TYPE                 VARCHAR2(100),
   CREATETIME           DATE,
   constraint PK_T_TREE_RESOURCE primary key (RESOURCEID)
);

/*==============================================================*/
/* Table: "t_tree_role"                                         */
/*==============================================================*/
create table "t_tree_role" 
(
   ROLEID               NUMBER(11)           not null,
   ROLENAME             VARCHAR2(100),
   ROLECODE             VARCHAR2(100),
   DESCRIPTION          VARCHAR2(1000),
   CREATETIME           DATE,
   DELETESTATUS         NUMBER(11),
   ISDEFAULT            NUMBER(11),
   constraint PK_T_TREE_ROLE primary key (ROLEID)
);

/*==============================================================*/
/* Table: "t_tree_role_resource"                                */
/*==============================================================*/
create table "t_tree_role_resource" 
(
   ID                   NUMBER(11)           not null,
   ROLEID               NUMBER(11)           not null,
   RESOURCEID           NUMBER(11)           not null,
   constraint PK_T_TREE_ROLE_RESOURCE primary key (ID)
);

/*==============================================================*/
/* Table: "t_tree_user_role"                                    */
/*==============================================================*/
create table "t_tree_user_role" 
(
   ID                   NUMBER(11)           not null,
   USERID               NUMBER(11),
   ROLEID               NUMBER(11),
   constraint PK_T_TREE_USER_ROLE primary key (ID)
);

/*==============================================================*/
/* Table: "t_wage"                                              */
/*==============================================================*/
create table "t_wage" 
(
   "wageid"             number               not null,
   USERID               number(11),
   DEPTID               number(11),
   "baseWage"           number(11,2),
   "postwage"           number(11,2),
   "bonus"              number(11,2),
   "welfare"            number(11,2),
   "subsidy"            number(11,2),
   "carAllowance"       number(11,2),
   "overtimePay"        number(11,2),
   "medicallnsurance"   number(11,2),
   "socicalSecurity"    number(11,2),
   "taxes"              number(11,2),
   "netPayroll"         number(11,2),
   "absenteeism"        number(11,2),
   "lateAndEarly"       number(11,2),
   "leave"              number(11,2),
   "wageState"          varchar2(5),
   "wageDate"           date,
   constraint PK_T_WAGE primary key ("wageid")
);

alter table T_TREE_USER
   add constraint FK_T_TREE_U_REFERENCE_T_DEPART foreign key (DEPTID)
      references "t_department" (DEPTID);

alter table "t_affiche"
   add constraint FK_T_AFFICH_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_attendance"
   add constraint FK_T_ATTEND_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_attendance"
   add constraint FK_T_ATTEND_REFERENCE_T_DEPART foreign key (DEPTID)
      references "t_department" (DEPTID);

alter table "t_evection"
   add constraint FK_T_EVECTI_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_leave"
   add constraint FK_T_LEAVE_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_overtim"
   add constraint FK_T_OVERTI_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_pro_dimission"
   add constraint FK_T_PRO_DI_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_pro_task"
   add constraint FK_T_PRO_TA_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_tree_role_resource"
   add constraint FK_T_TREE_R_REFERENCE_T_TREE_R foreign key (ROLEID)
      references "t_tree_role" (ROLEID);

alter table "t_tree_role_resource"
   add constraint FK_T_TREE_R_REFERENCE_T_TREE_R foreign key (RESOURCEID)
      references "t_tree_resource" (RESOURCEID);

alter table "t_tree_user_role"
   add constraint FK_T_TREE_U_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_tree_user_role"
   add constraint FK_T_TREE_U_REFERENCE_T_TREE_R foreign key (ROLEID)
      references "t_tree_role" (ROLEID);

alter table "t_wage"
   add constraint FK_T_WAGE_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_wage"
   add constraint FK_T_WAGE_REFERENCE_T_DEPART foreign key (DEPTID)
      references "t_department" (DEPTID);

