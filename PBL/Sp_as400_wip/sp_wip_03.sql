--file name     : sp_wip_03.sql
--procedure name        : pbwip.sp_wip_03
--initial       : 2003.02.10
--desc    :  wip line detail report
--author       : kim ki sub

create procedure pbwip.sp_wip_03
(in @cmcd  char(2),
in @plant char(1),
in @dvsn  char(1),
in @pdcd  char(2),
in @yyyy  char(4),
in @mm    char(2),
in @dd    char(2))
language sql
begin
declare p_cnt decimal(10,0);
declare sqlcode integer default 0;
declare p_orct varchar(5);
declare p_pdcd varchar(2);
declare p_adjpdcd varchar(3);
declare p_pdnm varchar(30);
declare p_ochk varchar(15);
declare p_itno varchar(15);
declare p_itnm varchar(50);
declare p_itcl varchar(2);
declare p_srce varchar(2);
declare p_unit varchar(2);
declare p_convqty decimal(13,4) default 0;
declare p_qty decimal(8,3) default 0;
declare p_bgqt decimal(15,4) default 0;
declare p_inqt decimal(15,4) default 0;
declare p_usqt decimal(15,4) default 0;
declare p_usqt1 decimal(15,4) default 0;
declare p_usqt2 decimal(15,4) default 0;
declare p_prno varchar(15);
declare p_prnm varchar(50);
declare p_vorct varchar(5);
declare p_vrno varchar(10);
declare p_vrnm varchar(30);
declare p_prqt decimal(15,4) default 0;
declare p_chqt decimal(15,4) default 0;
declare p_ohqt decimal(15,4) default 0;
declare p_adjdt varchar(6);
declare at_end int default 0;
declare stmt varchar(256);
declare not_found condition for '02000';
-- cursor get wip002 line data
declare c1 cursor for
  select wborct,wbitno,wbpdcd,prname,wbdesc,wbitcl,
      wbsrce,wbunit,wbbgqt,wbinqt,wbusqt1,wbusqt2,
      (wbusqt3 + wbusqt4 + wbusqt5 + wbusqt6 + wbusqt7
      + wbusqt8),
      (wbbgqt + wbinqt - (wbusqt1 + wbusqt2 + wbusqt3
      + wbusqt4 + wbusqt5 + wbusqt6 + wbusqt7 + wbusqt8))
  from pbwip.wip002, pbcommon.dac007
  where wbcmcd = comltd and wbpdcd = prprcd and
        wbcmcd = @cmcd and wbplant = @plant and
        wbdvsn = @dvsn and wbyear = @yyyy and
        wbmonth = @mm and wbiocd = '1' and
        wbpdcd like p_adjpdcd and
        not( wbbgqt = 0 and wbinqt = 0 and wbusqt1 = 0 and
        wbusqt2 = 0 and wbusqt3 = 0 and wbusqt4 = 0 and
        wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
        wbusqt8 = 0 );

-- cursor get wip004 trans data
declare c2 cursor for
  select wdprno,itnm,wdprdpt,sum(case wdprsrty
  	when 'SM' then (-1) * wdprqt
  	when 'RS' then (-1) * wdprqt
  	else wdprqt
  	end),sum(wdchqt)
  from pbwip.wip004, pbinv.inv002
  where wdcmcd = comltd and wdprno = itno and
        wdcmcd = @cmcd and wdplant = @plant and
        wddvsn = @dvsn and wdslty in ('WC','WR') and
        substr(wddate,1,6) = p_adjdt and
        wditno = p_itno and wdiocd = '1' and
        wdchdpt = p_orct
        group by wdprno, itnm, wdprdpt;

-- cursor get qtemp/wiptemp01
declare c3 cursor for
  select twcmcd,twplant,twdvsn,tworct,twitno,twochk,
         twitnm,twpdcd,twpdnm,twitcl,twsrce,
         twunit,twbgqt,twinqt,twusqt,twprno,
         twprnm,twvrno,twvrnm,twprqt,twchqt,twohqt
  from qtemp.wiptemp01
  order by twpdcd,tworct,twitno,twochk;

declare continue handler for not_found
set at_end = 1;
declare continue handler for sqlstate '42704'
--create qtemp.wiptemp01
create table qtemp.wiptemp01(
  twcmcd char(2),twplant char(1),
  twdvsn char(1),tworct char(5),
  twitno char(15),twochk char(15),
  twitnm char(50),twpdcd char(2),
  twpdnm char(30),twitcl char(2),
  twsrce char(2),twunit char(2),
  twbgqt numeric(15,4),twinqt numeric(15,4),
  twusqt numeric(15,4),twprno char(15),
  twprnm char(50),twvrno char(10),
  twvrnm char(30),twprqt numeric(15,4),
  twchqt numeric(15,4),twohqt numeric(15,4),
  twqty numeric(8,3) );

delete from qtemp.wiptemp01;

set p_adjdt = @yyyy || @mm;
set p_adjpdcd = concat(trim(@pdcd),'%');
open c1;
fetch c1 into p_orct,p_itno,p_pdcd,p_pdnm,p_itnm,p_itcl,
              p_srce,p_unit,p_bgqt,p_inqt,p_usqt1,
              p_usqt2,p_usqt,p_ohqt;

while at_end = 0 do
--check option item check
 set p_ochk = pbpdm.f_bom_02(@cmcd,@plant,@dvsn,p_itno,
              @yyyy||@mm||@dd);

 select convqty into p_convqty
 from pbinv.inv101
 where comltd = @cmcd and xplant = @plant and
 			div = @dvsn and itno = p_itno;

set p_bgqt = p_bgqt / p_convqty;
set p_inqt = p_inqt / p_convqty;
set p_usqt1 = p_usqt1 / p_convqty;
set p_usqt2 = p_usqt2 / p_convqty;
set p_usqt = p_usqt / p_convqty;
set p_ohqt = p_ohqt / p_convqty;

--fetch wip004
set p_cnt = 0;
open c2;
fetch c2 into p_prno, p_prnm, p_vorct,
              p_prqt, p_chqt;
 while at_end = 0 do
 -- get vendor no, vendor name
  set p_cnt = p_cnt + 1;
  if substr(p_vorct,1,1) = 'D' then
    select vndr,vndnm  into p_vrno, p_vrnm
    from pbpur.pur101
    where comltd = @cmcd and scgubun = 'S' and
          vsrno = p_vorct;
    if sqlcode <> 0 then
       set p_vrno = ' ';
       set p_vrnm = ' ';
    end if;
  else
    set p_vrno = ' ';
    set p_vrnm = ' ';
  end if;
  set p_chqt = p_chqt / p_convqty;
  if p_prqt <> 0 then
  	set p_qty = p_chqt / p_prqt;
  else
  	set p_qty = 0;
  end if;
-- Inset qtemp.wiptemp01
insert into qtemp.wiptemp01 (twcmcd,twplant,twdvsn,
       tworct,twitno,twochk,twitnm,
       twpdcd,twpdnm,twitcl,twsrce,
       twunit,twbgqt,twinqt,twusqt,twprno,twprnm,
       twvrno,twvrnm,twprqt,twchqt,twohqt,twqty)
values (@cmcd,@plant,@dvsn,p_orct,p_itno,p_ochk,p_itnm,
       p_pdcd,p_pdnm,p_itcl,p_srce,p_unit,p_bgqt,p_inqt,
       p_usqt,p_prno,p_prnm,p_vrno,p_vrnm,p_prqt,
       p_chqt,p_ohqt,p_qty);
fetch c2 into p_prno, p_prnm, p_vorct,
              p_prqt, p_chqt;
end while;
close c2;
set at_end = 0;
if p_cnt = 0 then
   set p_prno = ' ';
   set p_prnm = ' ';
   set p_vrno = ' ';
   set p_vrnm = ' ';
   set p_prqt = 0;
   set p_chqt = 0;
   set p_qty = 0;
-- insert qtemp.wiptemp01
   insert into qtemp.wiptemp01 (twcmcd,twplant,twdvsn,
       tworct,twitno,twochk,twitnm,
       twpdcd,twpdnm,twitcl,twsrce,
       twunit,twbgqt,twinqt,twusqt,twprno,twprnm,
       twvrno,twvrnm,twprqt,twchqt,twohqt,twqty)
   values (@cmcd,@plant,@dvsn,p_orct,p_itno,p_ochk,p_itnm,
       p_pdcd,p_pdnm,p_itcl,p_srce,p_unit,p_bgqt,p_inqt,
       p_usqt,p_prno,p_prnm,p_vrno,p_vrnm,p_prqt,
       p_chqt,p_ohqt,p_qty);
end if;
fetch c1 into p_orct,p_itno,p_pdcd,p_pdnm,p_itnm,p_itcl,
         p_srce,p_unit,p_bgqt,p_inqt,p_usqt1,
         p_usqt2,p_usqt,p_ohqt;
end while;
close c1;
if sqlcode <> 0 then
   set sqlcode = -1;
else
   set sqlcode = 0;
end if;
end
