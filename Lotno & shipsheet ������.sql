select * from 
(select a.itemcode,b.shipdate,sum(b.shipqty) as qty1 from tsrorder a, tshipsheet b
where  a.srno like b.srno + '%'  and a.divisioncode = 'Y' and a.divisioncode = b.divisioncode
and b.shipdate like '2003.10%'
group by a.itemcode,b.shipdate
) a,
(select itemcode,tracedate,sum(shipqty) as qty1 from tlotno
where tracedate like '2003.10%' and divisioncode = 'Y'
group by itemcode,tracedate
) b
where a.itemcode = b.itemcode and a.shipdate = b.tracedate and a.qty1 <> b.qty1
order by 1,2


select * from 
(select a.itemcode,sum(b.shipqty) as qty1 from tsrorder a, tshipsheet b
where  a.srno like b.srno + '%'  and a.divisioncode = 'Y' and a.divisioncode = b.divisioncode
and b.shipdate like '2003.10%'
group by a.itemcode
) a,
(select itemcode,sum(shipqty) as qty1 from tlotno
where tracedate like '2003.10%' and divisioncode = 'Y'
group by itemcode
) b
where a.itemcode = b.itemcode and a.qty1 <> b.qty1
order by 1

-- what's up