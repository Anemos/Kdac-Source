/*##############################################################################*/
/*## File Name		: sp_pisg011_01.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg011_01							##*/
/*## Description		: 현장관리의 분할 LOTNO 등록					##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg011_01							##*/
/*## Parameter		: @ps_message_1, @ps_message_2, @ps_message_3,		##*/
/*## 			  @ps_message_4, @ps_message_5, @ps_message_6		##*/
/*## Use Table		: TRPDKB, TKB							##*/
/*## Initial		: 2002. 10. 10							##*/
/*## Change		: 2002. 12. 05							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg011_01'))
	Drop Procedure sp_pisg011_01
Go

/*
EXEC	sp_pisg011_01
	@ps_message_1	= '단말기 정보파일이 올바르지 않습니다.',
	@ps_message_2	= '단말기의 정보파일을 확인하시고 이상이 없으면',
	@ps_message_3	= '담당자에게 연락하여 주십시요.',
	@ps_message_4	= '2002.09.11',
	@ps_message_5	= 'D',
	@ps_message_6	= 'B'
*/

Create Procedure sp_pisg011_01
	@ps_message_1	varchar(60),	/* 메세지 1	*/
	@ps_message_2	varchar(60),	/* 메세지 2	*/
	@ps_message_3	varchar(60),	/* 메세지 3	*/
	@ps_message_4	varchar(60),	/* 메세지 4	*/
	@ps_message_5	varchar(60),	/* 메세지 5	*/
	@ps_message_6	varchar(60)	/* 메세지 6	*/
As
Begin

/*########################################################################################

분할되어질 실적 완료된 정보를 보여준다.

########################################################################################*/

SELECT	@ps_message_1,
	@ps_message_2,
	@ps_message_3,
	@ps_message_4,
	@ps_message_5,
	@ps_message_6

End			-- Procedure End
Go
