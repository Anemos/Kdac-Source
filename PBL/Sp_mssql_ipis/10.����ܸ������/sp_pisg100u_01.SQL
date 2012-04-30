/*##############################################################################*/
/*## File Name		: sp_pisg100u_01.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg100u_01							##*/
/*## Description		: 현장관리의 분할 LOTNO 등록					##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg100u_01							##*/
/*## Parameter		: @ps_prddate, @ps_areacode, @ps_divisioncode,			##*/
/*## 			  @ps_prdorder, @ps_prdkborder, @ps_kbno			##*/
/*## Use Table		: TRPDKB, TKB							##*/
/*## Initial		: 2002. 09. 30							##*/
/*## Change		: 2002. 12. 05							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg100u_01'))
	Drop Procedure sp_pisg100u_01
Go

/*
EXEC	sp_pisg100u_01
	@ps_prddate		= '2002.09.11',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'B',
	@ps_itemcode		= '16252989A',
	@ps_kbno		= 'SJRA0001002',
	@ps_divide_qty		= 60
*/

Create Procedure sp_pisg100u_01
	@ps_prddate		char(10),	/* 기준일	*/
	@ps_areacode		char(1),		/* 지역코드	*/
	@ps_divisioncode	char(1),		/* 공장코드	*/
	@ps_itemcode		char(12),	/* 품번		*/
	@ps_kbno		char(11),	/* 간판번호	*/
	@ps_divide_qty		int		/* 분할수량	*/
As
Begin

/*########################################################################################

분할되어질 실적 완료된 정보를 보여준다.

########################################################################################*/

SELECT	KBEndTime			AS as_KBEndTime,
	TKB.RackQty - @ps_divide_qty	AS as_RackQty,
	TKB.LotNo			AS as_LotNo,
	TKB.RackQty			AS as_DivideQty,
	TPRDKB.ItemCode		AS as_ItemCode
  FROM	TKB, TPRDKB
 WHERE	TPRDKB.KBNo			= TKB.KBNo
   AND	TPRDKB.AreaCode		= TKB.AreaCode
   AND	TPRDKB.DivisionCode		= TKB.DivisionCode
   AND	TPRDKB.WorkCenter		= TKB.WorkCenter
   AND	TPRDKB.LineCode		= TKB.LineCode
   AND	TPRDKB.PrdDate			= @ps_prddate
   AND	TPRDKB.AreaCode		= @ps_areacode
   AND	TPRDKB.DivisionCode		= @ps_divisioncode
   AND	TPRDKB.ItemCode		= @ps_itemcode
   AND	TPRDKB.KBNo			= @ps_kbno

End			-- Procedure End
Go
