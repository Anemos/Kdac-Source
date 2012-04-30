select 'D','A',bb.pdcd,cc.prname,aa.wcorct,aa.wcitno,aa.wcdsp,aa.wcspc,
  aa.wcclas, aa.wcsrc, aa.wcum,
  
  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN aa.wcavg1
		ELSE 0 END ) * bb.convqty , 15, 5 ) ) as avgcost, 
  
  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN aa.wcbqt1
		ELSE 0 END ) / bb.convqty,13,2) ) as bgqt,
  
  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN aa.wcbat1
		ELSE 0 END ), 13, 0) ) as bgat,
  
  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcinqta1 + aa.wcinqta2 + aa.wcinqta3 + aa.wcinqta4 + aa.wcinqta5 +
  aa.wcinqta6 + aa.wcinqta7 + aa.wcinqta8 + aa.wcinqta9 + aa.wcinqta10 +
  aa.wcinqta11 + aa.wcinqta12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as inqt,
  SUM( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcinata1 + aa.wcinatb1 + aa.wcinata2 + aa.wcinatb2 + aa.wcinata3 + aa.wcinatb3
  + aa.wcinata4 + aa.wcinatb4 + aa.wcinata5 + aa.wcinatb5 + aa.wcinata6 + aa.wcinatb6
  + aa.wcinata7 + aa.wcinatb7 + aa.wcinata8 + aa.wcinatb8 + aa.wcinata9 + aa.wcinatb9
  + aa.wcinata10 + aa.wcinatb10 + aa.wcinata11 + aa.wcinatb11 
  + aa.wcinata12 + aa.wcinatb12)
    ELSE 0 END ) as inat,
  
  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusqta1 + aa.wcusqta2 + aa.wcusqta3 + aa.wcusqta4 + aa.wcusqta5 +
  aa.wcusqta6 + aa.wcusqta7 + aa.wcusqta8 + aa.wcusqta9 + aa.wcusqta10 +
  aa.wcusqta11 + aa.wcusqta12) / bb.convqty
    ELSE 0 END) , 13, 2) ) as usqta,
  SUM( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusata1 + aa.wcusata2 + aa.wcusata3 + aa.wcusata4 + aa.wcusata5 
  + aa.wcusata6 + aa.wcusata7 + aa.wcusata8 + aa.wcusata9 + aa.wcusata10 
  + aa.wcusata11 + aa.wcusata12 )
    ELSE 0 END ) as usata,
  
  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusqtb1 + aa.wcusqtb2 + aa.wcusqtb3 + aa.wcusqtb4 + aa.wcusqtb5 +
  aa.wcusqtb6 + aa.wcusqtb7 + aa.wcusqtb8 + aa.wcusqtb9 + aa.wcusqtb10 +
  aa.wcusqtb11 + aa.wcusqtb12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtb,
  SUM( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3 + aa.wcusatb4 + aa.wcusatb5 
  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10 
  + aa.wcusatb11 + aa.wcusatb12 )
    ELSE 0 END ) as usatb,
  
  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusqtc1 + aa.wcusqtc2 + aa.wcusqtc3 + aa.wcusqtc4 + aa.wcusqtc5 +
  aa.wcusqtc6 + aa.wcusqtc7 + aa.wcusqtc8 + aa.wcusqtc9 + aa.wcusqtc10 +
  aa.wcusqtc11 + aa.wcusqtc12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtc,
  SUM( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3 + aa.wcusatb4 + aa.wcusatb5 
  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10 
  + aa.wcusatb11 + aa.wcusatc12 )
    ELSE 0 END ) as usatc,
  
  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusqtd1 + aa.wcusqtd2 + aa.wcusqtd3 + aa.wcusqtd4 + aa.wcusqtd5 +
  aa.wcusqtd6 + aa.wcusqtd7 + aa.wcusqtd8 + aa.wcusqtd9 + aa.wcusqtd10 +
  aa.wcusqtd11 + aa.wcusqtd12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqtd,
  SUM( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3 + aa.wcusatb4 + aa.wcusatb5 
  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10 
  + aa.wcusatb11 + aa.wcusatd12 )
    ELSE 0 END ) as usatd,
  
  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusqte1 + aa.wcusqte2 + aa.wcusqte3 + aa.wcusqte4 + aa.wcusqte5 +
  aa.wcusqte6 + aa.wcusqte7 + aa.wcusqte8 + aa.wcusqte9 + aa.wcusqte10 +
  aa.wcusqte11 + aa.wcusqte12) / bb.convqty
    ELSE 0 END ), 13, 2) ) as usqte,
  SUM( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusatb1 + aa.wcusatb2 + aa.wcusatb3 + aa.wcusatb4 + aa.wcusatb5 
  + aa.wcusatb6 + aa.wcusatb7 + aa.wcusatb8 + aa.wcusatb9 + aa.wcusatb10 
  + aa.wcusatb11 + aa.wcusate12 )
    ELSE 0 END ) as usate,
  
  SUM( decimal(( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusqtf1 + aa.wcusqtf2 + aa.wcusqtf3 + aa.wcusqtf4 + aa.wcusqtf5 +
  aa.wcusqtf6 + aa.wcusqtf7 + aa.wcusqtf8 + aa.wcusqtf9 + aa.wcusqtf10 +
  aa.wcusqtf11 + aa.wcusqtf12) / bb.convqty
    ELSE 0 END ) , 13, 2) ) as usqtf,
  SUM( CASE aa.wcyearc||aa.wcyeary
		WHEN '1999' THEN (aa.wcusatf1 + aa.wcusatf2 + aa.wcusatf3 + aa.wcusatf4 + aa.wcusatf5 
  + aa.wcusatf6 + aa.wcusatf7 + aa.wcusatf8 + aa.wcusatf9 + aa.wcusatf10 
  + aa.wcusatf11 + aa.wcusatf12 )
    ELSE 0 END ) as usatf,
    
  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
		WHEN '2000' THEN aa.wcbqt1
		ELSE 0 END ) / bb.convqty,13,2) ) as ohqt, 
  
  SUM( DECIMAL(( CASE aa.wcyearc||aa.wcyeary
		WHEN '2000' THEN aa.wcbat1
		ELSE 0 END ), 13, 0) ) as ohat 
from pbtest.wipdaw aa, pbinv.inv101 bb, pbcommon.dac007 cc
where aa.wcdiv = 'A' and bb.comltd = '01' and bb.xplant = 'D' and bb.div = 'A'
and aa.wcitno = bb.itno and bb.comltd = cc.comltd and bb.pdcd = cc.prprcd
and aa.wcyearc||wcyeary >= '1999' and aa.wcyearc||wcyeary <= '2000'
and aa.wciocd = '1'

group by bb.pdcd,cc.prname,aa.wcorct,aa.wcitno,aa.wcdsp,aa.wcspc,
  aa.wcclas, aa.wcsrc, aa.wcum
order by bb.pdcd, aa.wcitno;
