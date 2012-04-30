/*
	File Name	: sp_UnitCreate.SQL
	SYSTEM		: IPIS
	Procedure Name	: sp_UnitCreate
	Description	: 원단위 creattion 간판용
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: Goipis
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Cho Tae-Seob
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_unitCreate]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_unitCreate]
GO

/*
Execute sp_unitcreate
	
*/

Create  Procedure sp_unitCreate

As
Begin

Create	Table	#tmp_unit
	(AreaCode	Char(1)		Not Null,
	 DivisionCode	Char(1)		Not Null,
	 Model		VarChar(15)	Not Null,
	 ParentItem	VarChar(15)	Null,
	 ChildItem	VarChar(15)	Null,
	 Level		Int		Not Null,
	 UnitQty	Numeric(8,3))
	 
Declare	@level	as	Int
Set	@level	=	0

Insert	into	#tmp_unit(AreaCode,	DivisionCode,	Model,		ParentItem,	ChildItem,	Level,	UnitQty)
Select	Distinct	  a.AreaCode,	a.DivisionCode,	b.ItemCode,	null,		a.BomPItemNo,	@Level,	1
From	TmstBom		a,
	Tmstmodel	b
Where	a.AreaCode	=	b.Areacode	and
	a.Divisioncode	=	b.divisioncode	and
	a.bompitemno	=	b.ItemCode	and
	b.Itemclass	in	('10', '30')	and
	isnull(b.ItemBuySource, '  ')	in	('  ', '03')
			

While @@rowCount > 0
	begin
	
	Set	@level	=	@level	+	1
	Insert into #tmp_unit(AreaCode,		DivisionCode,	Model,		ParentItem,	ChildItem,	Level,	UnitQty)
	Select		      a.AreaCode,	a.DivisionCode,	b.Model,	a.BompItemNo,	a.BomcItemNo,	@level,	(a.BomlUnit * b.UnitQty)
	From	(Select	AreaCode,	DivisionCode,	BomPItemNo,BomCItemNo,	BomLUnit	
		From	TmstBom
		Where	(ApplyFrom	<	Convert(char,	GetDate(),	102)	and
			ApplyTo		>	Convert(char,	GetDate(),	102))	and
			Areacode+Divisioncode+BomCitemNo	Not In	(Select	oplant+odvsn+ofitn
									From	tbomoptionitem
									where	oedtm	<	Convert(char,	GetDate(),	102)	and
										oedte	>	Convert(char,	GetDate(),	102)))	a,
		#tmp_unit	b
	Where	a.AreaCode	=	b.AreaCode	and
		a.DivisionCode	=	b.DivisionCode	and
		a.BomPItemNo	=	b.ChildItem	and
		b.level		=	@level	-	1
End				

Truncate	Table	TPartWarningBOM

Insert	Into	TPartWarningBOM(AreaCode,	DivisionCode,		ModelItemNo,	ParentItemNo,
				ChildItemNo,	QuantityPerUnit,	LowLevel,	LastDate)
Select				AreaCode,	DivisionCode,		Model,		ParentItem,
				ChildItem,	UnitQty,		Level,		GetDate()
From	#tmp_unit
Where	Level	<>	0
Order By	AreaCode,	DivisionCode,	Model,	Level,	ParentItem,	ChildItem								

Drop Table #tmp_unit

Return

End		-- Procedure End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
