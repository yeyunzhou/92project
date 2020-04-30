/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2020-04-25 19:49:06                          */
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

alter table "t_evectionAccount"
   drop constraint FK_T_EVECTI_REFERENCE_T_EVECTI;

alter table "t_leave"
   drop constraint FK_T_LEAVE_REFERENCE_T_TREE_U;

alter table "t_overtim"
   drop constraint FK_T_OVERTI_REFERENCE_T_TREE_U;

alter table "t_pro_dimission"
   drop constraint FK_T_PRO_DI_REFERENCE_T_TREE_U;

alter table "t_pro_plan"
   drop constraint FK_T_PRO_PL_REFERENCE_T_PRO_TA;

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

drop table "t_evectionAccount" cascade constraints;

drop table "t_leave" cascade constraints;

drop table "t_overtim" cascade constraints;

drop table "t_pro_dimission" cascade constraints;

drop table "t_pro_plan" cascade constraints;

drop table "t_pro_task" cascade constraints;

drop table "t_tree_resource" cascade constraints;

drop table "t_tree_role" cascade constraints;

drop table "t_tree_role_resource" cascade constraints;

drop table "t_tree_user_role" cascade constraints;

drop table "t_wage" cascade constraints;

drop table "welfare" cascade constraints;

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
   BASEPAY              NUMBER(11,2),
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
   "releasetime"        date,
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
   "approver"           NUMBER(11),
   "remark"             varchar2(50),
   constraint PK_T_EVECTION primary key ("evectionID")
);

comment on column "t_evection"."approver" is
'审批人';

/*==============================================================*/
/* Table: "t_evectionAccount"                                   */
/*==============================================================*/
create table "t_evectionAccount" 
(
   "evectionAccountID"  number(11),
   "evectionID"         number(11),
   "subsidy"            number(2),
   "evectiondays"       number,
   "total"              number(2),
   "evectionAccountState" number(5)
);

comment on table "t_evectionAccount" is
'出差明细表';

comment on column "t_evectionAccount"."evectionAccountID" is
'编号';

comment on column "t_evectionAccount"."evectionID" is
'出差表编号';

comment on column "t_evectionAccount"."subsidy" is
'补贴';

comment on column "t_evectionAccount"."evectiondays" is
'天数';

comment on column "t_evectionAccount"."total" is
'共计';

comment on column "t_evectionAccount"."evectionAccountState" is
'是否发放';

/*==============================================================*/
/* Table: "t_leave"                                             */
/*==============================================================*/
create table "t_leave" 
(
   "leaveID"            number(11)           not null,
   USERID               NUMBER(11),
   "leaveReason"         varchar2(50),
   "leaveTime"          DATE,
   "stopLeave"          DATE,
   "context"            varchar2(200),
   "approval"           varchar2(20),
   "leaveState"         varchar2(5),
   "final"              varchar2(5),
   "approver"           NUMBER(11),
   "remark"             varchar2(50),
   constraint PK_T_LEAVE primary key ("leaveID")
);

comment on column "t_leave"."approver" is
'审批人';

/*==============================================================*/
/* Table: "t_overtim"                                           */
/*==============================================================*/
create table "t_overtim" 
(
   "overtimID"          number(11)           not null,
   USERID               number(11),
   "overtimeDate"       DATE,
   "stoPovertime"       DATE,
   "overtimeDated"      DATE,
   "overtimState"       varchar2(5),
   "overtimReason"      varchar2(50),
   "approver"           NUMBER(11),
   "remark"             varchar(250),
   constraint PK_T_OVERTIM primary key ("overtimID")
);

comment on column "t_overtim"."overtimReason" is
'加班原因';

comment on column "t_overtim"."approver" is
'审批人';

/*==============================================================*/
/* Table: "t_pro_dimission"                                     */
/*==============================================================*/
create table "t_pro_dimission" 
(
   "dmission_id"        number(11),
   USERID               NUMBER(11),
   "dim_date"           DATE,
   "position"           varchar2(50),
   "exist_task"         varchar2(20),
   "heir"               NUMBER(11),
   "state"              varchar2(10),
   "final"              varchar2(20)
);

/*==============================================================*/
/* Table: "t_pro_plan"                                          */
/*==============================================================*/
create table "t_pro_plan" 
(
   "planid"             number               not null,
   "taskid"             number,
   "planname"           varchar2(20),
   "state"              varchar2(20),
   "begintime"          date,
   "endtime"            date,
   "info"               varchar2(50),
   "desc"               varchar2(100),
   constraint PK_T_PRO_PLAN primary key ("planid")
);

/*==============================================================*/
/* Table: "t_pro_task"                                          */
/*==============================================================*/
create table "t_pro_task" 
(
   "taskid"             number               not null,
   "taskname"           varchar2(255),
   "begindate"          DATE,
   "enddate"            DATE,
   "status"             varchar2(20),
   USERID               NUMBER(11),
   "sharer"             NUMBER(11),
   "taskdesc"           varchar2(255),
   constraint PK_T_PRO_TASK primary key ("taskid")
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
   "netpay"             number(11,2),
   "overtimePay"        number(11,2),
   "taxes"              number(11,2),
   "netPayroll"         number(11,2),
   "absenteeism"        number(11,2),
   "lateAndEarly"       number(11,2),
   "leave"              number(11,2),
   "wageState"          varchar2(5),
   "wageDate"           date,
   "issuer"             NUMBER(11),
   constraint PK_T_WAGE primary key ("wageid")
);

/*==============================================================*/
/* Table: "welfare"                                             */
/*==============================================================*/
create table "welfare" 
(
   "welfareid"          number,
   "subsidy"            number(11,2),
   "carAllwance"        number(11,2),
   "netpay"             number(11,2),
   "medicallnsuranc"    number(11,2),
   "socialSecurity"     number(11,2)
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

alter table "t_evectionAccount"
   add constraint FK_T_EVECTI_REFERENCE_T_EVECTI foreign key ("evectionID")
      references "t_evection" ("evectionID");

alter table "t_leave"
   add constraint FK_T_LEAVE_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_overtim"
   add constraint FK_T_OVERTI_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_pro_dimission"
   add constraint FK_T_PRO_DI_REFERENCE_T_TREE_U foreign key (USERID)
      references T_TREE_USER (USERID);

alter table "t_pro_plan"
   add constraint FK_T_PRO_PL_REFERENCE_T_PRO_TA foreign key ("taskid")
      references "t_pro_task" ("taskid");

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

