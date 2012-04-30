-- �������� trans - ��������(����)
-- pdinv401 ������ invtrans�� ���ش�

CREATE TABLE [INVTRANS] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[CHGDATE] [char] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[CHGCD] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[SLIPTYPE] [char] (2) COLLATE Korean_Wansung_CI_AS  NULL ,
	[SRNO] [char] (8) COLLATE Korean_Wansung_CI_AS  NULL ,
	[SRNO1] [char] (2) COLLATE Korean_Wansung_CI_AS  NULL ,
	[SRNO2] [char] (2) COLLATE Korean_Wansung_CI_AS  NULL ,
	[XPLANT] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[DIV] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[ITNO] [char] (12) COLLATE Korean_Wansung_CI_AS  NULL ,
	[INVSTCD] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[TQTY4] [decimal](11, 1)  NULL ,
	[INVSTCD1] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[SLIPGUBUN] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[STSCD] [char] (1) COLLATE Korean_Wansung_CI_AS  NULL ,
	[DOWNDATE] [char] (30) COLLATE Korean_Wansung_CI_AS  NULL ,
	CONSTRAINT [INVTRANS_pk] PRIMARY KEY  NONCLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO


