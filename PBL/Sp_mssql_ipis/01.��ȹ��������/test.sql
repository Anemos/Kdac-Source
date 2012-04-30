/*
select * from tmstmodelgroup

select * from tmstmodel

select * from tmstkb


D	A	30	301	301T	511513
D	A	30	301	301T	511514
D	A	30	301	301T	511517


0000001
0000002


select * from vkbdesc
*/

declare	@ps_date	char(10)

select @ps_date = '2002.09.30'

insert tplanday
select	@ps_date,	'D',	'A',	'4201',	'A',
	'511513',
	200,
	200,
	2,
	100,
	0,
	0,
	10,
	1,
	'test',
	getdate()



insert tplanday
select	@ps_date,	'D',	'A',	'4201',	'A',
	'511514',
	200,
	200,
	2,
	100,
	0,
	0,
	10,
	1,
	'test',
	getdate()

insert tplanday
select	@ps_date,	'D',	'A',	'4201',	'A',
	'511517',
	200,
	200,
	2,
	100,
	0,
	0,
	10,
	1,
	'test',
	getdate()

insert tplanday
select	@ps_date,	'D',	'A',	'4201',	'A',
	'0000001',
	200,
	200,
	2,
	100,
	0,
	0,
	10,
	1,
	'test',
	getdate()



insert tplanday
select	@ps_date,	'D',	'A',	'4201',	'A',
	'0000002',
	200,
	200,
	2,
	100,
	0,
	0,
	10,
	1,
	'test',
	getdate()




