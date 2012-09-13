$PBExportHeader$w_wip031u.srw
$PBExportComments$마감확정및 진행현황조회
forward
global type w_wip031u from w_origin_sheet01
end type
type dw_1 from datawindow within w_wip031u
end type
type dw_3 from datawindow within w_wip031u
end type
type dw_2 from datawindow within w_wip031u
end type
end forward

global type w_wip031u from w_origin_sheet01
dw_1 dw_1
dw_3 dw_3
dw_2 dw_2
end type
global w_wip031u w_wip031u

on w_wip031u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_2
end on

on w_wip031u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.dw_2)
end on

event ue_retrieve;//datawindowchild child_plant
//dec{0} lc_yyyymm
//string l_s_plant,l_s_yearmonth,l_s_year,l_s_month
//
//SetPointer(HourGlass!)
//
//lc_yyyymm = uo_1.uf_yyyymm()
//l_s_year = mid(string(lc_yyyymm),1,4)
//l_s_month = mid(string(lc_yyyymm),5,2)
//l_s_yearmonth = l_s_year + l_s_month
//l_s_plant = trim(dw_2.getitemstring(1,'xplant'))

string ls_plant, ls_dvsn, ls_cttp
uo_status.st_message.text = ""
dw_1.reset()
dw_2.reset()

dw_3.accepttext()
ls_plant = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_3.getitemstring(1,"wip001_wadvsn")

if f_wip_mandantory_chk(dw_3) = -1 then return 0

ls_cttp = 'WIP' + ls_dvsn + '%'

if dw_1.retrieve(g_s_company,ls_plant,ls_cttp) > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
	return 0
end if
end event

event open;call super::open;datawindowchild dwc_01, dwc_02, dwc_03

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_3.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_3.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')

dw_3.insertrow(0)

dw_2.getchild("wzplant",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('SLE220')

if g_s_empno = 'ADMIN' then
	// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true, true, true, true, false, false, false)
else
	// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true, false, false, false, false, false, false)
end if
end event

event ue_insert;call super::ue_insert;string ls_plant, ls_dvsn

uo_status.st_message.text = ""
dw_2.reset()

dw_3.accepttext()
//필수입력 체크
if f_wip_mandantory_chk(dw_3) = -1 then return 0

ls_plant = dw_3.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_3.getitemstring(1,"wip001_wadvsn")

dw_2.insertrow(0)
dw_2.setitem(1,"wzplant",ls_plant)
dw_2.setitem(1,"wzcttp",'WIP' + ls_dvsn)

dw_2.setcolumn("wzcttp")
dw_2.setfocus()
end event

event ue_save;call super::ue_save;integer li_rtncode
string ls_plant, ls_cttp

dw_2.accepttext()
uo_status.st_message.text = ""

//필수입력 공백, NULL체크
if f_wip_mandantory_chk(dw_2) = -1 then return 0

//기본정보 입력
f_wip_inptid(dw_2)

//Null필드 0, ' ' 로 셋팅
f_wip_null_chk(dw_2)

ls_plant = dw_2.getitemstring(1,"wzplant")
ls_cttp = dw_2.getitemstring(1,"wzcttp")

//WIP090 UPDATE
li_rtncode = dw_2.update()
if li_rtncode = 1 then
	commit using sqlca;
	uo_status.st_message.text = "저장되었습니다"
else
	rollback using sqlca;
	uo_status.st_message.text = "저장 실패"
end if
end event

event ue_delete;call super::ue_delete;integer li_selrow
string ls_plant, ls_cttp

uo_status.st_message.text = ""
li_selrow = dw_1.getselectedrow(0)

if li_selrow < 1 then 
	uo_status.st_message.text = "삭제할 코드를 선택하십시요"
	return 0
end if

ls_plant = dw_1.getitemstring(li_selrow,"wzplant")
ls_cttp = dw_1.getitemstring(li_selrow,"wzcttp")

  DELETE FROM "PBWIP"."WIP090"  
   WHERE ( "PBWIP"."WIP090"."WZCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP090"."WZPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP090"."WZCTTP" = :ls_cttp )   
         using sqlca;
			
if sqlca.sqlcode  <> 0 then
	rollback using sqlca;
	uo_status.st_message.text = "삭제 실패"
else
	commit using sqlca;
	uo_status.st_message.text = "삭제성공"
end if
end event

type uo_status from w_origin_sheet01`uo_status within w_wip031u
end type

type dw_1 from datawindow within w_wip031u
integer x = 27
integer y = 184
integer width = 4571
integer height = 1328
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip031u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string ls_plant, ls_cttp

ls_plant = This.getitemstring(row,"wzplant")
ls_cttp = This.getitemstring(row,"wzcttp")

dw_2.retrieve(g_s_company, ls_plant, ls_cttp)
end event

event clicked;integer li_rowcnt
li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
end event

type dw_3 from datawindow within w_wip031u
integer x = 37
integer y = 24
integer width = 1371
integer height = 136
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip031u_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_null
datawindowchild cdw_1

This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF
end event

type dw_2 from datawindow within w_wip031u
integer x = 27
integer y = 1532
integer width = 4567
integer height = 936
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip031u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

