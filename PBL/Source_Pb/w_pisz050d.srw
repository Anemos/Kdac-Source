$PBExportHeader$w_pisz050d.srw
$PBExportComments$전년도기준공수/목표공수 등록(Excel Upload)
forward
global type w_pisz050d from w_pism_sheet01
end type
type uo_styear from u_pisc_date_scroll_year within w_pisz050d
end type
type tab_work from tab within w_pisz050d
end type
type tabpage_1 from userobject within tab_work
end type
type dw_stmh from u_pism_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_work
dw_stmh dw_stmh
end type
type tabpage_2 from userobject within tab_work
end type
type dw_tarmh from u_pism_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_work
dw_tarmh dw_tarmh
end type
type tab_work from tab within w_pisz050d
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_tab1 from datawindow within w_pisz050d
end type
type dw_tab2 from datawindow within w_pisz050d
end type
type gb_2 from groupbox within w_pisz050d
end type
type st_2 from statictext within w_pisz050d
end type
end forward

global type w_pisz050d from w_pism_sheet01
integer width = 4663
uo_styear uo_styear
tab_work tab_work
dw_tab1 dw_tab1
dw_tab2 dw_tab2
gb_2 gb_2
st_2 st_2
end type
global w_pisz050d w_pisz050d

type variables
string is_error
end variables

forward prototypes
public function integer wf_savechk (datawindow adw)
end prototypes

public function integer wf_savechk (datawindow adw);
//If adw.ModifiedCount() > 0 Then Goto saveChk_proc
//
//Return 0
//
//saveChk_proc:
//
//If f_pism_MessageBox(Question!, 999, adw.Title, "수정된 자료가 있습니다. 저장하시겠습니까?") = 1 Then 
//	Return This.Event ue_save(0,1) 
//End If 
//
Return 0
end function

on w_pisz050d.create
int iCurrent
call super::create
this.uo_styear=create uo_styear
this.tab_work=create tab_work
this.dw_tab1=create dw_tab1
this.dw_tab2=create dw_tab2
this.gb_2=create gb_2
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_styear
this.Control[iCurrent+2]=this.tab_work
this.Control[iCurrent+3]=this.dw_tab1
this.Control[iCurrent+4]=this.dw_tab2
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.st_2
end on

on w_pisz050d.destroy
call super::destroy
destroy(this.uo_styear)
destroy(this.tab_work)
destroy(this.dw_tab1)
destroy(this.dw_tab2)
destroy(this.gb_2)
destroy(this.st_2)
end on

event resize;call super::resize;tab_work.Width = newwidth - ( tab_work.x + 10 ) 
tab_work.Height = newheight - ( tab_work.y + 100 ) 
end event

event ue_postopen;call super::ue_postopen;istr_mh.year = uo_styear.is_uo_year
end event

event open;call super::open;ib_wcallView = True 
//cb_wcfilter.Visible = False 

//cb_divtarlpi.Enabled = m_frame.m_action.m_save.Enabled 
end event

event ue_save;call super::ue_save;long ln_count,i,j,ln_row,ln_return
string ls_year,ls_title
dec{5}	ld_mh

if is_error <> ""	then	
	messagebox("확인","현재 엑셀파일 정보중 입력조건에 맞지 않은 항목이 있습니다.~r~n엑셀파일을 다시 조회 후 저장바랍니다")
	return
end if

If tab_work.SelectedTab = 1 Then 
	ls_title	=	istr_mh.year + " 년도 기준공수"
	dw_Tab1.settransobject(Sqlpis)
	dw_tab1.reset()
	ln_count	=	tab_work.tabpage_1.dw_Stmh.rowcount()
	delete from tmhstandard
	where areacode = :istr_mh.area and divisioncode = :istr_mh.div and
			workcenter like :istr_mh.wc and styear = :istr_mh.year
 	using sqlpis ;			
	for i = 1 to ln_count
		dw_tab1.insertrow(0)
		dw_tab1.setitem(i,"areacode",istr_mh.area)
		dw_tab1.setitem(i,"divisioncode",istr_mh.div)
		dw_tab1.setitem(i,"styear",istr_mh.year)
		dw_tab1.SetItem(i, "lastemp", g_s_empno)
		dw_tab1.SetItem(i, "lastdate", f_pisc_get_date_nowtime())
		dw_tab1.SetItem(i, "modifyflag", "0")
		dw_tab1.SetItem(i, "workcenter", trim(tab_work.tabpage_1.dw_Stmh.object.workcenter[i]))
		dw_tab1.SetItem(i, "itemcode", trim(tab_work.tabpage_1.dw_Stmh.object.itemcode[i]))
		dw_tab1.SetItem(i, "sublinecode", trim(tab_work.tabpage_1.dw_Stmh.object.sublinecode[i])) 
		dw_tab1.SetItem(i, "sublineno", trim(tab_work.tabpage_1.dw_Stmh.object.sublineno[i]))		

		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh")
		end if
		dw_tab1.SetItem(i, "stmh",ld_mh )
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh01")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh01")
		end if
		dw_tab1.SetItem(i, "stmh01",ld_mh )
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh02")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh02")
		end if
		dw_tab1.SetItem(i, "stmh02",ld_mh )
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh03")) then
			ld_mh	= 	0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh03")
		end if
		dw_tab1.SetItem(i, "stmh03",ld_mh )		
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh04")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh04")
		end if
		dw_tab1.SetItem(i, "stmh04",ld_mh )		
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh05")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh05")
		end if
		dw_tab1.SetItem(i, "stmh05",ld_mh )
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh06")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh06")
		end if
		dw_tab1.SetItem(i, "stmh06",ld_mh )
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh07")) then
			ld_mh	= 	0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh07")
		end if
		dw_tab1.SetItem(i, "stmh07",ld_mh )		
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh08")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh08")
		end if
		dw_tab1.SetItem(i, "stmh08",ld_mh )		
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh09")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh09")
		end if
		dw_tab1.SetItem(i, "stmh09",ld_mh )
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh10")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh10")
		end if
		dw_tab1.SetItem(i, "stmh10",ld_mh )
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh11")) then
			ld_mh	= 	0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh11")
		end if
		dw_tab1.SetItem(i, "stmh11",ld_mh )		
		
		if isnull(tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh12")) then
			ld_mh	= 0
		else
			ld_mh	=	tab_work.tabpage_1.dw_stmh.getitemnumber(i,"stmh12")
		end if
		dw_tab1.SetItem(i, "stmh12",ld_mh )				
	next
	ln_return	=	f_pism_dwupdate(dw_tab1, True)
Else
	ls_year = istr_mh.year + '%'
	ls_title	=	istr_mh.year + " 년도 목표공수"
	delete from TMHMONTHTARGET
		where areacode = :istr_mh.area and divisioncode = :istr_mh.div and
				workcenter like :istr_mh.wc and tarmonth like :ls_year
 	using sqlpis ;	
	dw_Tab2.settransobject(Sqlpis)
	dw_tab2.reset()
	ln_count	=	tab_work.tabpage_2.dw_tarmh.rowcount() 
	for i = 1 to ln_count
		for j = 1 to 12
			ln_row	=	dw_tab2.insertrow(0)
			dw_tab2.setitem(ln_row,"areacode",istr_mh.area)
			dw_tab2.setitem(ln_row,"divisioncode",istr_mh.div)
			dw_tab2.setitem(ln_row,"tarmonth",istr_mh.year + "." + string(integer(j),"00"))
			dw_tab2.SetItem(ln_row, "lastemp", g_s_empno)
			dw_tab2.SetItem(ln_row, "lastdate", f_pisc_get_date_nowtime())
			dw_tab2.SetItem(ln_row, "modifyflag", "0")
			dw_tab2.SetItem(ln_row, "workcenter",trim(tab_work.tabpage_2.dw_tarmh.object.workcenter[i]))
			dw_tab2.SetItem(ln_row, "itemcode",trim(tab_work.tabpage_2.dw_tarmh.object.itemcode[i]))
			dw_tab2.SetItem(ln_row, "sublinecode",trim(tab_work.tabpage_2.dw_tarmh.object.sublinecode[i])) 
			dw_tab2.SetItem(ln_row, "sublineno",trim(tab_work.tabpage_2.dw_tarmh.object.sublineno[i]))
			if isnull(tab_work.tabpage_2.dw_tarmh.getitemnumber(i,j+7)) then
				ld_mh	= 0
			else
				ld_mh	=	tab_work.tabpage_2.dw_tarmh.getitemnumber(i,j+7)
			end if
			dw_tab2.SetItem(ln_row, "tarmh", ld_mh)				
		next
	next
	ln_return	=	f_pism_dwupdate(dw_tab2, True) 
End If 
if ln_return	<>	-1 then
	messagebox("확인",ls_title + " 등록 완료")
else
	messagebox("확인",ls_title + " 등록이 실패했습니다.시스템 개발팀으로 연락바랍니다")
end if

end event

event ue_retrieve;call super::ue_retrieve;long ln_row
is_error	=	""
uo_status.st_message.text = ""
if tab_work.selectedtab = 1 then
	if f_pdm_getfromexcel(tab_work.tabpage_1.dw_stmh) = 0 then
		if trim(istr_mh.wc) <> '%' then
			ln_row		=	tab_work.tabpage_1.dw_stmh.find(" trim(workcenter)  <> '" + istr_mh.wc + "'",1,tab_work.tabpage_1.dw_stmh.rowcount())
			if  ln_row	> 0 then
				messagebox("확인","선택하신 조크드와 다른 조코드가 Excel 파일에 있습니다.확인하시고 작업바랍니다")
				tab_work.tabpage_1.dw_stmh.scrolltorow(ln_row)
				tab_work.tabpage_1.dw_stmh.selectrow(ln_row,true)
				is_error	=	"error"
				return 0
			end if
		end if
		uo_status.st_message.text = string(tab_work.tabpage_1.dw_stmh.rowcount()) + ' 개의 정보가 조회 되었습니다'
	else
		messagebox("확인","엑셀파일 조회 실패")
		return 0
	end if
elseif tab_work.selectedtab = 2 then
	if f_pdm_getfromexcel(tab_work.tabpage_2.dw_tarmh) = 0 then
		if trim(istr_mh.wc) <> '%' then
			ln_row		=	tab_work.tabpage_2.dw_tarmh.find(" trim(workcenter)  <> '" + istr_mh.wc + "'",1,tab_work.tabpage_2.dw_tarmh.rowcount())
			if  ln_row	> 0 then
				messagebox("확인","선택하신 조크드와 다른 조코드가 Excel 파일에 있습니다.확인하시고 작업바랍니다")
				tab_work.tabpage_2.dw_tarmh.scrolltorow(ln_row)
				tab_work.tabpage_2.dw_tarmh.selectrow(ln_row,true)
				is_error	=	"error"
				return 0
			end if
		end if
		uo_status.st_message.text = string(tab_work.tabpage_2.dw_tarmh.rowcount()) + ' 개의 정보가 조회 되었습니다'
	else
		messagebox("확인","엑셀파일 조회 실패")
		return 0
	end if
end if
end event

type uo_status from w_pism_sheet01`uo_status within w_pisz050d
integer y = 1880
integer width = 4585
end type

type uo_wc from w_pism_sheet01`uo_wc within w_pisz050d
end type

type uo_area from w_pism_sheet01`uo_area within w_pisz050d
end type

type uo_div from w_pism_sheet01`uo_div within w_pisz050d
end type

type cb_wcfilter from w_pism_sheet01`cb_wcfilter within w_pisz050d
integer x = 2747
integer y = 44
end type

type gb_1 from w_pism_sheet01`gb_1 within w_pisz050d
end type

type uo_styear from u_pisc_date_scroll_year within w_pisz050d
integer x = 2213
integer y = 52
integer taborder = 20
boolean bringtotop = true
end type

on uo_styear.destroy
call u_pisc_date_scroll_year::destroy
end on

event ue_select;call super::ue_select;istr_mh.year = uo_styear.is_uo_year
end event

type tab_work from tab within w_pisz050d
event resize pbm_size
event type long ue_retrieve ( integer ai_selectedtab )
integer x = 5
integer y = 160
integer width = 3410
integer height = 1756
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event resize;tabpage_1.dw_stmh.Width = newwidth - ( tabpage_1.dw_stmh.x + 40 )
tabpage_1.dw_stmh.Height = newheight - ( tabpage_1.dw_stmh.y + 120 ) 

tabpage_2.dw_tarmh.Width = newwidth - ( tabpage_2.dw_tarmh.x + 40 ) 
tabpage_2.dw_tarmh.Height = newheight - ( tabpage_2.dw_tarmh.y + 120 ) 

end event

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 100
integer width = 3374
integer height = 1640
long backcolor = 12632256
string text = "전년도기준공수"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_stmh dw_stmh
end type

on tabpage_1.create
this.dw_stmh=create dw_stmh
this.Control[]={this.dw_stmh}
end on

on tabpage_1.destroy
destroy(this.dw_stmh)
end on

type dw_stmh from u_pism_dw within tabpage_1
integer y = 8
integer width = 3186
integer height = 952
integer taborder = 11
string title = "월별 목표지수"
string dataobject = "d_pism040u_02_download"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 0
end type

event retrieveend;call super::retrieveend;This.SetFocus() 
end event

type tabpage_2 from userobject within tab_work
string tag = "목표공수"
integer x = 18
integer y = 100
integer width = 3374
integer height = 1640
long backcolor = 12632256
string text = "목표공수"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tarmh dw_tarmh
end type

on tabpage_2.create
this.dw_tarmh=create dw_tarmh
this.Control[]={this.dw_tarmh}
end on

on tabpage_2.destroy
destroy(this.dw_tarmh)
end on

type dw_tarmh from u_pism_dw within tabpage_2
event type integer finditem ( string as_itemcode )
integer y = 8
integer width = 2587
integer height = 1440
integer taborder = 11
boolean bringtotop = true
string title = "월별 목표공수"
string dataobject = "d_pism050u_04_download"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 0
end type

event type integer finditem(string as_itemcode);Long ll_findRow 
String ls_Chk 

ll_findRow = This.Find("ItemCode = '" + as_ItemCode + "'", 1, This.RowCount()) 
If ll_findRow > 0 Then This.ScrollToRow(ll_findRow)
If ll_findRow = 0 Then f_pism_MessageBox(Information!, 999, "품번검색실패", as_ItemCode + " 해당 품번을 찾을 수 없습니다.") 

Return ll_findRow 

end event

event ue_key;///
end event

type dw_tab1 from datawindow within w_pisz050d
boolean visible = false
integer x = 288
integer y = 188
integer width = 3593
integer height = 700
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_pism040u_02_insert"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_tab2 from datawindow within w_pisz050d
boolean visible = false
integer x = 270
integer y = 976
integer width = 3680
integer height = 840
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_pism050u_04_insert"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisz050d
integer x = 2181
integer y = 4
integer width = 549
integer height = 132
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_2 from statictext within w_pisz050d
integer x = 878
integer y = 176
integer width = 2560
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 128
long backcolor = 12632256
string text = "전년도기준공수의 기준년은 이전년도,목표공수의 기준년은 당해년도입니다"
boolean focusrectangle = false
end type

