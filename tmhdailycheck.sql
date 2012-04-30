//select * from tmhdaily
//where workday like '2003.05%' and workcenter = 'j10c' and empgubun = '1'
//order by  workday
//;
//
//select dgday,sum(dgotr + dgjor + dgsangr + dgjuhur + dghumur ) from tmhlabtac
//where dgday like '2003.05%' and dgdepte = 'j10c' and dgclass not in ('64','65','66' ) 
//group by dgday
//order by 1 ;
//
//select sum(dgotr + dgjor + dgsangr + dgjuhur + dghumur ) from tmhlabtac
//where dgday like '2003.05%' and dgdepte = 'j10c' and dgclass not in ('64','65','66' ) 
//;

//select sum(etcmh) from tmhdaily
//where workday like '2003.05%' and workcenter = 'j10c' and empgubun = '1' ;
//
select * from tmhmonth_S
where workcenter = 'j10c' and smonth = '2003.05' ;