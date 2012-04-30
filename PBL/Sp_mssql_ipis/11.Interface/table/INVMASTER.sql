-- 자재 master - 공무자재(설비)
-- pdinv101(model master) 받은후 cls 가 '23','43'인 놈을 invmaster에 써준다

CREATE TABLE [INVMASTER] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[CHGDATE] [char] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CHGCD] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[XPLANT] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[DIV] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[PDCD] [char] (4) COLLATE Korean_Wansung_CI_AS  NULL ,
	[ITNO] [char] (12) COLLATE Korean_Wansung_CI_AS  NULL ,
	[CLS] [char] (2) COLLATE Korean_Wansung_CI_AS  NULL ,
	[SRCE] [char] (2) COLLATE Korean_Wansung_CI_AS  NULL ,
	[XUNIT] [char] (2) COLLATE Korean_Wansung_CI_AS  NULL ,
	[CONVQTY] [decimal](13, 0)  NULL ,
	[SAUD] [decimal](9, 0)  NULL ,
	[ABCCD] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[WLOC] [char] (4) COLLATE Korean_Wansung_CI_AS  NULL ,
	[XPLAN] [char] (2) COLLATE Korean_Wansung_CI_AS  NULL ,
	[STSCD] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[DOWNDATE] [char] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	CONSTRAINT [INVMASTER_pk] PRIMARY KEY  NONCLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO
