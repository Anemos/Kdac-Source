$PBExportHeader$w_bpm302i.srw
$PBExportComments$품목별 단가 현황 발행
forward
global type w_bpm302i from w_origin_sheet09
end type
type dw_1 from datawindow within w_bpm302i
end type
type dw_2 from datawindow within w_bpm302i
end type
end forward

global type w_bpm302i from w_origin_sheet09
event ue_open_after ( )
dw_1 dw_1
dw_2 dw_2
end type
global w_bpm302i w_bpm302i

type variables
datawindowchild idwc_1,idwc_2,idwc_3

// Window 선언...
Window	iw_Sheet

str_easy	i_str_prt
end variables

on w_bpm302i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_bpm302i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

event ue_retrieve;call super::ue_retrieve;String    ls_price, ls_gubun , ls_xyear, ls_revno, ls_gubun2, ls_gubun3, ls_newitno
Long 	    ll_rcnt, ll_row 

setpointer(hourglass!)
	
if dw_1.AcceptText() = -1 then
	messagebox('확인','에러난곳 수정후 조회하세요!',Exclamation!)
	return
end if

dw_1.setItemstatus(1,0,primary!,newmodified!)
if f_mandantory_chk(dw_1) = -1 then
	return 
end if

ls_xyear  = trim(dw_1.GetItemString(1,"xyear"))     	
ls_revno  = trim(dw_1.GetItemString(1,"revno"))     	
ls_gubun2 = trim(dw_1.getitemstring(1,"gubun2"))   //내외자구분
ls_gubun  = trim(dw_1.getitemstring(1,"gubun"))	   //품목구분 0-간접재,2-직접재
ls_gubun3  = trim(dw_1.getitemstring(1,"gubun3"))  //사급단가구분 Y-사급완성품단가
ls_newitno  = trim(dw_1.getitemstring(1,"pur"))    //신규품목구분 N-신규,R-기존

IF dw_2.retrieve(ls_xyear, ls_revno, ls_gubun2, ls_gubun,ls_gubun3, ls_newitno) > 0 Then
	uo_status.st_message.text = f_message("I010")
	wf_icon_onoff(true, false, false, false, true, false, false, true, false)
Else
	uo_status.st_message.text = f_message("I020")
	wf_icon_onoff(true, false, false, false, false, false, false, true, false)
End IF


end event

event open;call super::open;setpointer(hourglass!)

iw_Sheet = w_frame.GetActiveSheet( )

dw_1.setcolumn('xyear')
dw_1.setfocus( )

wf_icon_onoff(true, false, false, false, false, true, false, false, false)
end event

event ue_print;call super::ue_print;this.uo_status.st_message.text = ""

Long    ii, ll_rowcount
String  ls_price, ls_gubun , ls_xyear, ls_gubun2, ls_gubun3
Window l_to_open

setpointer(hourglass!)
	
ll_rowcount = dw_2.RowCount()

IF ll_rowcount < 1 then
	MessageBox("확인","발행할 내역을 조회하십시요!")
	Return
END IF

//인쇄 DataWindow 설정
i_str_prt.title = "품목별 단가 현황 발행"
i_str_prt.transaction 	= sqlca
i_str_prt.datawindow 	= dw_2
i_str_prt.tag 				= This.ClassName()
f_close_report("2",i_str_prt.title) //open된 출력윈도우 닫기
IF openSheetWithParm(l_to_open,i_str_prt,"w_prt",w_frame,0,Layered! ) = 1 THEN
	IF Sqlca.Sqlcode <> 0 THEN
		MessageBox("확인","[단가 현황 발행]정보시스템으로 연락 주십시오." )
	END IF

END IF


	
end event

type uo_status from w_origin_sheet09`uo_status within w_bpm302i
end type

type dw_1 from datawindow within w_bpm302i
event ue_dwnkey pbm_dwnkey
integer x = 37
integer y = 28
integer width = 4279
integer height = 84
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm302i_10"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;IF KeyDown(KeyEnter!) THEN Parent.TriggerEvent("ue_retrieve")
end event

event constructor;this.setTransObject(SQLCA)
this.insertRow(0)

f_pur040_nullchk03(this)


string ls_xyear
select coalesce(max(xyear || revno),'')
into :ls_xyear
from pbbpm.bpm519;

this.object.xyear[1] = mid(ls_xyear,1,4)
this.object.revno[1] = mid(ls_xyear,5,2)
end event

event itemchanged;String ls_colnm

//dw_1.AcceptText()
ls_colnm = dw_1.GetColumnName()

CHOOSE CASE ls_colnm
		
	CASE 'gubun2'  // 내/외자 구분
//		IF data = 'E'  THEN
//			dw_1.object.gubun.protect = 0
//			dw_1.object.gubun.Background.Color = rgb(255,255,255)//흰색. 15780518 
//
//			dw_2.DataObject = "d_bpm302i_11"	
//			dw_2.SetTransObject(sqlca)
//			
//			dw_1.object.gubun3.protect = 1
//			dw_1.object.gubun3.Background.Color = 536870912        //Non-Edit, 회색
//			dw_1.SetItem(1,"gubun3"," ")
//			
//			dw_1.object.pur.protect = 1
//			dw_1.object.pur.Background.Color = 536870912        //Non-Edit, 회색
//			dw_1.SetItem(1,"pur"," ")
			
//		END IF
//		IF data = 'D' THEN 
//			dw_1.object.gubun.protect = 1
//			dw_1.object.gubun.Background.Color = 536870912        //Non-Edit, 회색
//			dw_1.SetItem(1,"gubun"," ") 
//
//			dw_2.DataObject = "d_bpm302i_12"
//			dw_2.SetTransObject(sqlca)
//			
//			dw_1.object.gubun3.protect = 0
//			dw_1.object.gubun3.Background.Color = rgb(255,255,255)//흰색. 15780518 
//			dw_1.SetItem(1,"gubun3","A")
//			
//			dw_1.object.pur.protect = 1
//			dw_1.object.pur.Background.Color = 536870912        //Non-Edit, 회색
//			dw_1.SetItem(1,"pur"," ")
//		END IF
		
	CASE 'gubun3'  // 사급단가 구분
		IF data = 'A'  THEN   //전체단가
			dw_2.DataObject = "d_bpm302i_11"  
			dw_2.SetTransObject(sqlca)
			
//			dw_1.object.pur.protect = 1
//			dw_1.object.pur.Background.Color = 536870912        //Non-Edit, 회색
//			dw_1.SetItem(1,"pur"," ")
		END IF
		
		IF data = 'Y'  THEN  //사급완성품 단가
			dw_2.DataObject = "d_bpm302i_12"
			dw_2.SetTransObject(sqlca)
			
//			dw_1.object.pur.protect = 0
//			dw_1.object.pur.Background.Color = rgb(255,255,255)//흰색. 15780518 
//			dw_1.SetItem(1,"pur","R")
			
		END IF
			
//	CASE 'pur'   //품목구분
//		IF data = 'R'  THEN
//			dw_2.DataObject = "d_bpm302i_13"
//			dw_2.SetTransObject(sqlca)
//		END IF
//		
//		IF data = 'N'  THEN
//			dw_2.DataObject = "d_bpm302i_14"
//			dw_2.SetTransObject(sqlca)
//		END IF
		
END CHOOSE                 
end event

event itemerror;return 1
end event

type dw_2 from datawindow within w_bpm302i
integer x = 14
integer y = 128
integer width = 4599
integer height = 2352
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm302i_11"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.setTransObject(SQLCA)
end event

