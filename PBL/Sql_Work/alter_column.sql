alter table tqmanagemaster
alter column payqty decimal(9,2)
alter table tqmanagemaster
alter column repayqty decimal(9,2)
alter table tqmanagemaster
alter column differentqty decimal(9,2)
alter table tqmanagemaster
alter column confirmqty decimal(9,2)
alter table tqmanagemaster
alter column reclaimqty decimal(9,2)

select sum(payqty),sum(repayqty),sum(differentqty),sum(confirmqty),sum(reclaimqty) from tqmanagemaster
where accountdate = '2003.02'