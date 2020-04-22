/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/4/22 23:22:12                           */
/*==============================================================*/


drop table if exists bill;

drop table if exists customer;

drop table if exists datames;

drop table if exists distribute;

drop table if exists employee;

drop table if exists flitting;

drop table if exists mission;

drop table if exists orderdetail;

drop table if exists orders;

drop table if exists plans;

drop table if exists receipt;

drop table if exists station;

drop table if exists stockchange;

/*==============================================================*/
/* Table: bill                                                  */
/*==============================================================*/
create table bill
(
   bid                  int not null,
   oid                  int,
   sid                  int,
   eid                  int,
   status               int,
   regdate              datetime,
   primary key (bid)
);

/*==============================================================*/
/* Table: customer                                              */
/*==============================================================*/
create table customer
(
   cid                  int not null,
   cname                varchar(64),
   card                 varchar(64),
   work                 varchar(64),
   tel                  varchar(64),
   mobile               varchar(64),
   address              varchar(64),
   post                 varchar(64),
   email                varchar(64),
   area                 varchar(64),
   primary key (cid)
);

/*==============================================================*/
/* Table: datames                                               */
/*==============================================================*/
create table datames
(
   dtid                 int not null,
   dtype                varchar(30),
   dname                varchar(30),
   des                  varchar(30),
   primary key (dtid)
);

/*==============================================================*/
/* Table: distribute                                            */
/*==============================================================*/
create table distribute
(
   did                  int not null,
   odid                 int,
   sid                  int,
   dover                varchar(12),
   counts               int,
   ddate                datetime,
   dmoney               double,
   remark               varchar(100),
   primary key (did)
);

/*==============================================================*/
/* Table: employee                                              */
/*==============================================================*/
create table employee
(
   eid                  int not null,
   position             int,
   ename                varchar(60),
   pwd                  varchar(60),
   remark               varchar(60),
   primary key (eid)
);

/*==============================================================*/
/* Table: flitting                                              */
/*==============================================================*/
create table flitting
(
   fid                  int not null,
   oid                  int,
   ftype                int,
   outdate              datetime,
   fover                varchar(12),
   sid                  int,
   flitdate             datetime,
   primary key (fid)
);

/*==============================================================*/
/* Table: mission                                               */
/*==============================================================*/
create table mission
(
   mid                  int not null,
   oid                  int,
   fid                  int,
   sid                  int,
   mtype                int,
   status               int,
   totalmoney           double,
   comitedate           datetime,
   createdate           datetime,
   eid                  int,
   remark               varchar(100),
   primary key (mid)
);

/*==============================================================*/
/* Table: orderdetail                                           */
/*==============================================================*/
create table orderdetail
(
   odid                 int not null,
   oid                  int,
   cid                  int,
   manager              int,
   remark               varchar(120),
   planmoney            double,
   realmoney            double,
   managereason         varchar(120),
   managedate           datetime,
   primary key (odid)
);

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   oid                  int not null,
   cid                  int,
   otype                int,
   sid                  int,
   status               int,
   manager              int,
   createdate           datetime,
   comitedate           datetime,
   address              varchar(120),
   receiveman           varchar(120),
   receivetel           varchar(120),
   receivepost          varchar(120),
   bill                 int,
   payman               varchar(120),
   payaddress           varchar(120),
   paytel               varchar(120),
   paypost              varchar(120),
   managereason         varchar(120),
   managedate           datetime,
   remark               varchar(120),
   primary key (oid)
);

/*==============================================================*/
/* Table: plans                                                 */
/*==============================================================*/
create table plans
(
   pid                  int not null,
   fid                  int,
   managetype           int,
   handle               int,
   executestatus        int,
   managedate           datetime,
   account              varchar(12),
   remark               varchar(100),
   primary key (pid)
);

/*==============================================================*/
/* Table: receipt                                               */
/*==============================================================*/
create table receipt
(
   rid                  int not null,
   mid                  int,
   oid                  int,
   collback             int,
   primary key (rid)
);

/*==============================================================*/
/* Table: station                                               */
/*==============================================================*/
create table station
(
   sid                  int not null,
   levels               int,
   sname                varchar(36),
   saddress             varchar(36),
   addmin               varchar(36),
   primary key (sid)
);

/*==============================================================*/
/* Table: stockchange                                           */
/*==============================================================*/
create table stockchange
(
   scid                 int not null,
   pid                  int,
   did                  int,
   mid                  int,
   odid                 int,
   sdate                datetime,
   sid                  int,
   totalmoney           double,
   eid                  int,
   geteid               int,
   stype                int,
   remark               varchar(100),
   primary key (scid)
);

alter table bill add constraint FK_Reference_21 foreign key (oid)
      references orders (oid) on delete restrict on update restrict;

alter table bill add constraint FK_Reference_22 foreign key (sid)
      references station (sid) on delete restrict on update restrict;

alter table bill add constraint FK_Reference_23 foreign key (eid)
      references employee (eid) on delete restrict on update restrict;

alter table bill add constraint FK_Reference_24 foreign key (status)
      references datames (dtid) on delete restrict on update restrict;

alter table distribute add constraint FK_Reference_40 foreign key (odid)
      references orderdetail (odid) on delete restrict on update restrict;

alter table distribute add constraint FK_Reference_41 foreign key (sid)
      references station (sid) on delete restrict on update restrict;

alter table employee add constraint FK_Reference_6 foreign key (position)
      references datames (dtid) on delete restrict on update restrict;

alter table flitting add constraint FK_Reference_12 foreign key (oid)
      references orders (oid) on delete restrict on update restrict;

alter table flitting add constraint FK_Reference_13 foreign key (ftype)
      references datames (dtid) on delete restrict on update restrict;

alter table flitting add constraint FK_Reference_14 foreign key (sid)
      references station (sid) on delete restrict on update restrict;

alter table mission add constraint FK_Reference_15 foreign key (oid)
      references orders (oid) on delete restrict on update restrict;

alter table mission add constraint FK_Reference_16 foreign key (fid)
      references flitting (fid) on delete restrict on update restrict;

alter table mission add constraint FK_Reference_17 foreign key (sid)
      references station (sid) on delete restrict on update restrict;

alter table mission add constraint FK_Reference_18 foreign key (mtype)
      references datames (dtid) on delete restrict on update restrict;

alter table mission add constraint FK_Reference_19 foreign key (status)
      references datames (dtid) on delete restrict on update restrict;

alter table mission add constraint FK_Reference_20 foreign key (eid)
      references employee (eid) on delete restrict on update restrict;

alter table orderdetail add constraint FK_Reference_11 foreign key (manager)
      references employee (eid) on delete restrict on update restrict;

alter table orderdetail add constraint FK_Reference_2 foreign key (oid)
      references orders (oid) on delete restrict on update restrict;

alter table orderdetail add constraint FK_Reference_3 foreign key (cid)
      references customer (cid) on delete restrict on update restrict;

alter table orders add constraint FK_Reference_1 foreign key (cid)
      references customer (cid) on delete restrict on update restrict;

alter table orders add constraint FK_Reference_10 foreign key (manager)
      references employee (eid) on delete restrict on update restrict;

alter table orders add constraint FK_Reference_5 foreign key (otype)
      references datames (dtid) on delete restrict on update restrict;

alter table orders add constraint FK_Reference_8 foreign key (sid)
      references station (sid) on delete restrict on update restrict;

alter table orders add constraint FK_Reference_9 foreign key (status)
      references datames (dtid) on delete restrict on update restrict;

alter table plans add constraint FK_Reference_28 foreign key (fid)
      references flitting (fid) on delete restrict on update restrict;

alter table plans add constraint FK_Reference_29 foreign key (managetype)
      references datames (dtid) on delete restrict on update restrict;

alter table plans add constraint FK_Reference_30 foreign key (handle)
      references employee (eid) on delete restrict on update restrict;

alter table plans add constraint FK_Reference_31 foreign key (executestatus)
      references datames (dtid) on delete restrict on update restrict;

alter table receipt add constraint FK_Reference_25 foreign key (mid)
      references mission (mid) on delete restrict on update restrict;

alter table receipt add constraint FK_Reference_26 foreign key (oid)
      references orders (oid) on delete restrict on update restrict;

alter table receipt add constraint FK_Reference_27 foreign key (collback)
      references datames (dtid) on delete restrict on update restrict;

alter table station add constraint FK_Reference_7 foreign key (levels)
      references datames (dtid) on delete restrict on update restrict;

alter table stockchange add constraint FK_Reference_32 foreign key (pid)
      references plans (pid) on delete restrict on update restrict;

alter table stockchange add constraint FK_Reference_33 foreign key (did)
      references distribute (did) on delete restrict on update restrict;

alter table stockchange add constraint FK_Reference_34 foreign key (mid)
      references mission (mid) on delete restrict on update restrict;

alter table stockchange add constraint FK_Reference_35 foreign key (odid)
      references orderdetail (odid) on delete restrict on update restrict;

alter table stockchange add constraint FK_Reference_36 foreign key (sid)
      references station (sid) on delete restrict on update restrict;

alter table stockchange add constraint FK_Reference_37 foreign key (eid)
      references employee (eid) on delete restrict on update restrict;

alter table stockchange add constraint FK_Reference_38 foreign key (geteid)
      references employee (eid) on delete restrict on update restrict;

alter table stockchange add constraint FK_Reference_39 foreign key (stype)
      references datames (dtid) on delete restrict on update restrict;

