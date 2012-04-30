--file name     : pbwip.sp_wip_999.sql
--system        : kdac system
--proc name     : sp_wip_999
--initial       : 2003.03.21
--author        : kim ki sub
--desc          : Vendor quator sheet creation

drop procedure pbwip.sp_wip_999;
create procedure pbwip.sp_wip_999
 (in a_yyyy char(4))

language sql
begin
declare sqlcode integer default 0;
declare p_yy01 char(4);
declare p_yy02 char(4);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_div  char(1);
declare p_cnt int default 0;
declare at_end int default 0;
declare not_found condition for '02000';

delete from pbwip.wip999
where yydt = a_yyyy;

if a_yyyy = '1999' then
  set p_yy01 = '1999';
  set p_yy02 = '2000';
end if;

if a_yyyy = '2000' then
  set p_yy01 = '2000';
  set p_yy02 = '2001';
end if;

set p_cnt = 1;

inc_loop:
loop

if p_cnt > 11 then
   leave inc_loop;
end if;
--plant setting
case 
    when p_cnt = 1 then
      set p_plant = 'D';
      set p_dvsn  = 'A';
      set p_div   = 'A';
    when p_cnt = 2 then
      set p_plant = 'D';
      set p_dvsn  = 'H';
      set p_div   = 'H';
    when p_cnt = 3 then
      set p_plant = 'D';
      set p_dvsn  = 'M';
      set p_div   = 'M';
    when p_cnt = 4 then
      set p_plant = 'D';
      set p_dvsn  = 'S';
      set p_div   = 'S';
    when p_cnt = 5 then
      set p_plant = 'D';
      set p_dvsn  = 'V';
      set p_div   = 'V';
    when p_cnt = 6 then
      set p_plant = 'J';
      set p_dvsn  = 'M';
      set p_div   = 'B';
    when p_cnt = 7 then
      set p_plant = 'J';
      set p_dvsn  = 'S';
      set p_div   = 'L';
    when p_cnt = 8 then
      set p_plant = 'J';
      set p_dvsn  = 'H';
      set p_div   = 'T';
    when p_cnt = 9 then
      set p_plant = 'K';
      set p_dvsn  = 'M';
      set p_div   = 'P';
    when p_cnt = 10 then
      set p_plant = 'K';
      set p_dvsn  = 'S';
      set p_div   = 'N';
    when p_cnt = 11 then
      set p_plant = 'K';
      set p_dvsn  = 'H';
      set p_div   = 'O';
end case;

-- insert line
insert into pbwip.wip999(yydt,plant,dvsn,pdcd,pdnm,orct,itno,iocd, desc,spec,
  itcl,srce,unit,avrg1,bgqt,bgat1,inqt,inat,usqt1,usat1,usqt2,usat2,
  usqt3,usat3,usqt4,usat4,usqt5,usat5,usqt6,usat6,ohqt,ohat)
select a_yyyy,p_plant,p_dvsn,bb.pdcd,cc.prname,aa.wcorct,aa.wcitno,'1',
  aa.wcdsp,aa.wcspc,
  aa.wcclas, aa.wcsrc, aa.wcum,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN aa.wcavg1
    ELSE 0 END ) * bb.convqty , 15, 5 ) ) as avgcost,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN aa.wcbqt1
    ELSE 0 END ) / bb.convqty,13,2) ) as bgqt,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN aa.wcbat1
    ELSE 0 END ), 13, 0) ) as bgat,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcinqta1 + aa.wcinqta2 + aa.wcinqta3 +
  aa.wcinqta4 + aa.wcinqta5 +
  aa.wcinqta6 + aa.wcinqta7 + aa.wcinqta8 + aa.wcinqta9 +
  aa.wcinqta10 + aa.wcinqta11 + aa.wcinqta12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as inqt,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcinata1 + aa.wcinatb1 + aa.wcinata2
  + aa.wcinatb2 + aa.wcinata3 + aa.wcinatb3
  + aa.wcinata4 + aa.wcinatb4 + aa.wcinata5 + aa.wcinatb5
  + aa.wcinata6 + aa.wcinatb6
  + aa.wcinata7 + aa.wcinatb7 + aa.wcinata8 + aa.wcinatb8
  + aa.wcinata9 + aa.wcinatb9
  + aa.wcinata10 + aa.wcinatb10 + aa.wcinata11 + aa.wcinatb11
  + aa.wcinata12 + aa.wcinatb12)
    ELSE 0 END ) as inat,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqta1 + aa.wcusqta2 + aa.wcusqta3
  + aa.wcusqta4 + aa.wcusqta5 +
  aa.wcusqta6 + aa.wcusqta7 + aa.wcusqta8 + aa.wcusqta9 + aa.wcusqta10 +
  aa.wcusqta11 + aa.wcusqta12) / bb.convqty
    ELSE 0 END) , 13, 2) ) as usqta,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusata1 + aa.wcusata2 + aa.wcusata3
  + aa.wcusata4 + aa.wcusata5
  + aa.wcusata6 + aa.wcusata7 + aa.wcusata8 + aa.wcusata9 + aa.wcusata10
  + aa.wcusata11 + aa.wcusata12 )
    ELSE 0 END ) as usata,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqtb1 + aa.wcusqtb2 + aa.wcusqtb3
  + aa.wcusqtb4 + aa.wcusqtb5 +
  aa.wcusqtb6 + aa.wcusqtb7 + aa.wcusqtb8 + aa.wcusqtb9 + aa.wcusqtb10 +
  aa.wcusqtb11 + aa.wcusqtb12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtb,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3
  + aa.wcusatb4 + aa.wcusatb5
  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10
  + aa.wcusatb11 + aa.wcusatb12 )
    ELSE 0 END ) as usatb,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqtc1 + aa.wcusqtc2 + aa.wcusqtc3
  + aa.wcusqtc4 + aa.wcusqtc5 +
  aa.wcusqtc6 + aa.wcusqtc7 + aa.wcusqtc8 + aa.wcusqtc9 + aa.wcusqtc10 +
  aa.wcusqtc11 + aa.wcusqtc12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtc,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusatc1 + aa.wcusatc2 + aa.wcusatc3
  + aa.wcusatc4 + aa.wcusatc5
  + aa.wcusatc6 + aa.wcusatc7 + aa.wcusatc8 + aa.wcusatc9 + aa.wcusatc10
  + aa.wcusatc11 + aa.wcusatc12 )
    ELSE 0 END ) as usatc,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqtd1 + aa.wcusqtd2 + aa.wcusqtd3
  + aa.wcusqtd4 + aa.wcusqtd5 +
  aa.wcusqtd6 + aa.wcusqtd7 + aa.wcusqtd8 + aa.wcusqtd9 + aa.wcusqtd10 +
  aa.wcusqtd11 + aa.wcusqtd12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtd,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusatd1 + aa.wcusatd2 + aa.wcusatd3
  + aa.wcusatd4 + aa.wcusatd5
  + aa.wcusatd6 + aa.wcusatd7 + aa.wcusatd8 + aa.wcusatd9 + aa.wcusatd10
  + aa.wcusatd11 + aa.wcusatd12 )
    ELSE 0 END ) as usatd,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqte1 + aa.wcusqte2 + aa.wcusqte3
  + aa.wcusqte4 + aa.wcusqte5 +
  aa.wcusqte6 + aa.wcusqte7 + aa.wcusqte8 + aa.wcusqte9 + aa.wcusqte10 +
  aa.wcusqte11 + aa.wcusqte12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqte,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusate1 + aa.wcusate2 + aa.wcusate3
  + aa.wcusate4 + aa.wcusate5
  + aa.wcusate6 + aa.wcusate7 + aa.wcusate8 + aa.wcusate9 + aa.wcusate10
  + aa.wcusate11 + aa.wcusate12 )
    ELSE 0 END ) as usate,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqtf1 + aa.wcusqtf2 + aa.wcusqtf3
  + aa.wcusqtf4 + aa.wcusqtf5 +
  aa.wcusqtf6 + aa.wcusqtf7 + aa.wcusqtf8 + aa.wcusqtf9 + aa.wcusqtf10 +
  aa.wcusqtf11 + aa.wcusqtf12) / bb.convqty
    ELSE 0 END ) , 13, 2) ) as usqtf,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusatf1 + aa.wcusatf2 + aa.wcusatf3
  + aa.wcusatf4 + aa.wcusatf5
  + aa.wcusatf6 + aa.wcusatf7 + aa.wcusatf8 + aa.wcusatf9 + aa.wcusatf10
  + aa.wcusatf11 + aa.wcusatf12 )
    ELSE 0 END ) as usatf,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy02 THEN aa.wcbqt1
    ELSE 0 END ) / bb.convqty,13,2) ) as ohqt,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy02 THEN aa.wcbat1
    ELSE 0 END ), 13, 0) ) as ohat
from pbtest.wipdaw aa, pbinv.inv101 bb, pbcommon.dac007 cc
where aa.wcdiv = p_div and bb.comltd = '01' and bb.xplant = p_plant
and bb.div = p_dvsn
and aa.wcitno = bb.itno and bb.comltd = cc.comltd and bb.pdcd = cc.prprcd
and aa.wcyearc||aa.wcyeary >= p_yy01 and aa.wcyearc||aa.wcyeary <= p_yy02
and aa.wciocd = '1'

group by bb.pdcd,cc.prname,aa.wcorct,aa.wcitno,aa.wcdsp,aa.wcspc,
  aa.wcclas, aa.wcsrc, aa.wcum
order by bb.pdcd, aa.wcitno;

-- insert vendor
insert into pbwip.wip999(yydt,plant,dvsn,pdcd,pdnm,orct,itno,iocd, desc,spec,
  itcl,srce,unit,avrg1,bgqt,bgat1,inqt,inat,usqt1,usat1,usqt2,usat2,
  usqt3,usat3,usqt4,usat4,usqt5,usat5,usqt6,usat6,ohqt,ohat)
select a_yyyy,p_plant,p_dvsn,bb.pdcd,cc.prname,aa.wcorct,aa.wcitno,'2',
  aa.wcdsp,aa.wcspc,
  aa.wcclas, aa.wcsrc, aa.wcum,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN aa.wcavg1
    ELSE 0 END ) * bb.convqty , 15, 5 ) ) as avgcost,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN aa.wcbqt1
    ELSE 0 END ) / bb.convqty,13,2) ) as bgqt,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN aa.wcbat1
    ELSE 0 END ), 13, 0) ) as bgat,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcinqta1 + aa.wcinqta2 + aa.wcinqta3 +
  aa.wcinqta4 + aa.wcinqta5 +
  aa.wcinqta6 + aa.wcinqta7 + aa.wcinqta8 + aa.wcinqta9 +
  aa.wcinqta10 + aa.wcinqta11 + aa.wcinqta12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as inqt,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcinata1 + aa.wcinatb1 + aa.wcinata2
  + aa.wcinatb2 + aa.wcinata3 + aa.wcinatb3
  + aa.wcinata4 + aa.wcinatb4 + aa.wcinata5 + aa.wcinatb5
  + aa.wcinata6 + aa.wcinatb6
  + aa.wcinata7 + aa.wcinatb7 + aa.wcinata8 + aa.wcinatb8
  + aa.wcinata9 + aa.wcinatb9
  + aa.wcinata10 + aa.wcinatb10 + aa.wcinata11 + aa.wcinatb11
  + aa.wcinata12 + aa.wcinatb12)
    ELSE 0 END ) as inat,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqta1 + aa.wcusqta2 + aa.wcusqta3
  + aa.wcusqta4 + aa.wcusqta5 +
  aa.wcusqta6 + aa.wcusqta7 + aa.wcusqta8 + aa.wcusqta9 + aa.wcusqta10 +
  aa.wcusqta11 + aa.wcusqta12) / bb.convqty
    ELSE 0 END) , 13, 2) ) as usqta,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusata1 + aa.wcusata2 + aa.wcusata3
  + aa.wcusata4 + aa.wcusata5
  + aa.wcusata6 + aa.wcusata7 + aa.wcusata8 + aa.wcusata9 + aa.wcusata10
  + aa.wcusata11 + aa.wcusata12 )
    ELSE 0 END ) as usata,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqtb1 + aa.wcusqtb2 + aa.wcusqtb3
  + aa.wcusqtb4 + aa.wcusqtb5 +
  aa.wcusqtb6 + aa.wcusqtb7 + aa.wcusqtb8 + aa.wcusqtb9 + aa.wcusqtb10 +
  aa.wcusqtb11 + aa.wcusqtb12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtb,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3
  + aa.wcusatb4 + aa.wcusatb5
  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10
  + aa.wcusatb11 + aa.wcusatb12 )
    ELSE 0 END ) as usatb,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqtc1 + aa.wcusqtc2 + aa.wcusqtc3
  + aa.wcusqtc4 + aa.wcusqtc5 +
  aa.wcusqtc6 + aa.wcusqtc7 + aa.wcusqtc8 + aa.wcusqtc9 + aa.wcusqtc10 +
  aa.wcusqtc11 + aa.wcusqtc12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtc,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusatc1 + aa.wcusatc2 + aa.wcusatc3
  + aa.wcusatc4 + aa.wcusatc5
  + aa.wcusatc6 + aa.wcusatc7 + aa.wcusatc8 + aa.wcusatc9 + aa.wcusatc10
  + aa.wcusatc11 + aa.wcusatc12 )
    ELSE 0 END ) as usatc,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqtd1 + aa.wcusqtd2 + aa.wcusqtd3
  + aa.wcusqtd4 + aa.wcusqtd5 +
  aa.wcusqtd6 + aa.wcusqtd7 + aa.wcusqtd8 + aa.wcusqtd9 + aa.wcusqtd10 +
  aa.wcusqtd11 + aa.wcusqtd12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtd,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusatd1 + aa.wcusatd2 + aa.wcusatd3
  + aa.wcusatd4 + aa.wcusatd5
  + aa.wcusatd6 + aa.wcusatd7 + aa.wcusatd8 + aa.wcusatd9 + aa.wcusatd10
  + aa.wcusatd11 + aa.wcusatd12 )
    ELSE 0 END ) as usatd,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqte1 + aa.wcusqte2 + aa.wcusqte3
  + aa.wcusqte4 + aa.wcusqte5 +
  aa.wcusqte6 + aa.wcusqte7 + aa.wcusqte8 + aa.wcusqte9 + aa.wcusqte10 +
  aa.wcusqte11 + aa.wcusqte12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqte,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusate1 + aa.wcusate2 + aa.wcusate3
  + aa.wcusate4 + aa.wcusate5
  + aa.wcusate6 + aa.wcusate7 + aa.wcusate8 + aa.wcusate9 + aa.wcusate10
  + aa.wcusate11 + aa.wcusate12 )
    ELSE 0 END ) as usate,

  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusqtf1 + aa.wcusqtf2 + aa.wcusqtf3
  + aa.wcusqtf4 + aa.wcusqtf5 +
  aa.wcusqtf6 + aa.wcusqtf7 + aa.wcusqtf8 + aa.wcusqtf9 + aa.wcusqtf10 +
  aa.wcusqtf11 + aa.wcusqtf12) / bb.convqty
    ELSE 0 END ) , 13, 2) ) as usqtf,
  SUM( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy01 THEN (aa.wcusatf1 + aa.wcusatf2 + aa.wcusatf3
  + aa.wcusatf4 + aa.wcusatf5
  + aa.wcusatf6 + aa.wcusatf7 + aa.wcusatf8 + aa.wcusatf9 + aa.wcusatf10
  + aa.wcusatf11 + aa.wcusatf12 )
    ELSE 0 END ) as usatf,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy02 THEN aa.wcbqt1
    ELSE 0 END ) / bb.convqty,13,2) ) as ohqt,

  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
    WHEN p_yy02 THEN aa.wcbat1
    ELSE 0 END ), 13, 0) ) as ohat
from pbtest.wipdaw aa, pbinv.inv101 bb, pbcommon.dac007 cc
where aa.wcdiv = p_div and bb.comltd = '01' and bb.xplant = p_plant
and bb.div = p_dvsn
and aa.wcitno = bb.itno and bb.comltd = cc.comltd and bb.pdcd = cc.prprcd
and aa.wcyearc||aa.wcyeary >= p_yy01 and aa.wcyearc||aa.wcyeary <= p_yy02
and aa.wciocd = '2'

group by bb.pdcd,cc.prname,aa.wcorct,aa.wcitno,aa.wcdsp,aa.wcspc,
  aa.wcclas, aa.wcsrc, aa.wcum
order by bb.pdcd, aa.wcitno;

--insert inventory
insert into pbwip.wip999(yydt,plant,dvsn,pdcd,pdnm,orct,itno,iocd, desc,spec,
  itcl,srce,unit,avrg1,bgqt,bgat1,inqt,inat,usqt1,usat1,usqt2,usat2,
  usqt3,usat3,usqt4,usat4,usqt5,usat5,usqt6,usat6,ohqt,ohat)
select a_yyyy,p_plant,p_dvsn,bb.pdcd,cc.prname,' ',aa.woitno,'3',
  dd.itnm,dd.spec,
  aa.woitcl, aa.wosrce, bb.xunit,

  SUM( DECIMAL(( CASE aa.woyearc||aa.woyeary
    WHEN p_yy01 THEN aa.woavrg1
    ELSE 0 END ) * bb.convqty , 15, 5 ) ) as avgcost,

  SUM( 0 ) as bgqt,

  SUM( DECIMAL(( CASE aa.woyearc||aa.woyeary
    WHEN p_yy01 THEN aa.wobgat1
    ELSE 0 END ), 13, 0) ) as bgat,

  SUM( 0 ) as inqt,
  SUM( CASE aa.woyearc||aa.woyeary
    WHEN p_yy01 THEN (aa.woinat1 + aa.woinat2 + aa.woinat3 + aa.woinat4 
  + aa.woinat5 + aa.woinat6 + aa.woinat7 + aa.woinat8 + aa.woinat9
  + aa.woinata + aa.woinatb + aa.woinatc)
    ELSE 0 END ) as inat,

  SUM( 0 ) as usqta,
  SUM( CASE aa.woyearc||aa.woyeary
    WHEN p_yy01 THEN (aa.wousat1a + aa.wousat2a + aa.wousat3a
  + aa.wousat4a + aa.wousat5a
  + aa.wousat6a + aa.wousat7a + aa.wousat8a + aa.wousat9a + aa.wousataa
  + aa.wousatba + aa.wousatca )
    ELSE 0 END ) as usata,

  SUM( 0 ) as usqtb,
  SUM( CASE aa.woyearc||aa.woyeary
    WHEN p_yy01 THEN (aa.wousat1b + aa.wousat2b + aa.wousat3b
  + aa.wousat4b + aa.wousat5b
  + aa.wousat6b + aa.wousat7b + aa.wousat8b + aa.wousat9b + aa.wousatab
  + aa.wousatbb + aa.wousatcb )
    ELSE 0 END ) as usatb,

  SUM( 0 ) as usqtc,
  SUM( CASE aa.woyearc||aa.woyeary
    WHEN p_yy01 THEN (aa.wousat1c + aa.wousat2c + aa.wousat3c
  + aa.wousat4c + aa.wousat5c
  + aa.wousat6c + aa.wousat7c + aa.wousat8c + aa.wousat9c + aa.wousatac
  + aa.wousatbc + aa.wousatcc )
    ELSE 0 END ) as usatc,

  SUM( 0 ) as usqtd,
  SUM( CASE aa.woyearc||aa.woyeary
    WHEN p_yy01 THEN (aa.wousat1d + aa.wousat2d + aa.wousat3d
  + aa.wousat4d + aa.wousat5d
  + aa.wousat6d + aa.wousat7d + aa.wousat8d + aa.wousat9d + aa.wousatad
  + aa.wousatbd + aa.wousatcd )
    ELSE 0 END ) as usatd,

  SUM( 0 ) as usqte,
  SUM( 0 ) as usate,

  SUM( 0 ) as usqtf,
  SUM( 0 ) as usatf,

  SUM( 0 ) as ohqt,

  SUM( DECIMAL(( CASE aa.woyearc||aa.woyeary
    WHEN p_yy02 THEN aa.wobgat1
    ELSE 0 END ), 13, 0) ) as ohat
from pbtest.wipt42 aa, pbinv.inv101 bb, pbcommon.dac007 cc, pbinv.inv002 dd
where aa.wodiv = p_div and bb.comltd = '01' and bb.xplant = p_plant
and bb.div = p_dvsn and aa.woitno = dd.itno
and aa.woitno = bb.itno and bb.comltd = cc.comltd and bb.pdcd = cc.prprcd
and aa.woyearc||aa.woyeary >= p_yy01 and aa.woyearc||aa.woyeary <= p_yy02

group by bb.pdcd,cc.prname,aa.woitno,dd.itnm,dd.spec,
  aa.woitcl, aa.wosrce, bb.xunit
order by bb.pdcd, aa.woitno;

set p_cnt = p_cnt + 1;

end loop;

end
