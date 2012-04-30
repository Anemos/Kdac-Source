
/*
exec sp_piss060_05
	@ps_senddate	= '19980713',
        @ps_custcode    = 'L10500'
*/
Create Procedure sp_piss060_05
	@ps_senddate	 Char(10),
        @ps_custcode     Char(06)
As
Begin
Create Table #Tmp_Result
(
	ShipNo		Int,
        CustCode	Char(6),
	ShipCount	Char(2),
	SendTime	Char(5)
)
Declare	@li_rowcount	Int,
	@i		Int,
	@ls_custcode	char(6),
        @ls_shipgubun   Char(1),
	@ls_shipcount	Char(2),
	@ls_sendtime	Char(5)

	Select	CustCode	= CustCode,
		ShipeditNo	= ShipEditNo,
		ShipStartTime	= ShipStartTime
	  Into	#Tmp_Ship
	  From	tmsteditno
	 Where	ApplyFrom	= (	Select	Max(ApplyFrom)
					  From	tmsteditno
					 Where	ApplyFrom	<= @ps_senddate	)
           and  Custcode        = @ps_custcode
	Order By 3, 2
	Select @li_rowcount = @@RowCount, @i = 0
	Set RowCount 1
	While @i < @li_rowcount
	Begin
		Select	@i		= @i + 1,
			@ls_custcode	= CustCode,
			@ls_shipcount	= ShipCount,
			@ls_sendtime	= convert(char(5), SendTime , 108)
		  From	#Tmp_Ship
		Insert #Tmp_Result Values(@i, @ls_custcode, @ls_shipcount, @ls_sendtime)
		Delete #Tmp_Ship
	End
	Set RowCount 0
	Drop Table #Tmp_Ship

	Select 	A.ShipNo,
	        A.CustCode,
		A.ShipCount,
		A.SendTime
	 From	#Tmp_Result A
	Drop Table #Tmp_Result
End


GO
