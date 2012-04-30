/*########################################################################################*/
/*## File Name		: sp_piso_generate_log.sql					##*/
/*## Procedure Name	: sp_piso_generate_log						##*/
/*## Description		: Log Space Check / Dump					##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: MESPOP								##*/
/*## Use Program	: None								##*/
/*## Parameter		: None						 		##*/
/*## Initial		: 1998. 05. 20							##*/
/*## Author		: Lee Jong-il							##*/
/*########################################################################################*/

/*
exec sp_piso_generate_log
*/

If Exists (Select * From sysobjects Where id = Object_id('sp_piso_generate_log') And sysstat & 0xf = 4)
	Drop Procedure sp_piso_generate_log
Go

Create Procedure sp_piso_generate_log
As

Begin

Declare	@lf_space_used		Float,
	@lf_space_used_cmms	Float

Create Table #Tmp_Log
(
	DBName		VarChar(30),
	LogSize		Float,
	UsedSize	Float,
	Status		Int
)

Set NoCount On

Insert #Tmp_Log
Execute ('dbcc sqlperf(logspace)')

--여기는 IPIS
Select	@lf_space_used	= UsedSize
  From	#Tmp_Log
 Where	DBName		= 'IPIS'

select @lf_space_used

--Drop Table #Tmp_Log

If @lf_space_used > 50.0
Begin
	CheckPoint
	Dump Tran IPIS With No_Log
	DBCC CheckTable(tmstarea) --(syslogs)
--	DUMP DATABASE JIT TO JIT_BACK VOLUME = 'SS0001' WITH  NOUNLOAD ,  STATS = 10,  INIT ,  NOSKIP
End

-- 여기는 설비
Select	@lf_space_used_cmms	= UsedSize
  From	#Tmp_Log
 Where	DBName		= 'CMMS'

select @lf_space_used_cmms

Drop Table #Tmp_Log

If @lf_space_used_cmms > 50.0
Begin
	CheckPoint
	Dump Tran CMMS With No_Log
	DBCC CheckDB(CMMS) --(syslogs)
--	DUMP DATABASE JIT TO JIT_BACK VOLUME = 'SS0001' WITH  NOUNLOAD ,  STATS = 10,  INIT ,  NOSKIP
End

Set NoCount Off

Return

End