/*
	File Name	: sp_pist010i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pist010i_01
	Description	: LOT관리대장
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pist020i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pist020i_01]
GO

/*
Exec sp_pist020I_01 
*/

CREATE PROCEDURE sp_pist020I_01
AS

BEGIN
  SELECT divisioncode = '',
         stockdate    = '',
         lotno        = '',
         shipqty      = 0,
         shipdate1    = '',
	 shipqty1     = 0,
         shipdate2    = '',
	 shipqty2     = 0,
         shipdate3    = '',
	 shipqty3     = 0,
         shipdate4    = '',
	 shipqty4     = 0,
         shipdate5    = '',
	 shipqty5     = 0,
         shipdate6    = '',
	 shipqty6     = 0,
         shipdate7    = '',
	 shipqty7     = 0,
         shipdate8    = '',
	 shipqty8     = 0,
         shipdate9    = '',
	 shipqty9     = 0
    FROM sysusers
END 


GO
