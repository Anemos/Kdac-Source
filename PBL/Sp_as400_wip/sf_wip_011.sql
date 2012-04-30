-- file name : sf_wip_011
-- procedure name : pbwip.sf_wip_011
-- desc : 날짜증감용 함수
-- argument : date string ( 20120201 ), 증감용 integer

drop function pbwip.sf_wip_011;
create function pbwip.sf_wip_011 (
a_yymmdd varchar(8),
a_addnum integer )
returns varchar(8)
language sql
modifies sql data
begin
declare sqlcode integer default 0;
declare p_caldate varchar(8);

set p_caldate = cast(date(concat(substring(a_yymmdd,1,4),
  concat( concat('-',substring(a_yymmdd,5,2)),
  concat('-',substring(a_yymmdd,7,2))))) + a_addnum day as varchar(10));

return concat(concat(substring(a_yymmdd,1,2),substring(p_caldate,1,2)),
  concat(substring(p_caldate,4,2),substring(p_caldate,7,2)));

end
