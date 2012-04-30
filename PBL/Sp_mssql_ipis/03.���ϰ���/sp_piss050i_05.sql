/*
	File Name	: sp_piss050i_05.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss050i_05
	Description	: SR별 출하요청현황(편수)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss050i_05]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss050i_05]
GO

/*
exec sp_piss050i_05 @ps_areacode    = 'D',
                    @ps_divisioncode = 'S',
                    @ps_senddate    = '2002.09.17',
                    @ps_custcode    = 'D00001'
*/
Create Procedure sp_piss050i_05
        @ps_areacode     char(01),
        @ps_divisioncode char(01),
	@ps_senddate	 Char(10),
        @ps_custcode     Char(06)
As
Begin
Create Table #Tmp_Result
(
	ShipNo		Int,
        CustCode	Char(6),
	ShipEditNo	Char(2),
	SendTime	Char(5)
)
Declare	@li_rowcount	Int,
	@i		Int,
	@ls_custcode	char(6),
        @ls_shipgubun   Char(1),
	@ls_shipeditno	Char(2),
	@ls_sendtime	Char(5)

	Select	CustCode	= CustCode,
		ShipeditNo	= ShipEditNo,
		ShipStartTime	= ShipStartTime
	  Into	#Tmp_Ship
	  From	tmsteditno
	 Where	ApplyFrom	= (	Select	Max(ApplyFrom)
					  From	tmsteditno
					 Where	ApplyFrom	<= @ps_senddate	
                                           and  CustCode         = @ps_custcode
                                           and areacode = @ps_areacode
                                           and divisioncode = @ps_divisioncode)
           and  Custcode        = @ps_custcode
           and areacode = @ps_areacode
           and divisioncode = @ps_divisioncode
	Order By 3, 2
	Select @li_rowcount = @@RowCount, @i = 0

	Set RowCount 1
	While @i < @li_rowcount
	Begin
		Select	@i		= @i + 1,
			@ls_custcode	= CustCode,
			@ls_shipEditNo	= ShipEditNo,
			@ls_sendtime	= convert(char(5), ShipStartTime , 108)
		  From	#Tmp_Ship
		Insert #Tmp_Result Values(@i, @ls_custcode, @ls_shipeditno, @ls_sendtime)
		Delete #Tmp_Ship
	End

	Set RowCount 0
	Drop Table #Tmp_Ship

	Select 	ShipNo    = A.ShipNo,
	        CustCode  = A.CustCode,
		ShipCount = A.ShipEditNO,
		SendTime  = A.SendTime
	 From	#Tmp_Result A
	Drop Table #Tmp_Result
End

GO
