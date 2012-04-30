/*
	File Name	: sp_pisi_d_invtrans.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_invtrans
	Description	: Download 공무자재 trans
			  invtrans
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_invtrans]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_invtrans]
GO

/*
Execute sp_pisi_d_invtrans
*/

Create Procedure sp_pisi_d_invtrans
	
	
As
Begin

Insert into invtrans
Select * from pdinv401


--exec cmms..sp_part_trans_down

End		-- Procedure End
Go
