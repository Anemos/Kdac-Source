$PBExportHeader$n_trans_pur.sru
$PBExportComments$������� Transaction
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

//���¾�ü �򰡰��� ���ν���
subroutine SP_VNDEVL1(string I_FROM,string I_TO) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL1"
subroutine SP_VNDEVL2(string I_YEAR) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL2"
subroutine SP_VNDEVL3(string I_YEAR) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL3"
subroutine SP_VNDEVL4(string I_YEAR) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL4"
subroutine SP_VNDEVL5(string I_YEAR) RPCFUNC ALIAS FOR "PBPUR.SP_VNDEVL5"

//���ڼ��ݰ�꼭
subroutine SP_TAX(string I_FROM, string I_TO) RPCFUNC ALIAS FOR "PBPUR.SP_TAX"

//���¾�ü ���հ���
/*  
	SP_AMTBASE('YYMM')	//���ž� ���� ���� ����Ÿ ����	       (I_YYMM)
	SP_AMTBALL('YEAR')   //                        �ϰ�����      (I_XYEAR)
	
	SP_AMT281('YEAR')    //��ü �⺻������ ����� ����           (I_XYEAR)
	
	SP_AMT285('YYMM')		//���ž�����(����) ���� ����Ÿ ����	    (I_YYMM)
	SP_AMT285A('YEAR')   //                             �ϰ����� (I_XYEAR)
	SP_AMT285Y('YEAR')   //                 ������ ����Ÿ ����   (I_XYEAR)
	
	SP_AMT286('YEAE')		//������ ���ž�����							 (I_XYEAR)
	
	SP_AMT287('YYMM')		//���ž�����(��ü) ���� ����Ÿ ����	    (I_YYMM)
	SP_AMT287A('YEAR')   //                             �ϰ����� (I_XYEAR)
	SP_AMT287Y('YEAR')   //                 ������ ����Ÿ ����   (I_XYEAR)
	
	SP_AMT288('YYMM')		//ǰ�� ���ž�  ���� ����Ÿ ����	    (I_YYMM)
	SP_AMT288A('YEAR')   //                             �ϰ����� (I_XYEAR)
	SP_AMT288Y('YEAR')   //                 ������ ����Ÿ ����   (I_XYEAR)
	
	SP_AMT291('YYMM')		//��������(�����ڵ�)  ���� ����Ÿ ����	 (I_YYMM)
	SP_AMT291A('YEAR')   //                            �ϰ�����  (I_XYEAR)
	SP_AMT291Y('YEAR')   //                  ������ ����Ÿ ����  (I_XYEAR)
	
	SP_AMT292('YYMM')		//��������(��/��)  ���� ����Ÿ ����	 	 (I_YYMM)
	SP_AMT292A('YEAR')   //                         �ϰ�����  	 (I_XYEAR)
	SP_AMT292Y('YEAR')   //               ������ ����Ÿ ����  	 (I_XYEAR)
	
	SP_AMT293('YYMM')		//��������(���庰)  ���� ����Ÿ ���� 	 (I_YYMM)
	SP_AMT293A('YEAR')   //                         �ϰ�����  	 (I_XYEAR)
	
	SP_AMT295('YYMM')		//PRR ������Ȳ  ���� ����Ÿ ���� 		 (I_YYMM)
	SP_AMT295A('YEAR')   //                      �ϰ�����  		 (I_XYEAR)
	
	SP_AMT296('YYMM')		//PRR ������º� ��Ȳ  ���� ����Ÿ ���� (I_YYMM)
	SP_AMT296A('YEAR')   //                      �ϰ�����  		 (I_XYEAR)	
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
	SP_AMT298V('I_XYEAR')  : TEST - �ҷ��� WORST, BEST ��ü 5
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
	messagebox("Ȯ��","����Ÿ���̽� ���� ���� [�����ý�����]���� �����ٶ��ϴ�.")
	Return
End If
end event

event destructor;
DisConnect Using This ;
end event

