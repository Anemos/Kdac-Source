$PBExportHeader$w_pism200i.srw
$PBExportComments$완제품 단위당 실투입공수 조회
forward
global type w_pism200i from w_pism_sheet02
end type
type tv_divmod from u_pism_tv_divmod within w_pism200i
end type
type dw_divprod from u_pism_dw within w_pism200i
end type
type st_vsplitbar from u_pism_splitbar within w_pism200i
end type
end forward

global type w_pism200i from w_pism_sheet02
tv_divmod tv_divmod
dw_divprod dw_divprod
st_vsplitbar st_vsplitbar
end type
global w_pism200i w_pism200i

type variables
String is_MonthlastDay
end variables

event resize;call super::resize;tv_divmod.Height = newheight - ( tv_divmod.y + uo_status.Height + 10 ) 
dw_divprod.Width = newwidth - ( dw_divprod.x + 10 ) 
dw_divprod.Height = tv_divmod.Height 
st_vsplitbar.Height = tv_divmod.Height  
end event

on w_pism200i.create
int iCurrent
call super::create
this.tv_divmod=create tv_divmod
this.dw_divprod=create dw_divprod
this.st_vsplitbar=create st_vsplitbar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_divmod
this.Control[iCurrent+2]=this.dw_divprod
this.Control[iCurrent+3]=this.st_vsplitbar
end on

on w_pism200i.destroy
call super::destroy
destroy(this.tv_divmod)
destroy(this.dw_divprod)
destroy(this.st_vsplitbar)
end on

event open;call super::open;wf_setRetCondition(STFROMTODATE) 
end event

event ue_postopen;call super::ue_postopen;uo_div.PostEvent("ue_select")
st_vsplitbar.of_register(tv_divmod, LEFT); st_vsplitbar.of_register(dw_divprod, RIGHT)

end event

event ue_retrieve;call super::ue_retrieve;long ll_tvi
TreeviewItem ltvi_Item 
String ls_ProductGroup, ls_modelGroup, ls_divModItem 

ll_tvi = tv_divmod.FindItem(CurrentTreeItem!, 0)
If ll_tvi <= 0 Then Return 
If tv_divmod.GetItem( ll_tvi, ltvi_Item) = -1 Then Return 
dw_divprod.SetRedraw(False)

f_pism_working_msg(istr_mh.year + '년' + istr_mh.month + '월', &
						 dw_divprod.Title + "를 조회중입니다. 잠시만 기다려 주십시오.") 

Choose Case ltvi_Item.Level 
	Case 2 		// 제품군 
		ls_ProductGroup = ltvi_Item.Data; ls_modelGroup = '%' 
		If dw_divprod.DataObject <> 'd_pism200i_01' Then dw_divprod.DataObject = 'd_pism200i_01' 
		
		dw_divprod.SetTransObject(SqlPIS) 
		dw_divprod.Retrieve(istr_mh.area, istr_mh.div, ls_ProductGroup, ls_modelGroup, istr_mh.from_date, istr_mh.to_date) 
	Case 3		// 모델군 
		ls_ProductGroup = Left(ltvi_Item.Data,2); ls_modelGroup = Mid(ltvi_Item.Data,3,3) 
		If dw_divprod.DataObject <> 'd_pism200i_01' Then dw_divprod.DataObject = 'd_pism200i_01' 
		
		dw_divprod.SetTransObject(SqlPIS) 
		dw_divprod.Retrieve(istr_mh.area, istr_mh.div, ls_ProductGroup, ls_modelGroup, istr_mh.from_date, istr_mh.to_date) 
	Case 4 		// 완제품 	
	ls_divModItem = ltvi_Item.Data 
	If dw_divprod.DataObject <> 'd_pism200i_02' Then dw_divprod.DataObject = 'd_pism200i_02' 
	
	dw_divprod.SetTransObject(SqlPIS) 
	dw_divprod.Retrieve(istr_mh.area, istr_mh.div, ls_divModItem, istr_mh.from_date, istr_mh.to_date) 
End Choose 
If IsValid(w_pism_working) Then Close(w_pism_working) 

dw_divprod.SetRedraw(True)
end event

event ue_search;OpenWithParm(w_pism_finditem, dw_divprod) 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_divprod
lstr_prt.DataObject = 'd_pism200i_01_p' 
lstr_prt.title = istr_mh.year + '년' + istr_mh.month + '월 ' + dw_divprod.Title
lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

type uo_status from w_pism_sheet02`uo_status within w_pism200i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism200i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism200i
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism200i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism200i
end type

type uo_month from w_pism_sheet02`uo_month within w_pism200i
end type

event uo_month::ue_select;call super::ue_select;
Select Top 1 Convert(Char(10), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, :uo_month.is_uo_month + '.01'))), 102)
  Into :is_MonthlastDay From sysusers Using SQLPIS;

end event

type uo_year from w_pism_sheet02`uo_year within w_pism200i
end type

type uo_area from w_pism_sheet02`uo_area within w_pism200i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism200i
end type

event uo_div::ue_select;call super::ue_select;
tv_divmod.uf_setDivProd(istr_mh.area, istr_mh.div, is_MonthlastDay)
tv_divmod.Setfocus() 

end event

type gb_1 from w_pism_sheet02`gb_1 within w_pism200i
end type

type tv_divmod from u_pism_tv_divmod within w_pism200i
integer x = 14
integer y = 148
integer width = 1138
integer height = 1704
integer taborder = 30
boolean bringtotop = true
end type

type dw_divprod from u_pism_dw within w_pism200i
integer x = 1170
integer y = 148
integer width = 2053
integer height = 1040
integer taborder = 40
boolean bringtotop = true
string title = "완제품 단위당 실투입공수"
string dataobject = "d_pism200i_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 0
end type

type st_vsplitbar from u_pism_splitbar within w_pism200i
integer x = 1152
integer y = 148
integer width = 18
integer height = 1000
boolean bringtotop = true
end type

