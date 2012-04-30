--file name     : pbwip.sp_wip_998.sql
--system        : kdac system
--proc name     : sp_wip_998
--initial       : 2003.03.21
--author        : kim ki sub
--desc          : Vendor quator sheet creation

drop procedure pbwip.sp_wip_998;
create procedure pbwip.sp_wip_998
 (in a_yyyy char(4))

language sql
begin
declare sqlcode integer default 0;
declare p_yy01 char(4);
declare p_yy02 char(4);
declare p_mm  char(2);
declare p_plant char(1);
declare p_dvsn char(1);
declare p_div  char(1);
declare p_cnt int default 0;
declare p_cnty int default 0;
declare at_end int default 0;
declare not_found condition for '02000';

delete from pbwip.wip998
where yydt = a_yyyy;

if a_yyyy = '1999' then
  set p_yy01 = '1999';
  set p_yy02 = '2000';
end if;

if a_yyyy = '2000' then
  set p_yy01 = '2000';
  set p_yy02 = '2001';
end if;

if a_yyyy = '2001' then
  set p_yy01 = '2001';
  set p_yy02 = '2002';
end if;


set p_cnt = 1;

inc_loop:
loop

if p_cnt > 11 then
   leave inc_loop;
end if;
set p_cnty = 1;
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

inc_loopy:
loop

if p_cnty > 12 then
  leave inc_loopy;
end if;
set p_mm = cast(p_cnty as char(2));
-- insert line
insert into pbwip.wip998(yydt,mmdt,plant,dvsn,pdcd,pdnm,orct,itno,iocd, desc,
  spec,itcl,srce,unit,avrg1,bgqt,bgat1,inqt,inat,usqt1,usat1,usqt2,usat2,
  usqt3,usat3,usqt4,usat4,usqt5,usat5,usqt6,usat6,ohqt,ohat)
select a_yyyy,p_mm,p_plant,p_dvsn,bb.pdcd,cc.prname,aa.wcorct,
  aa.wcitno,aa.wciocd,aa.wcdsp,aa.wcspc,
  aa.wcclas, aa.wcsrc, aa.wcum,
  decimal( case when p_cnty = 1 then aa.wcavg1 * bb.convqty
    when p_cnty = 2 then aa.wcavg2 * bb.convqty
    when p_cnty = 3 then aa.wcavg3 * bb.convqty
    when p_cnty = 4 then aa.wcavg4 * bb.convqty
    when p_cnty = 5 then aa.wcavg5 * bb.convqty
    when p_cnty = 6 then aa.wcavg6 * bb.convqty
    when p_cnty = 7 then aa.wcavg7 * bb.convqty
    when p_cnty = 8 then aa.wcavg8 * bb.convqty
    when p_cnty = 9 then aa.wcavg9 * bb.convqty
    when p_cnty = 10 then aa.wcavg10 * bb.convqty
    when p_cnty = 11 then aa.wcavg11 * bb.convqty
    when p_cnty = 12 then aa.wcavg12 * bb.convqty
    else 0 end , 15, 5 ) as avgcost,
  DECIMAL( case when p_cnty = 1 then aa.wcbqt1 / bb.convqty
    when p_cnty = 2 then aa.wcbqt2 / bb.convqty
    when p_cnty = 3 then aa.wcbqt3 / bb.convqty
    when p_cnty = 4 then aa.wcbqt4 / bb.convqty
    when p_cnty = 5 then aa.wcbqt5 / bb.convqty
    when p_cnty = 6 then aa.wcbqt6 / bb.convqty
    when p_cnty = 7 then aa.wcbqt7 / bb.convqty
    when p_cnty = 8 then aa.wcbqt8 / bb.convqty
    when p_cnty = 9 then aa.wcbqt9 / bb.convqty
    when p_cnty = 10 then aa.wcbqt10 / bb.convqty
    when p_cnty = 11 then aa.wcbqt11 / bb.convqty
    when p_cnty = 12 then aa.wcbqt12 / bb.convqty
    else 0 end,13,2) as bgqt,
  (case when p_cnty = 1 then aa.wcbat1
    when p_cnty = 2 then aa.wcbat2
    when p_cnty = 3 then aa.wcbat3
    when p_cnty = 4 then aa.wcbat4
    when p_cnty = 5 then aa.wcbat5
    when p_cnty = 6 then aa.wcbat6
    when p_cnty = 7 then aa.wcbat7
    when p_cnty = 8 then aa.wcbat8
    when p_cnty = 9 then aa.wcbat9
    when p_cnty = 10 then aa.wcbat10
    when p_cnty = 11 then aa.wcbat11
    when p_cnty = 12 then aa.wcbat12
    else 0 end) as bgat,
  decimal(case when p_cnty = 1 then aa.wcinqta1 / bb.convqty
    when p_cnty = 2 then aa.wcinqta2 / bb.convqty
    when p_cnty = 3 then aa.wcinqta3 / bb.convqty
    when p_cnty = 4 then aa.wcinqta4 / bb.convqty
    when p_cnty = 5 then aa.wcinqta5 / bb.convqty
    when p_cnty = 6 then aa.wcinqta6 / bb.convqty
    when p_cnty = 7 then aa.wcinqta7 / bb.convqty
    when p_cnty = 8 then aa.wcinqta8 / bb.convqty
    when p_cnty = 9 then aa.wcinqta9 / bb.convqty
    when p_cnty = 10 then aa.wcinqta10 / bb.convqty
    when p_cnty = 11 then aa.wcinqta11 / bb.convqty
    when p_cnty = 12 then aa.wcinqta12 / bb.convqty
    else 0 end , 13, 2)  as inqt,
  (case when p_cnty = 1 then aa.wcinata1 + aa.wcinatb1
    when p_cnty = 2 then aa.wcinata2 + aa.wcinatb2
    when p_cnty = 3 then aa.wcinata3 + aa.wcinatb3
    when p_cnty = 4 then aa.wcinata4 + aa.wcinatb4
    when p_cnty = 5 then aa.wcinata5 + aa.wcinatb5
    when p_cnty = 6 then aa.wcinata6 + aa.wcinatb6
    when p_cnty = 7 then aa.wcinata7 + aa.wcinatb7
    when p_cnty = 8 then aa.wcinata8 + aa.wcinatb8
    when p_cnty = 9 then aa.wcinata9 + aa.wcinatb9
    when p_cnty = 10 then aa.wcinata10 + aa.wcinatb10
    when p_cnty = 11 then aa.wcinata11 + aa.wcinatb11
    when p_cnty = 12 then aa.wcinata12 + aa.wcinatb12
    else 0 end) as inat,
  decimal(case when p_cnty = 1 then aa.wcusqta1 / bb.convqty
    when p_cnty = 2 then aa.wcusqta2 / bb.convqty
    when p_cnty = 3 then aa.wcusqta3 / bb.convqty
    when p_cnty = 4 then aa.wcusqta4 / bb.convqty
    when p_cnty = 5 then aa.wcusqta5 / bb.convqty
    when p_cnty = 6 then aa.wcusqta6 / bb.convqty
    when p_cnty = 7 then aa.wcusqta7 / bb.convqty
    when p_cnty = 8 then aa.wcusqta8 / bb.convqty
    when p_cnty = 9 then aa.wcusqta9 / bb.convqty
    when p_cnty = 10 then aa.wcusqta10 / bb.convqty
    when p_cnty = 11 then aa.wcusqta11 / bb.convqty
    when p_cnty = 12 then aa.wcusqta12 / bb.convqty
    else 0 end , 13, 2)  as usqta,
  (case when p_cnty = 1 then aa.wcusata1
    when p_cnty = 2 then aa.wcusata2
    when p_cnty = 3 then aa.wcusata3
    when p_cnty = 4 then aa.wcusata4
    when p_cnty = 5 then aa.wcusata5
    when p_cnty = 6 then aa.wcusata6
    when p_cnty = 7 then aa.wcusata7
    when p_cnty = 8 then aa.wcusata8
    when p_cnty = 9 then aa.wcusata9
    when p_cnty = 10 then aa.wcusata10
    when p_cnty = 11 then aa.wcusata11
    when p_cnty = 12 then aa.wcusata12
    else 0 end) as usata,
  decimal(case when p_cnty = 1 then aa.wcusqtb1 / bb.convqty
    when p_cnty = 2 then aa.wcusqtb2 / bb.convqty
    when p_cnty = 3 then aa.wcusqtb3 / bb.convqty
    when p_cnty = 4 then aa.wcusqtb4 / bb.convqty
    when p_cnty = 5 then aa.wcusqtb5 / bb.convqty
    when p_cnty = 6 then aa.wcusqtb6 / bb.convqty
    when p_cnty = 7 then aa.wcusqtb7 / bb.convqty
    when p_cnty = 8 then aa.wcusqtb8 / bb.convqty
    when p_cnty = 9 then aa.wcusqtb9 / bb.convqty
    when p_cnty = 10 then aa.wcusqtb10 / bb.convqty
    when p_cnty = 11 then aa.wcusqtb11 / bb.convqty
    when p_cnty = 12 then aa.wcusqtb12 / bb.convqty
    else 0 end, 13, 2)  as usqtb,
  (case when p_cnty = 1 then aa.wcusatb1
    when p_cnty = 2 then aa.wcusatb2
    when p_cnty = 3 then aa.wcusatb3
    when p_cnty = 4 then aa.wcusatb4
    when p_cnty = 5 then aa.wcusatb5
    when p_cnty = 6 then aa.wcusatb6
    when p_cnty = 7 then aa.wcusatb7
    when p_cnty = 8 then aa.wcusatb8
    when p_cnty = 9 then aa.wcusatb9
    when p_cnty = 10 then aa.wcusatb10
    when p_cnty = 11 then aa.wcusatb11
    when p_cnty = 12 then aa.wcusatb12
    else 0 end) as usatb,
  decimal(case when p_cnty = 1 then aa.wcusqtc1 / bb.convqty
    when p_cnty = 2 then aa.wcusqtc2 / bb.convqty
    when p_cnty = 3 then aa.wcusqtc3 / bb.convqty
    when p_cnty = 4 then aa.wcusqtc4 / bb.convqty
    when p_cnty = 5 then aa.wcusqtc5 / bb.convqty
    when p_cnty = 6 then aa.wcusqtc6 / bb.convqty
    when p_cnty = 7 then aa.wcusqtc7 / bb.convqty
    when p_cnty = 8 then aa.wcusqtc8 / bb.convqty
    when p_cnty = 9 then aa.wcusqtc9 / bb.convqty
    when p_cnty = 10 then aa.wcusqtc10 / bb.convqty
    when p_cnty = 11 then aa.wcusqtc11 / bb.convqty
    when p_cnty = 12 then aa.wcusqtc12 / bb.convqty
    else 0 end , 13, 2)  as usqtc,
  (case when p_cnty = 1 then aa.wcusatc1
    when p_cnty = 2 then aa.wcusatc2
    when p_cnty = 3 then aa.wcusatc3
    when p_cnty = 4 then aa.wcusatc4
    when p_cnty = 5 then aa.wcusatc5
    when p_cnty = 6 then aa.wcusatc6
    when p_cnty = 7 then aa.wcusatc7
    when p_cnty = 8 then aa.wcusatc8
    when p_cnty = 9 then aa.wcusatc9
    when p_cnty = 10 then aa.wcusatc10
    when p_cnty = 11 then aa.wcusatc11
    when p_cnty = 12 then aa.wcusatc12
    else 0 end) as usatc,
  decimal(case when p_cnty = 1 then aa.wcusqtd1 / bb.convqty
    when p_cnty = 2 then aa.wcusqtd2 / bb.convqty
    when p_cnty = 3 then aa.wcusqtd3 / bb.convqty
    when p_cnty = 4 then aa.wcusqtd4 / bb.convqty
    when p_cnty = 5 then aa.wcusqtd5 / bb.convqty
    when p_cnty = 6 then aa.wcusqtd6 / bb.convqty
    when p_cnty = 7 then aa.wcusqtd7 / bb.convqty
    when p_cnty = 8 then aa.wcusqtd8 / bb.convqty
    when p_cnty = 9 then aa.wcusqtd9 / bb.convqty
    when p_cnty = 10 then aa.wcusqtd10 / bb.convqty
    when p_cnty = 11 then aa.wcusqtd11 / bb.convqty
    when p_cnty = 12 then aa.wcusqtd12 / bb.convqty
    else 0 end , 13, 2)  as usqtd,
  (case when p_cnty = 1 then aa.wcusatd1
    when p_cnty = 2 then aa.wcusatd2
    when p_cnty = 3 then aa.wcusatd3
    when p_cnty = 4 then aa.wcusatd4
    when p_cnty = 5 then aa.wcusatd5
    when p_cnty = 6 then aa.wcusatd6
    when p_cnty = 7 then aa.wcusatd7
    when p_cnty = 8 then aa.wcusatd8
    when p_cnty = 9 then aa.wcusatd9
    when p_cnty = 10 then aa.wcusatd10
    when p_cnty = 11 then aa.wcusatd11
    when p_cnty = 12 then aa.wcusatd12
    else 0 end) as usatd,
  decimal(case when p_cnty = 1 then aa.wcusqte1 / bb.convqty
    when p_cnty = 2 then aa.wcusqte2 / bb.convqty
    when p_cnty = 3 then aa.wcusqte3 / bb.convqty
    when p_cnty = 4 then aa.wcusqte4 / bb.convqty
    when p_cnty = 5 then aa.wcusqte5 / bb.convqty
    when p_cnty = 6 then aa.wcusqte6 / bb.convqty
    when p_cnty = 7 then aa.wcusqte7 / bb.convqty
    when p_cnty = 8 then aa.wcusqte8 / bb.convqty
    when p_cnty = 9 then aa.wcusqte9 / bb.convqty
    when p_cnty = 10 then aa.wcusqte10 / bb.convqty
    when p_cnty = 11 then aa.wcusqte11 / bb.convqty
    when p_cnty = 12 then aa.wcusqte12 / bb.convqty
    else 0 end , 13, 2)  as usqte,
  (case when p_cnty = 1 then aa.wcusate1
    when p_cnty = 2 then aa.wcusate2
    when p_cnty = 3 then aa.wcusate3
    when p_cnty = 4 then aa.wcusate4
    when p_cnty = 5 then aa.wcusate5
    when p_cnty = 6 then aa.wcusate6
    when p_cnty = 7 then aa.wcusate7
    when p_cnty = 8 then aa.wcusate8
    when p_cnty = 9 then aa.wcusate9
    when p_cnty = 10 then aa.wcusate10
    when p_cnty = 11 then aa.wcusate11
    when p_cnty = 12 then aa.wcusate12
    else 0 end) as usate,
  decimal(case when p_cnty = 1 then aa.wcusqtf1 / bb.convqty
    when p_cnty = 2 then aa.wcusqtf2 / bb.convqty
    when p_cnty = 3 then aa.wcusqtf3 / bb.convqty
    when p_cnty = 4 then aa.wcusqtf4 / bb.convqty
    when p_cnty = 5 then aa.wcusqtf5 / bb.convqty
    when p_cnty = 6 then aa.wcusqtf6 / bb.convqty
    when p_cnty = 7 then aa.wcusqtf7 / bb.convqty
    when p_cnty = 8 then aa.wcusqtf8 / bb.convqty
    when p_cnty = 9 then aa.wcusqtf9 / bb.convqty
    when p_cnty = 10 then aa.wcusqtf10 / bb.convqty
    when p_cnty = 11 then aa.wcusqtf11 / bb.convqty
    when p_cnty = 12 then aa.wcusqtf12 / bb.convqty
    else 0 end , 13, 2)  as usqtf,
  (case when p_cnty = 1 then aa.wcusatf1
    when p_cnty = 2 then aa.wcusatf2
    when p_cnty = 3 then aa.wcusatf3
    when p_cnty = 4 then aa.wcusatf4
    when p_cnty = 5 then aa.wcusatf5
    when p_cnty = 6 then aa.wcusatf6
    when p_cnty = 7 then aa.wcusatf7
    when p_cnty = 8 then aa.wcusatf8
    when p_cnty = 9 then aa.wcusatf9
    when p_cnty = 10 then aa.wcusatf10
    when p_cnty = 11 then aa.wcusatf11
    when p_cnty = 12 then aa.wcusatf12
    else 0 end) as usatf,
  DECIMAL( case when p_cnty = 1 then aa.wcbqt2 / bb.convqty
    when p_cnty = 2 then aa.wcbqt3 / bb.convqty
    when p_cnty = 3 then aa.wcbqt4 / bb.convqty
    when p_cnty = 4 then aa.wcbqt5 / bb.convqty
    when p_cnty = 5 then aa.wcbqt6 / bb.convqty
    when p_cnty = 6 then aa.wcbqt7 / bb.convqty
    when p_cnty = 7 then aa.wcbqt8 / bb.convqty
    when p_cnty = 8 then aa.wcbqt9 / bb.convqty
    when p_cnty = 9 then aa.wcbqt10 / bb.convqty
    when p_cnty = 10 then aa.wcbqt11 / bb.convqty
    when p_cnty = 11 then aa.wcbqt12 / bb.convqty
    else 0 end,13,2) as ohqt,
  (case when p_cnty = 1 then aa.wcbat2
    when p_cnty = 2 then aa.wcbat3
    when p_cnty = 3 then aa.wcbat4
    when p_cnty = 4 then aa.wcbat5
    when p_cnty = 5 then aa.wcbat6
    when p_cnty = 6 then aa.wcbat7
    when p_cnty = 7 then aa.wcbat8
    when p_cnty = 8 then aa.wcbat9
    when p_cnty = 9 then aa.wcbat10
    when p_cnty = 10 then aa.wcbat11
    when p_cnty = 11 then aa.wcbat12
    else 0 end) as ohat

from pbtest.wipdaw aa, pbinv.inv101 bb, pbcommon.dac007 cc
where aa.wcdiv = p_div and bb.comltd = '01' and bb.xplant = p_plant
and bb.div = p_dvsn
and aa.wcitno = bb.itno and bb.comltd = cc.comltd and bb.pdcd = cc.prprcd
and aa.wcyearc||aa.wcyeary = p_yy01;

--insert inventory
insert into pbwip.wip998(yydt,mmdt,plant,dvsn,pdcd,pdnm,orct,itno,iocd,
  desc,spec,itcl,srce,unit,avrg1,bgqt,bgat1,inqt,inat,usqt1,usat1,usqt2,
  usat2,usqt3,usat3,usqt4,usat4,usqt5,usat5,usqt6,usat6,ohqt,ohat)
select a_yyyy,p_mm,p_plant,p_dvsn,bb.pdcd,cc.prname,' ',aa.woitno,'3',
  dd.itnm,dd.spec,
  aa.woitcl, aa.wosrce, bb.xunit,

  decimal( case when p_cnty = 1 then aa.woavrg1 * bb.convqty
    when p_cnty = 2 then aa.woavrg2 * bb.convqty
    when p_cnty = 3 then aa.woavrg3 * bb.convqty
    when p_cnty = 4 then aa.woavrg4 * bb.convqty
    when p_cnty = 5 then aa.woavrg5 * bb.convqty
    when p_cnty = 6 then aa.woavrg6 * bb.convqty
    when p_cnty = 7 then aa.woavrg7 * bb.convqty
    when p_cnty = 8 then aa.woavrg8 * bb.convqty
    when p_cnty = 9 then aa.woavrg9 * bb.convqty
    when p_cnty = 10 then aa.woavrga * bb.convqty
    when p_cnty = 11 then aa.woavrgb * bb.convqty
    else aa.woavrgc * bb.convqty end , 15, 5 ) as avgcost,

  0 as bgqt,

  (case when p_cnty = 1 then aa.wobgat1
    when p_cnty = 2 then aa.wobgat2
    when p_cnty = 3 then aa.wobgat3
    when p_cnty = 4 then aa.wobgat4
    when p_cnty = 5 then aa.wobgat5
    when p_cnty = 6 then aa.wobgat6
    when p_cnty = 7 then aa.wobgat7
    when p_cnty = 8 then aa.wobgat8
    when p_cnty = 9 then aa.wobgat9
    when p_cnty = 10 then aa.wobgata
    when p_cnty = 11 then aa.wobgatb
    when p_cnty = 12 then aa.wobgatc
    else 0 end) as bgat,
  0 as inqt,
  (case when p_cnty = 1 then aa.woinat1
    when p_cnty = 2 then aa.woinat2
    when p_cnty = 3 then aa.woinat3
    when p_cnty = 4 then aa.woinat4
    when p_cnty = 5 then aa.woinat5
    when p_cnty = 6 then aa.woinat6
    when p_cnty = 7 then aa.woinat7
    when p_cnty = 8 then aa.woinat8
    when p_cnty = 9 then aa.woinat9
    when p_cnty = 10 then aa.woinata
    when p_cnty = 11 then aa.woinatb
    when p_cnty = 12 then aa.woinatc
    else 0 end) as inat,
  0 as usqta,
  (case when p_cnty = 1 then aa.wousat1a
    when p_cnty = 2 then aa.wousat2a
    when p_cnty = 3 then aa.wousat3a
    when p_cnty = 4 then aa.wousat4a
    when p_cnty = 5 then aa.wousat5a
    when p_cnty = 6 then aa.wousat6a
    when p_cnty = 7 then aa.wousat7a
    when p_cnty = 8 then aa.wousat8a
    when p_cnty = 9 then aa.wousat9a
    when p_cnty = 10 then aa.wousataa
    when p_cnty = 11 then aa.wousatba
    when p_cnty = 12 then aa.wousatca
    else 0 end) as usata,
  0 as usqtb,
  (case when p_cnty = 1 then aa.wousat1b
    when p_cnty = 2 then aa.wousat2b
    when p_cnty = 3 then aa.wousat3b
    when p_cnty = 4 then aa.wousat4b
    when p_cnty = 5 then aa.wousat5b
    when p_cnty = 6 then aa.wousat6b
    when p_cnty = 7 then aa.wousat7b
    when p_cnty = 8 then aa.wousat8b
    when p_cnty = 9 then aa.wousat9b
    when p_cnty = 10 then aa.wousatab
    when p_cnty = 11 then aa.wousatbb
    when p_cnty = 12 then aa.wousatcb
    else 0 end) as usatb,
  0 as usqtc,
  (case when p_cnty = 1 then aa.wousat1c
    when p_cnty = 2 then aa.wousat2c
    when p_cnty = 3 then aa.wousat3c
    when p_cnty = 4 then aa.wousat4c
    when p_cnty = 5 then aa.wousat5c
    when p_cnty = 6 then aa.wousat6c
    when p_cnty = 7 then aa.wousat7c
    when p_cnty = 8 then aa.wousat8c
    when p_cnty = 9 then aa.wousat9c
    when p_cnty = 10 then aa.wousatac
    when p_cnty = 11 then aa.wousatbc
    when p_cnty = 12 then aa.wousatcc
    else 0 end) as usatc,
  0 as usqtd,
  (case when p_cnty = 1 then aa.wousat1d
    when p_cnty = 2 then aa.wousat2d
    when p_cnty = 3 then aa.wousat3d
    when p_cnty = 4 then aa.wousat4d
    when p_cnty = 5 then aa.wousat5d
    when p_cnty = 6 then aa.wousat6d
    when p_cnty = 7 then aa.wousat7d
    when p_cnty = 8 then aa.wousat8d
    when p_cnty = 9 then aa.wousat9d
    when p_cnty = 10 then aa.wousatad
    when p_cnty = 11 then aa.wousatbd
    when p_cnty = 12 then aa.wousatcd
    else 0 end) as usatd,
  0 as usqte,
  0 as usate,
  0 as usqtf,
  0 as usatf,
  0 as ohqt,
  (case when p_cnty = 1 then aa.wobgat2
    when p_cnty = 2 then aa.wobgat3
    when p_cnty = 3 then aa.wobgat4
    when p_cnty = 4 then aa.wobgat5
    when p_cnty = 5 then aa.wobgat6
    when p_cnty = 6 then aa.wobgat7
    when p_cnty = 7 then aa.wobgat8
    when p_cnty = 8 then aa.wobgat9
    when p_cnty = 9 then aa.wobgata
    when p_cnty = 10 then aa.wobgatb
    when p_cnty = 11 then aa.wobgatc
    else 0 end) as ohat
from pbtest.wipt42 aa, pbinv.inv101 bb, pbcommon.dac007 cc, pbinv.inv002 dd
where aa.wodiv = p_div and bb.comltd = '01' and bb.xplant = p_plant
and bb.div = p_dvsn and aa.woitno = dd.itno
and aa.woitno = bb.itno and bb.comltd = cc.comltd and bb.pdcd = cc.prprcd
and aa.woyearc||aa.woyeary = p_yy01;

set p_cnty = p_cnty + 1;
end loop;

set p_cnt = p_cnt + 1;

end loop;

end
