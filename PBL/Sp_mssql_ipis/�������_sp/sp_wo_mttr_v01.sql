if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_wo_mttr]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_wo_mttr]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

-- MTTR / MTBF 조회
-- exec sp_wo_mttr 17, 'D', 'A', '2003.10.01', '2003.10.20'

CREATE PROCEDURE sp_wo_mttr
@wo_day		int,
@area_code		varchar(1),
@factory_code		varchar(1),
@start_date varchar(10),
@end_date varchar(10)

AS
BEGIN

select a.cc_code, c.cc_name , a.equip_code , a.equip_name, 
	convert(varchar(30),isnull( @wo_day * 1170 / 60 , 0 ) ) 
	+ ' : ' + 
	convert(varchar(30),isnull( @wo_day * 1170 % 60, 0 ) ) 
	as work_time,
	convert(varchar(30), convert( int, isnull( sum(b.wo_firm_time_hour), 0) * 60 
	+ isnull( sum( b.wo_firm_time_minute ), 0) ) / 60 ) 
	+ ' : ' +
     convert(varchar(30), convert( int, isnull( sum(b.wo_firm_time_hour), 0) * 60 
	+ isnull( sum( b.wo_firm_time_minute ), 0) ) % 60 )
	as firm_time,
	convert(varchar(30), convert( int, isnull( sum(b.wo_time_hour), 0) * 60 
	+ isnull( sum( b.wo_time_minute ), 0) ) / 60 ) 
	+' : ' +
	convert(varchar(30), convert( int, isnull( sum(b.wo_time_hour), 0) * 60 
     + isnull( sum( b.wo_time_minute ), 0) ) % 60 )
	as wo_time,
	count(b.wo_code) as wo_count,
	-- MTTR1 : 총부동시간분 / 고장횟수
	convert(varchar(30), convert( int, ( isnull( sum(b.wo_firm_time_hour), 0) * 60 
	+ isnull( sum(b.wo_firm_time_minute), 0)) / count(b.wo_code) ) / 60) 
 	+ ' : ' +
	convert(varchar(30), convert( int, (isnull( sum(b.wo_firm_time_hour), 0) * 60 
	+ isnull( sum(b.wo_firm_time_minute), 0)) / count(b.wo_code) ) % 60 ) 
	as mttr1,
	-- MTTR2 : 총정비시간분 / 고장횟수
	convert(varchar(30), convert( int, (isnull( sum(b.wo_time_hour), 0) * 60 
	+ isnull( sum(b.wo_time_minute), 0)) / count(b.wo_code) ) / 60 )
	+ ' : ' +
	convert(varchar(30),convert( int, (isnull( sum(b.wo_time_hour), 0) * 60 
	+ isnull( sum( b.wo_time_minute), 0)) / count(b.wo_code) ) % 60 ) 
	as mttr2 ,
	convert(varchar(30),convert( int, isnull( (@wo_day * 19.5 * 60 
		- ( isnull( sum(b.wo_firm_time_hour), 0) * 60 
			+ isnull( sum(b.wo_firm_time_minute), 0) ) ) / count(b.wo_code) , 0) ) / 60 ) 
	+ ' : ' +
	convert(varchar(30),convert( int, isnull( (@wo_day * 19.5 * 60 
		- ( isnull( sum(b.wo_firm_time_hour), 0) * 60 
			+ isnull( sum(b.wo_firm_time_minute), 0) ) ) / count(b.wo_code) , 0) ) % 60 ) 
	as mtbf
--	convert(varchar(30),convert(int,isnull( (@wo_day*19.5*k.equip_count*60 - k.firm_time)/k.wo_count , 0))/60) +':'+convert(varchar(30),convert(int,isnull( (@wo_day*19.5*k.equip_count*60 - k.firm_time)/k.wo_count , 0))%60) as mtbf,
		from equip_master a, wo_hist b, cc_master c
		where a.equip_code=b.equip_code and A.AREA_CODE=b.area_code and a.factory_code=b.factory_code and a.cc_code=c.cc_code and a.area_code=@area_code and a.factory_code=@factory_code
			and convert(varchar(10),b.wo_float_date,120) between @start_date and @end_date  and a.equip_div_code='1' and b.wo_code like '%B%'
		group by a.cc_code, c.cc_name, a.equip_code, a.equip_name

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

