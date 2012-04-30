/*
	File Name	: sp_pisi_d_tsrheader_movelog.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tsrheader_movelog
	Description	: Download SR Header
			  tsrheader - pdsle301
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim

HISTORY적용 완료

*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrheader_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrheader_movelog]
GO

/*
Execute sp_pisi_d_tsrheader_movelog
*/

Create Procedure sp_pisi_d_tsrheader_movelog

	
As
Begin

SET XACT_ABORT OFF

begin tran

Insert	into pdsle301_log
	(CHGDATE,	CHGCD,		SRNO,		DPDT,		SRDT,
	INVOICE,	INDT,		MLC,		MLCDT,		LLC,
	LLCDT,		ELNO1,		ELNO1DT,	ELNO2,		ELNO2DT,
	PAYCD,		DSTN,		STSCD,		DOWNDATE,	SELLER,
	CONSIG,		BUYER,		TRANS,		TRDL,		RMRK,
	CMNT,		EXTD,		INPTDT,		UPDTDT)
Select	CHGDATE,	CHGCD,		SRNO,		DPDT,		SRDT,
	INVOICE,	INDT,		MLC,		MLCDT,		LLC,
	LLCDT,		ELNO1,		ELNO1DT,	ELNO2,		ELNO2DT,
	PAYCD,		DSTN,		'N',		'',		SELLER,
	CONSIG,		BUYER,		TRANS,		TRDL,		RMRK,
	CMNT,		EXTD,		INPTDT,		UPDTDT
from	pdsle301
where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdsle301_log)
order by chgdate

if @@error <> 0
   Begin
   	RollBack Tran
   	Return
   End

Delete	From Sle302_log
Where	Comltd+Srno	In	(Select	Comltd+Srno	From	pdsle301)

if @@error <> 0
   Begin
   	RollBack Tran
   	Return
   End
   
Insert	into sle302_log
	(COMLTD,	CSRNO,		SRNO,		XPLANT,		DIV,
	 STYPE,		CITNO,		SUSE,		FRDT,		ORDNO,
	 PDCD,		ITNO,		CUSTCD,		SCUSTCD,	SRQTY,
	 SAQTY,		EXQTY,		CUR,		MUPRC,		LUPRC,
	 MUAMT,		LUAMT,		CPCNT,		MKCD,		STCD,
	 TAXCD,		XPLAN,		KITCD,		CDQT,		DKTM,
	 PSRNO,		ASRQT1,		ASRQT2,		ASRQT3,		ASRQT4,
	 CSNGB,		IVGB,		COSTDIV,	ASCSN,		EPNO,
	 EPDT,		EXTD)
Select	COMLTD,		CSRNO,		SRNO,		XPLANT,		DIV,
	STYPE,		CITNO,		SUSE,		FRDT,		ORDNO,
	PDCD,		ITNO,		CUSTCD,		SCUSTCD,	SRQTY,
	SAQTY,		EXQTY,		CUR,		MUPRC,		LUPRC,
	MUAMT,		LUAMT,		CPCNT,		MKCD,		STCD,
	TAXCD,		XPLAN,		KITCD,		CDQT,		DKTM,
	PSRNO,		ASRQT1,		ASRQT2,		ASRQT3,		ASRQT4,
	CSNGB,		IVGB,		COSTDIV,	ASCSN,		EPNO,
	EPDT,		EXTD
from	sle302_temp
Where	csrno	not in	(select csrno	from sle302_log)

if @@error <> 0
   Begin
   	RollBack Tran
   	Return
   End
   
Delete	From Sle308_log
Where	comltd+Srno	In	(Select	comltd+Srno	From	pdsle301)

if @@error <> 0
   Begin
   	RollBack Tran
   	Return
   End
   
Insert	into sle308_log
	(COMLTD,	CSRNO,		SRNO,		XPLANT,		DIV,
	 STYPE,		CITNO,		SUSE,		FRDT,		ORDNO,
	 PDCD,		ITNO,		CUSTCD,		SCUSTCD,	SRQTY,
	 SAQTY,		EXQTY,		CUR,		MUPRC,		LUPRC,
	 MUAMT,		LUAMT,		CPCNT,		MKCD,		STCD,
	 TAXCD,		XPLAN,		KITCD,		CDQT,		DKTM,
	 PSRNO,		ASRQT1,		ASRQT2,		ASRQT3,		ASRQT4,
	 CSNGB,		IVGB,		COSTDIV,	ASCSN,		 EPNO,
	 EPDT,		EXTD)
Select	 COMLTD,	CSRNO,		SRNO,		XPLANT,		DIV,
	 STYPE,		CITNO,		SUSE,		FRDT,		ORDNO,
	 PDCD,		ITNO,		CUSTCD,		SCUSTCD,	SRQTY,
	 SAQTY,		EXQTY,		CUR,		MUPRC,		LUPRC,
	 MUAMT,		LUAMT,		CPCNT,		MKCD,		STCD,
	 TAXCD,		XPLAN,		KITCD,		CDQT,		DKTM,
	 PSRNO,		ASRQT1,		ASRQT2,		ASRQT3,		ASRQT4,
	 CSNGB,		IVGB,		COSTDIV,	ASCSN,		 EPNO,
	 EPDT,		EXTD
from	sle308_temp
Where	csrno	not in	(select csrno	from sle308_log)

if @@error <> 0
   Begin
   	RollBack Tran
   	Return
   End
   
update pdsle301
Set	stscd	=	'Y'
From	Pdsle301	a,
	pdsle301_log	b
Where	a.chgdate	=	b.chgdate

if @@error <> 0
   Begin
   	RollBack Tran
   	Return
   End

commit tran

End		-- Procedure End
Go
