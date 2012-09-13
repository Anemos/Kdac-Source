$PBExportHeader$n_trans_pur.sru
$PBExportComments$간접재용 Transaction
forward
global type n_trans_pur from transaction
end type
end forward

global type n_trans_pur from transaction
end type
global n_trans_pur n_trans_pur

type prototypes

//subroutine SP_UNPQTY(string I_XPLANT,string I_DIV,string I_ITNO,string I_CLS,ref decimal O_QTY) RPCFUNC ALIAS FOR "PBINV.SP_UNPQTY"
//subroutine SP_UNINQTY(string I_XPLANT,string I_DIV,string I_ITNO,string I_CLS,ref decimal O_QTY) RPCFUNC ALIAS FOR "PBINV.SP_UNINQTY"
subroutine SP_INVQTY(string I_XPLANT,string I_DIV,string I_ITNO,string I_DI,ref decimal O_QTY) RPCFUNC ALIAS FOR "PBPUR.SP_INVQTY"
subroutine SP_MINQTY(string I_XPLANT,string I_DIV,string I_ITNO,ref decimal O_QTY) RPCFUNC ALIAS FOR "PBPUR.SP_MINQTY"
subroutine SP_VNDNM(string I_XPLANT,string I_DIV,string I_ITNO,string I_DI,ref string O_VNDNM, ref string O_TEL) RPCFUNC ALIAS FOR "PBPUR.SP_VNDNM"

//협력업체 평가관리 프로시저
subroutine SP_VNDEVL1(string I_FROM,string I_TO) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL1"
subroutine SP_VNDEVL2(string I_YEAR) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL2"
subroutine SP_VNDEVL3(string I_YEAR) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL3"
subroutine SP_VNDEVL4(string I_YEAR) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL4"
subroutine SP_VNDEVL5(string I_YEAR) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL5"

//전자세금계산서
subroutine SP_TAX(string I_FROM, string I_TO) RPCFUNC ALIAS FOR "PBPUR.SP_TAX"

//협력업체 통합관리
/*  
	SP_AMTBASE('YYMM')	//구매액 기초 월별 데이타 생성	       (I_YYMM)
	SP_AMTBALL('YEAR')   //                        일괄생성      (I_XYEAR)
	
	SP_AMT281('YEAR')    //업체 기본정보및 경쟁력 생성           (I_XYEAR)
	
	SP_AMT285('YYMM')		//구매액추이(전사) 월별 데이타 생성	    (I_YYMM)
	SP_AMT285A('YEAR')   //                             일괄생성 (I_XYEAR)
	SP_AMT285Y('YEAR')   //                 년집계 데이타 생성   (I_XYEAR)
	
	SP_AMT286('YEAE')		//업종별 구매액추이							 (I_XYEAR)
	
	SP_AMT287('YYMM')		//구매액추이(업체) 월별 데이타 생성	    (I_YYMM)
	SP_AMT287A('YEAR')   //                             일괄생성 (I_XYEAR)
	SP_AMT287Y('YEAR')   //                 년집계 데이타 생성   (I_XYEAR)
	
	SP_AMT288('YYMM')		//품목별 구매액  월별 데이타 생성	    (I_YYMM)
	SP_AMT288A('YEAR')   //                             일괄생성 (I_XYEAR)
	SP_AMT288Y('YEAR')   //                 년집계 데이타 생성   (I_XYEAR)
	
	SP_AMT291('YYMM')		//원가절감(사유코드)  월별 데이타 생성	 (I_YYMM)
	SP_AMT291A('YEAR')   //                            일괄생성  (I_XYEAR)
	SP_AMT291Y('YEAR')   //                  년집계 데이타 생성  (I_XYEAR)
	
	SP_AMT292('YYMM')		//원가절감(년/월)  월별 데이타 생성	 	 (I_YYMM)
	SP_AMT292A('YEAR')   //                         일괄생성  	 (I_XYEAR)
	SP_AMT292Y('YEAR')   //               년집계 데이타 생성  	 (I_XYEAR)
	
	SP_AMT293('YYMM')		//원가절감(공장별)  월별 데이타 생성 	 (I_YYMM)
	SP_AMT293A('YEAR')   //                         일괄생성  	 (I_XYEAR)
	
	SP_AMT295('YYMM')		//PRR 발행현황  월별 데이타 생성 		 (I_YYMM)
	SP_AMT295A('YEAR')   //                      일괄생성  		 (I_XYEAR)
	
	SP_AMT296('YYMM')		//PRR 진행상태별 현황  월별 데이타 생성 (I_YYMM)
	SP_AMT296A('YEAR')   //                      일괄생성  		 (I_XYEAR)	
*/
subroutine SP_AMTBASE(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMTBASE"
subroutine SP_AMTBALL(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMTBALL"

subroutine SP_AMT281(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT281"

subroutine SP_AMT285(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMT285"
subroutine SP_AMT285A(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT285A"
subroutine SP_AMT285Y(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT285Y"

subroutine SP_AMT286(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT286"

subroutine SP_AMT287(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMT287"
subroutine SP_AMT287A(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT287A"
subroutine SP_AMT287Y(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT287Y"

subroutine SP_AMT288(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMT288"
subroutine SP_AMT288A(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT288A"
subroutine SP_AMT288Y(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT288Y"

subroutine SP_AMT291(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMT291"
subroutine SP_AMT291A(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT291A"
subroutine SP_AMT291Y(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT291Y"

subroutine SP_AMT292(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMT292"
subroutine SP_AMT292A(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT292A"
subroutine SP_AMT292Y(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT292Y"

subroutine SP_AMT293(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMT293"
subroutine SP_AMT293A(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT293A"

subroutine SP_AMT295(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMT295"
subroutine SP_AMT295A(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT295A"

subroutine SP_AMT296(string I_YYMM) RPCFUNC ALIAS FOR "PBPUR.SP_AMT296"
subroutine SP_AMT296A(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT296A"


/*
	SP_AMT298V('I_XYEAR')  : TEST - 불량율 WORST, BEST 업체 5
*/

subroutine SP_AMT298T(string I_XYEAR) RPCFUNC ALIAS FOR "PBPUR.SP_AMT298T"
end prototypes

on n_trans_pur.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_trans_pur.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
SetPointer(HourGlass!)

This.DBMS       = "ODBC"
This.AutoCommit = False
This.DBParm = "ConnectString='DSN=CA/400 ODBC for PB;UID=CASINV;PWD=DPAINV',disablebind=0"

Connect Using This ;

If This.SQLCode <> 0 then
	messagebox("확인","데이타베이스 연결 오류 [정보시스템팀]으로 연락바랍니다.")
	Return
End If
end event

event destructor;
DisConnect Using This ;
end event

