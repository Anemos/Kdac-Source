$PBExportHeader$w_piss130u.srw
$PBExportComments$출하간판READING
forward
global type w_piss130u from w_ipis_sheet01
end type
type uo_date from u_pisc_date_applydate within w_piss130u
end type
type uo_area from u_pisc_select_area within w_piss130u
end type
type uo_division from u_pisc_select_division within w_piss130u
end type
type dw_shipkb_read from u_vi_std_datawindow within w_piss130u
end type
type st_2 from statictext within w_piss130u
end type
type st_3 from statictext within w_piss130u
end type
type dw_truckorder from datawindow within w_piss130u
end type
type st_4 from statictext within w_piss130u
end type
type st_5 from statictext within w_piss130u
end type
type st_loadqty from statictext within w_piss130u
end type
type st_readqty from statictext within w_piss130u
end type
type cb_1 from commandbutton within w_piss130u
end type
type cb_2 from commandbutton within w_piss130u
end type
type dw_update_tshiplotno from datawindow within w_piss130u
end type
type dw_update_tsrorder from datawindow within w_piss130u
end type
type dw_update_tinv from datawindow within w_piss130u
end type
type st_itemname from statictext within w_piss130u
end type
type dw_update_tshipstatus from datawindow within w_piss130u
end type
type sle_kbno from singlelineedit within w_piss130u
end type
type dw_update_tshipstatus1 from datawindow within w_piss130u
end type
type cb_3 from commandbutton within w_piss130u
end type
type dw_update_tshipkbhis from datawindow within w_piss130u
end type
type gb_1 from groupbox within w_piss130u
end type
type gb_2 from groupbox within w_piss130u
end type
type gb_3 from groupbox within w_piss130u
end type
type gb_4 from groupbox within w_piss130u
end type
type gb_5 from groupbox within w_piss130u
end type
type gb_7 from groupbox within w_piss130u
end type
type dw_plan_read from u_vi_std_datawindow within w_piss130u
end type
type dw_update_tshipsheet from datawindow within w_piss130u
end type
type em_truckno from singlelineedit within w_piss130u
end type
type dw_2 from datawindow within w_piss130u
end type
type dw_shipqty_check from datawindow within w_piss130u
end type
type dw_save from datawindow within w_piss130u
end type
end forward

global type w_piss130u from w_ipis_sheet01
integer width = 4622
integer height = 2752
string title = "출하간판Reading"
windowstate windowstate = maximized!
event ue_post_open ( )
event ue_kbinput ( )
uo_date uo_date
uo_area uo_area
uo_division uo_division
dw_shipkb_read dw_shipkb_read
st_2 st_2
st_3 st_3
dw_truckorder dw_truckorder
st_4 st_4
st_5 st_5
st_loadqty st_loadqty
st_readqty st_readqty
cb_1 cb_1
cb_2 cb_2
dw_update_tshiplotno dw_update_tshiplotno
dw_update_tsrorder dw_update_tsrorder
dw_update_tinv dw_update_tinv
st_itemname st_itemname
dw_update_tshipstatus dw_update_tshipstatus
sle_kbno sle_kbno
dw_update_tshipstatus1 dw_update_tshipstatus1
cb_3 cb_3
dw_update_tshipkbhis dw_update_tshipkbhis
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
gb_7 gb_7
dw_plan_read dw_plan_read
dw_update_tshipsheet dw_update_tshipsheet
em_truckno em_truckno
dw_2 dw_2
dw_shipqty_check dw_shipqty_check
dw_save dw_save
end type
global w_piss130u w_piss130u

type variables
string is_areacode,is_divisioncode
long il_row = 0
string is_truckorder, is_modelcode, is_modelname,&
       is_kbno, is_shipcount, is_pcserialno, is_custcode, &
       is_shipsheetno, is_month,is_truckno

integer ii_originalqty, ii_truckorder, ii_notreading

string is_date, is_today, is_kbno_check
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname

// last click row find
long   il_shipkb_lastclicked, il_selected_clicked, il_currentrow
boolean ib_shipkb_ldown,  ib_already_selected, ib_change
end variables

forward prototypes
public subroutine wf_reset ()
public subroutine wf_init ()
public subroutine wf_inv (string fs_divisioncode, string fs_itemcode, integer fi_shipqty)
public function boolean wf_kbreading (string fs_kbno)
public subroutine wf_shipkb_read_filter (string fs_itemcode)
public subroutine wf_sumloadqty ()
public subroutine wf_truck_set ()
public subroutine wf_truckorder ()
public function boolean wf_update_tkb (string fs_kbno, string fs_gubun, long fi_shipqty)
public function boolean wf_update_tshipinv (string fs_divisioncode, string fs_srno, long fl_shipqty)
public function boolean wf_update_tsrorder (string fs_srno, long fi_remainqty, string fs_shipendgubun, string fs_shipdate, string fs_divisioncode)
public function boolean wf_update_tinv (string fs_divisioncode, string fs_itemcode, long fl_shipqty, string fs_shipgubun)
public function boolean wf_update_tshipsheet (string fs_srno, integer fi_truckorder, string fs_truckno, string fs_custcode, string fs_applydate, string fs_shipsheetno, string fs_divisioncode, long fl_shipqty)
public function boolean wf_update_tshipkbhis (string fs_areacode, string fs_divisioncode, string fs_shipdate, long fi_truckorder)
public function boolean wf_update_tlotno (string fs_lotno, string fs_itemcode, long fi_shipqty, string fs_divisioncode, string fs_custcode, string fs_shipgubun, string fs_shipusage)
public function boolean wf_update_tlotno_no_kbno (string fs_divisioncode, string fs_srno, long fl_shipqty)
public subroutine wf_shipqty_check ()
public function boolean wf_update_tlotno_stock (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, long fl_stockqty)
public function boolean wf_update_tstock_interface (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_deptcode, string fs_itemcode, string fs_kbno, string fs_kbreleasedate, long fl_kbreleaseseq, long fl_stockqty)
public function boolean wf_update_tloadplan ()
public function boolean wf_save ()
public function boolean wf_update_tkbhis (string fs_kbno, string fs_gubun, long fi_shipqty, string fs_divisioncode)
public function boolean wf_save_danpum_inv101 (long a_row)
public function boolean wf_tstocketc (string fs_itemcode, string fs_deptcode, long fl_stockqty, string fs_divisioncode)
public function boolean wf_save_before (string fs_areacode, string fs_divisioncode, string fs_applydate, string fs_deptcode, string fs_itemcode, long fl_stockqty)
public function boolean wf_save_stock ()
public function boolean wf_create_kbno (string fs_itemcode, string fs_deptcode, long fs_stockqty, string fs_divisioncode)
end prototypes

event ue_post_open();cb_2.enabled = m_frame.m_action.m_save.enabled
dw_2.settransobject(sqlpis)
SetPointer(HourGlass!)
show()
dw_truckorder.Insertrow(0)

//is_today	= f_getcurrentdate()
//wf_status_bar_set()

wf_init()

//dw_shipqty_check.SettransObject(SQLPIS)

//open
iw_this = This
ib_open	= True

Window lw_frame

ib_open	= True

lw_frame	= ParentWindow()
lw_Frame.ArrangeSheets (Layer!)
wf_reset()	
dw_shipqty_check.SettransObject(SQLPIS)
dw_plan_read.SetTransObject(SQLPIS)
dw_update_tshipkbhis.SetTransObject(SQLPIS)
dw_update_tshipsheet.SetTransObject(SQLPIS)
dw_update_tsrorder.SetTransObject(SQLPIS)
dw_update_tshipsheet.SetTransObject(SQLPIS)
dw_update_tshipstatus.SetTransObject(SQLPIS)
dw_update_tshipstatus1.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
dw_shipqty_check.SetTransObject(SQLPIS)


long ll_rowcount
datawindowchild ldwc_truckorder, ldwc_truck

If dw_truckorder.GetChild('truckorder', ldwc_truckorder) = 1 Then
	ldwc_truckorder.SetTransObject(SQLPIS)
	ll_rowcount	= ldwc_truckorder.Retrieve(is_date,is_areacode,is_divisioncode)
	if ll_rowcount > 0 Then
//		messagebox("",ll_rowcount)
		dw_truckorder.SetItem(1, 'truckorder', '')
		ii_truckorder	= ldwc_truckorder.GetItemNumber(1, 'Truckorder')
		f_piss_dddw_width(dw_truckorder, 'truckorder', ldwc_truckorder, 'truckorder_display', 4)
	Else
		ldwc_truckorder.reset()
		ldwc_truckorder.setitem(0,'truckorder', '')
		SetNull(ii_truckorder)
		dw_truckorder.enabled 	= false
		
		messagebox('확 인', '선택하신 출하일자에는 상차계획된 정보가 없습니다.~r~n출하일자를 다시 확인하여 주십시오')
		uo_date.setfocus()

	end if
else
   messagebox("확인","차량순번 오류")
End If

end event

event ue_kbinput;sle_kbno.text = ''
sle_kbno.setfocus()
end event

public subroutine wf_reset ();st_loadqty.text = '0'
st_readqty.text = '0'
dw_update_tshipsheet.reset()
dw_shipqty_check.reset()
dw_shipkb_read.reset()
dw_plan_read.reset()
dw_update_tshipkbhis.reset()
dw_update_tshiplotno.reset()
dw_update_tshipsheet.reset()
dw_update_tshipstatus.reset()
dw_update_tsrorder.reset()
dw_update_tinv.reset()
//dw_update_tuploadsr.reset()
//dw_update_tuploadmove.reset()

wf_truckorder()
wf_truck_set()
dw_truckorder.SetItem(1, 'truckorder', '')
em_truckno.text = ''
sle_kbno.text = ''
st_itemname.text = ''
end subroutine

public subroutine wf_init ();dw_shipkb_read.SetTransObject(SQLPIS)
dw_shipqty_check.SetTransObject(SQLPIS)
dw_truckorder.SetTransObject(SQLPIS)
end subroutine

public subroutine wf_inv (string fs_divisioncode, string fs_itemcode, integer fi_shipqty);long ll_rowcount, ll_find

ll_rowcount = dw_update_tinv.rowcount()

if ll_rowcount > 0 Then 
		ll_find = dw_update_tinv.find(" divisioncode = '" + fs_divisioncode +"' and itemcode = '" + fs_itemcode +"'", 1, ll_rowcount)
	if ll_find > 0 Then
		dw_update_tinv.setitem(ll_find, 'shipqty', dw_update_tinv.getitemnumber(ll_find, 'shipqty') + fi_shipqty)
	else
		dw_update_tinv.insertrow(1)
		dw_update_tinv.setitem(1, 'divisioncode', fs_divisioncode)
		dw_update_tinv.setitem(1, 'itemcode', fs_itemcode)
		dw_update_tinv.setitem(1, 'shipqty', fi_shipqty)
	end if
else
	dw_update_tinv.insertrow(1)
	dw_update_tinv.setitem(1, 'divisioncode', fs_divisioncode)
	dw_update_tinv.setitem(1, 'itemcode', fs_itemcode)
	dw_update_tinv.setitem(1, 'shipqty', fi_shipqty)
end if


end subroutine

public function boolean wf_kbreading (string fs_kbno);// 출하가 가능한 간판
// ActiveGubun = 'A', PrintFlag = 'Y', Status = 'D'
// fs_kbno	= is_plantcode + LineID + productgroup + ProductID + S/N

if dw_plan_read.rowcount() = 0 then
	messagebox("확인","조회 후 간판을 Reading하세요.")
   return false
end if	

If is_truckno = '' or isnull(is_truckno) Then
	MessageBox("확인","차량번호를 입력 후 간판을 Reading하세요.")
	Return False
End If

String	ls_sn, ls_custcode, ls_itemcode, ls_asgubun, ls_rtn, ls_parm, ls_modelname, ls_modelid, ls_lotno,ls_itemname
long	   li_kbcount, li_prdqty, li_rtn, li_rackqty,ll_plan_found
Long		ll_checkfind, ll_find, ll_shipqty, ll_readingqty, ll_loadqty, i,ll_dansuqty
long     ll_plan_loadqty,ll_plan_dansuqty,ll_plan_shipqty
string ls_divisioncode

dw_shipkb_read.SetRedraw(false)
dw_shipkb_read.setFilter('')
dw_shipkb_read.filter()
dw_shipkb_read.SetRedraw(true)

ls_divisioncode = mid(fs_kbno,2,1)

ll_find	= dw_shipkb_read.Find("kbno ='" + fs_kbno + "'", 1, dw_shipkb_read.RowCount())

If ll_find > 0 Then
	MessageBox("출하 간판","이미 Scanning한 간판입니다.")
	Return False
End If

// Status = 'D' And CancelGubun = 'N' ActiveGubun = 'A'  Get Count
Select Count(KBNo)
  Into :li_kbcount
  From tkb
 Where KBNo				= :fs_kbno
   and areacode      = :is_areacode
	and divisioncode  = :ls_divisioncode
   And KBActiveGubun = 'A'
	And KBStatusCode	= 'D' 
	AND INVGUBUNFLAG  = 'N'
	using sqlpis;

If li_kbcount < 1 Then
	MessageBox("출하 간판","잘못된 간판번호입니다. ~r~n~r~n" + &
					" 1. 간판 마스타에 등록되지 않는 간판번호이거나~r~n" + &
					" 2. Sleeping 상태의 간판이거나~r~n"	+ &
					" 3. 입고 되지 않은  간판입니다.~r~n" + &
					" 4. 정품 간판이 아닙니다.~r~n")
	Return False
End If

Select Itemcode, currentqty, ASGubun, LotNo
  Into :ls_ItemCode,
 		 :li_prdqty,
		 :ls_asgubun,
		 :ls_lotno
  From tkb
 Where KBNo				= :fs_kbno
   and divisioncode  = :ls_divisioncode
   and areacode      = :is_areacode
   And KBActiveGubun = 'A'
	And KBStatusCode	= 'D' 
	AND INVGUBUNFLAG  = 'N'
using sqlpis;

li_rackqty = li_prdqty

select modelid,itemname
  into :ls_modelid,:ls_itemname
  from vmstmodel
 where areacode = :is_areacode
   and divisioncode = :ls_divisioncode
   and itemcode = :ls_itemcode
	using sqlpis;

string ls_check
ls_check = "itemcode = '"+ls_itemcode+ "' and divisioncode = '" + ls_divisioncode+ "'"

ll_checkfind = dw_shipqty_check.find(ls_check, 1, dw_shipqty_check.rowcount()) 
ll_plan_found = dw_plan_read.find("itemcode = '"+ls_itemcode+ "' and divisioncode = '" + ls_divisioncode+ "'", 1, dw_plan_read.rowcount()) 
st_itemname.text = ls_itemname

IF ll_checkfind > 0 then
   ll_plan_loadqty = dw_plan_read.object.loadqty[ll_plan_found]
   ll_plan_dansuqty = dw_plan_read.object.dansuqty[ll_plan_found]
   ll_plan_shipqty = dw_plan_read.object.shipqty[ll_plan_found]

	//아직 출하되는 모델의 수량만큼 간판이 다 읽혀지지 않았다면
	if dw_shipqty_check.GetitemString(ll_checkfind, 'check_flag') = 'N' Then
		ll_readingqty	= dw_shipqty_check.GetitemNumber(ll_checkfind, 'readingqty')
		ll_loadqty		= dw_shipqty_check.GetitemNumber(ll_checkfind, 'loadqty')

		ll_shipqty 		= ll_readingqty + li_prdqty
		
		//	reading한 간판 수용수를 더한 것이 상차수량보다 많다면
		if ll_shipqty > ll_loadqty Then
			if ll_shipqty - ll_loadqty <> li_prdqty Then 
				li_rtn = MessageBox("출하 간판","Reading한 간판수용수가 상차계획된 수량보다 많습니다. ~r~n" + &
							"짜투리출하는 출하간판으로 처리되지 않고 입력된 출하수량만 출하됩니다.~r~n" + &
							"짜투리 입력을 하시겠습니까?", Question!, YesNo!, 1)
						
				if li_rtn = 1 then
					ls_parm			= is_areacode + Left(string(ls_itemcode)	+ Space(12),12)	+ &
					                 Left(string(ls_modelid)	+ Space(4), 4)	+ &
					                 Left(string(li_prdqty)	+ Space(5), 5)	+ &
										  Left(string(ll_loadqty - ll_readingqty)	+ Space(5), 5)	+ &
										  Left(string(fs_kbno)			+ Space(11), 11)
					OpenWithParm(w_piss140u, ls_parm)
					ls_rtn		 	= Message.StringParm

					IF Trim(left(ls_rtn, 5)) = 'YES' then
						li_prdqty = integer(mid(ls_rtn, 6, 5))

						wf_inv(ls_divisioncode,ls_itemcode,li_prdqty)
						
						ll_find = dw_shipkb_read.find("itemcode = '"+ls_itemcode+ "' and divisioncode = '" + ls_divisioncode+ "'", 1, dw_shipkb_read.rowcount()) 
						
						If ll_find > 0 then
							ll_find = ll_find + 1
						Else
							ll_find = 1
						End if
						dw_shipkb_read.InsertRow(ll_find)
						dw_shipkb_read.SetItem(ll_find, 'truckorder', ii_truckorder)
						dw_shipkb_read.SetItem(ll_find, 'itemcode',	ls_itemcode)
						dw_shipkb_read.SetItem(ll_find, 'itemname',	ls_itemname)
						dw_shipkb_read.SetItem(ll_find, 'itemid',		ls_modelid)
						dw_shipkb_read.SetItem(ll_find, 'itemqty',		ll_loadqty)
						dw_shipkb_read.SetItem(ll_find, 'kbno',			fs_kbno)
						dw_shipkb_read.SetItem(ll_find, 'readingqty',	0)
						dw_shipkb_read.SetItem(ll_find, 'dansuqty',	li_prdqty)			
						dw_shipkb_read.SetItem(ll_find, 'divisioncode',	ls_divisioncode)			
			         dw_shipkb_read.SetItem(ll_find, 'dansuflag','Y')	
						dw_shipkb_read.object.jan_qty[ll_find] = li_prdqty
						dw_shipqty_check.setitem(ll_checkfind, 'readingqty', ll_readingqty + li_prdqty)
						dw_plan_read.setitem(ll_plan_found,'dansuqty',ll_plan_dansuqty + li_prdqty)
						dw_plan_read.setitem(ll_plan_found,'shipqty',ll_plan_shipqty + li_prdqty)						
						If dw_shipqty_check.GetItemString(ll_checkfind, 'check_flag') = 'Y' then
							FOR i = 1 to dw_shipkb_read.Rowcount()
								If dw_shipkb_read.GetItemString(i, 'itemcode') = ls_itemcode then
									dw_shipkb_read.SetItem(i, 'checkflag', 1)
									dw_plan_read.SetItem(ll_plan_found, 'checkflag', 1)
								End if
							NEXT
						End if
						st_readqty.text	= String(Integer(st_readqty.Text) + li_prdqty, "#,##0")
						dw_shipkb_read.Post Event RowFocusChanged(ll_find)
						dw_plan_read.Post Event RowFocusChanged(ll_plan_found)
						dw_shipkb_read.setfocus()
						dw_shipkb_read.scrolltorow(ll_find)
					else
						return false
					end if				
				else
					return False
				end if
			Else
				MessageBox("출하 간판","Reading한 간판의 모델은 이미 상차계획량 만큼 간판이 Reading 되었습니다...." )
				return false
			end if
		else
			wf_inv(ls_divisioncode,ls_itemcode,li_prdqty)			
			dw_shipkb_read.InsertRow(1)
			dw_shipkb_read.SetItem(1, 'truckorder', ii_truckorder)
			dw_shipkb_read.SetItem(1, 'itemcode',	ls_itemcode)
			dw_shipkb_read.SetItem(1, 'itemname',	ls_itemname)
			dw_shipkb_read.SetItem(1, 'itemid',	ls_modelid)
			dw_shipkb_read.SetItem(1, 'itemqty',	ll_loadqty)
			dw_shipkb_read.SetItem(1, 'kbno',		fs_kbno)
			dw_shipkb_read.SetItem(1, 'readingqty',li_prdqty)
			dw_shipkb_read.SetItem(1, 'dansuqty',0)			
         dw_shipkb_read.object.jan_qty[1] = li_prdqty
			dw_shipkb_read.SetItem(1, 'dansuflag','N')			
			dw_shipkb_read.SetItem(1, 'divisioncode',	ls_divisioncode)			
         dw_plan_read.setitem(ll_plan_found,'shipqty',ll_plan_shipqty + li_prdqty)
         dw_plan_read.setitem(ll_plan_found,'loadqty',ll_plan_loadqty + li_prdqty)
			dw_shipqty_check.setitem(ll_checkfind, 'readingqty', ll_readingqty + li_prdqty)
			If dw_shipqty_check.GetItemString(ll_checkfind, 'check_flag') = 'Y' then
				FOR i = 1 to dw_shipkb_read.Rowcount()
					If dw_shipkb_read.GetItemString(i, 'itemcode') = ls_itemcode then
						dw_shipkb_read.SetItem(i, 'checkflag', 1)
						dw_plan_read.SetItem(ll_plan_found, 'checkflag', 1)
					End if
				NEXT
			End if
			st_readqty.text	= String(Integer(st_readqty.Text) + li_prdqty, "#,##0")			
			dw_shipkb_read.Post Event RowFocusChanged(ll_find)
			dw_plan_read.Post Event RowFocusChanged(ll_find)
			dw_shipkb_read.setfocus()
			dw_shipkb_read.scrolltorow(ll_find)

		end if			
	Else
		MessageBox("출하 간판","Reading한 간판의 모델은 이미 상차계획량 만큼 간판이 Reading 되었습니다...." )
		return false
	end if
	Return True
Else
	MessageBox("출하 간판","잘못된 간판번호입니다. ~r~n~r~n" + &
					is_date + "~r~n" + &
					string(ii_truckorder) + "호차에는 상차되지 않은 간판입니다.~r~n~r~n" + &
					"간판, 차량를 확인 후 다시 Reading 하십시오...")
	Return False
End If

Return True
end function

public subroutine wf_shipkb_read_filter (string fs_itemcode);string ls_filter
dw_shipkb_read.SetRedraw(false)

ls_filter = 'itemcode = ' + "'" + fs_itemcode + "'"
dw_shipkb_read.setFilter(ls_filter)
dw_shipkb_read.filter();
dw_shipkb_read.SetRedraw(true)

end subroutine

public subroutine wf_sumloadqty ();long i, ll_loadqty
FOR i = 1 TO dw_shipqty_check.rowCount()
	ll_loadqty = ll_loadqty + dw_shipqty_check.GetItemNumber(i, 'loadqty')
NEXT

st_loadqty.Text = String(ll_loadqty, "#,##0")

end subroutine

public subroutine wf_truck_set ();is_truckno = trim(em_truckno.text)
end subroutine

public subroutine wf_truckorder ();long ll_rowcount
datawindowchild ldwc_truckorder, ldwc_truck

If dw_truckorder.GetChild('truckorder', ldwc_truckorder) = 1 Then
	ldwc_truckorder.SetTransObject(SQLPIS)
	ll_rowcount	= ldwc_truckorder.Retrieve(is_date, is_areacode,is_divisioncode)
	if ll_rowcount > 0 Then
		dw_truckorder.SetItem(1, 'truckorder', '')
		em_truckno.text = ''
		ii_truckorder	= ldwc_truckorder.GetItemNumber(1, 'Truckorder')
		dw_truckorder.enabled 	= true		
	Else
		em_truckno.text = ''
		
		ldwc_truckorder.reset()
		ldwc_truckorder.setitem(0,'truckorder', '')
		SetNull(ii_truckorder)
		dw_truckorder.enabled 	= false
		
		uo_date.setfocus()
	end if
End If
end subroutine

public function boolean wf_update_tkb (string fs_kbno, string fs_gubun, long fi_shipqty);uo_status.st_message.text = '간판 저장중(wf_update_tkb)'	
integer li_count, li_max

Select count(KBNO) 
  into :li_count
  From tkb
 Where kbno = :fs_kbno
	using sqlpis;
	
IF li_count = 1 then
	
	IF fs_gubun = 'N' Then //짜투리 출하가 아니라면
		Update tkb
			set CurrentQty = CurrentQty - :fi_shipqty,
			    KBStatusCode = 'F',			
				 shipdate   = :is_date,				 
				 shipqty    = SHIPQTY + :fi_shipqty,
				 KBShipTime	= GetDate(),
				 Lastemp		= 'Y',
				 LastDate	= GetDate()
		 Where KBNO			= :fs_kbno
			using sqlpis;
	 
		If sqlpis.sqlcode = 0 Then
			return true
		Else
         uo_status.st_message.text = '간판 저장 error (wf_update_tkb)'	
			return False
		End if
	Else	//짜투리 출하라면 단지 수용수만을 변경한다.
		Update tkb
			set CurrentQty = CurrentQty - :fi_shipqty,
				 shipdate   = :is_date,
				 shipqty    = shipqty + :fi_shipqty,
				 KBShipTime	= GetDate(),
				 Lastemp		= 'Y',
				 lastdate   = getdate()
		 Where KBNO			= :fs_kbno
			using sqlpis;
		 
		If sqlpis.sqlcode = 0 Then
			uo_status.st_message.text = '간판 저장완료(wf_update_tkb)'	
			return true
		Else
			uo_status.st_message.text = '간판 저장 error (wf_update_tkb)'	
			return False
		End if
	End if
Else
   uo_status.st_message.text = '간판 저장 error(wf_update_tkb)'	
	Return False
End if

end function

public function boolean wf_update_tshipinv (string fs_divisioncode, string fs_srno, long fl_shipqty);uo_status.st_message.text = '이체 저장중(wf_update_tshipinv)'	
string ls_areacode,ls_divisioncode,ls_shipgubun,ls_itemcode,ls_custcode,ls_moverequireno,ls_sendflag
string ls_moveareacode,ls_movedivisioncode
integer li_shipeditno
long ll_count,ll_shiporderqty,ll_error_count
long ll_error
string ls_close_date  //마감일자
ll_error_count = 0
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

select areacode,divisioncode,shipgubun,itemcode,custcode,shipeditno,shiporderqty,moverequireno,moveareacode,movedivisioncode
  into :ls_areacode,:ls_divisioncode,:ls_shipgubun,:ls_itemcode,:ls_custcode,:li_shipeditno,:ll_shiporderqty,:ls_moverequireno,:ls_moveareacode,:ls_movedivisioncode
  from tsrorder
 where areacode = :is_areacode
   and divisioncode = :fs_divisioncode
	and srno = :fs_srno
	using sqlpis;

ls_sendflag = 'N'	

SELECT COUNT(*)
  INTO :ll_count
  FROM TSHIPINV 
 WHERE SHIPPLANDATE = :is_date
   and areacode = :ls_areacode
	and divisioncode = :ls_divisioncode
	and srno = :fs_srno
	and truckorder = :is_truckorder
	using sqlpis;
if ll_count = 0 then	
	INSERT INTO TSHIPINV  
			( ShipPlanDate,AreaCode,DivisionCode,MoveRequireNo,SRNo,TruckOrder,FromAreaCode,FromDivisionCode,TruckNo,ShipDate,   
			  ShipGubun,ItemCode,CustCode,ShipEditNo,ApplyFrom,shiporderqty,TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,   
			  MoveConfirmDate,MoveConfirmTime,sendflag,LastEmp,LastDate )  
	VALUES (:is_date,:ls_areacode,:ls_divisioncode,:ls_moverequireno,:fs_srno,:is_truckorder,:ls_moveareacode,:ls_movedivisioncode,:is_truckno,
			  :is_date,:ls_shipgubun,:ls_itemcode,:ls_custcode,:li_shipeditno,:is_date,:ll_shiporderqty,:fl_shipqty,0,'N','Y',
			   null,null,:ls_sendflag,'Y',getdate())  
	using sqlpis;
else
	update tshipinv
	   set truckloadqty = truckloadqty + :fl_shipqty,
		    sendflag     = :ls_sendflag,
			 lastemp      = 'Y',
			 lastdate     = getdate()
	 WHERE SHIPPLANDATE = :is_date
		and areacode = :ls_areacode
		and divisioncode = :ls_divisioncode
		and srno = :fs_srno
		and truckorder = :is_truckorder
		using sqlpis;
end if

if sqlpis.sqlcode <> 0 then
   uo_status.st_message.text = '이체 저장 error(wf_update_tshipinv)'	
	return false
end if
uo_status.st_message.text = '이체 저장완료(wf_update_tshipinv)'	
return true


end function

public function boolean wf_update_tsrorder (string fs_srno, long fi_remainqty, string fs_shipendgubun, string fs_shipdate, string fs_divisioncode);uo_status.st_message.text = 'SR 저장중(wf_update_tsrorder)'	
Update tsrorder
   Set ShipRemainQty	= :fi_remainqty,
		 shipendgubun	= case shipgubun when 'M' then 'Y' else :fs_shipendgubun end,
		 shipdate		= :fs_shipdate,
		 lastemp			= 'Y',
		 lastDate		= GetDate()
 Where SRNo		     = :fs_srno
   and areacode     = :is_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
	 
if SQLPIS.SQLCode <> 0 then
	uo_status.st_message.text = 'SR 저장 error(wf_update_tsrorder)'	
	Return False
end if
uo_status.st_message.text = 'SR 저장완료(wf_update_tsrorder) + :' + sqlpis.sqlerrtext	
return true

end function

public function boolean wf_update_tinv (string fs_divisioncode, string fs_itemcode, long fl_shipqty, string fs_shipgubun);uo_status.st_message.text = '재고 저장중(wf_update_tinv)'	
long ll_count,ll_invqty,ll_moveinvqty,ll_shipinvqty,ll_repairqty
string ls_applydate
//ls_date = f_getcurrentdate()
//ls_date = is_date
//정품으로만 처리
ll_invqty     = fl_shipqty
ll_repairqty = 0
if fs_shipgubun = 'M' then //이체
   ll_moveinvqty = fl_shipqty
	ll_shipinvqty  = 0
else
   ll_moveinvqty = 0
	ll_shipinvqty  = fl_shipqty
end if	
if (fs_shipgubun >= 'O' and fs_shipgubun <= 'W') or (fs_shipgubun = 'M') then //수출은 영업진행재고 처리안함
   	ll_shipinvqty  = 0
end if		
select count(*)
  Into :ll_count
  From tinv
 Where Itemcode	  = :fs_itemcode
	and divisioncode = :fs_divisioncode
	and areacode     = :is_areacode
	using sqlpis;
if ll_count = 0 then
	insert into tinv (areacode,divisioncode,itemcode,invqty,moveinvqty,shipinvqty,lastemp,lastdate)
			values (:is_areacode,:fs_divisioncode,:fs_itemcode,:ll_invqty * -1,:ll_moveinvqty,:ll_shipinvqty,'Y',getdate())
			using sqlpis;
else		
	update tinv
	   set invqty = invqty - :ll_invqty,
		    moveinvqty = moveinvqty + :ll_moveinvqty,
		    shipinvqty = shipinvqty + :ll_shipinvqty,
		    lastemp  = 'Y',
			 lastdate = getdate()
	 where areacode = :is_areacode
	   and divisioncode = :fs_divisioncode
		and itemcode = :fs_itemcode
		using sqlpis;
end if		
uo_status.st_message.text = '재고 저장완료(wf_update_tinv)'	
if Sqlpis.sqlcode = 0 then
	return true
else
	uo_status.st_message.text = '재고 저장실패(wf_update_tinv)'	
	return false
End if

end function

public function boolean wf_update_tshipsheet (string fs_srno, integer fi_truckorder, string fs_truckno, string fs_custcode, string fs_applydate, string fs_shipsheetno, string fs_divisioncode, long fl_shipqty);uo_status.st_message.text = '출하전표 저장중(wf_update_tshipsheet)'	
long ll_seqno,ll_mo_truckloadqty
string ls_kitgubun,ls_pcgubun,ls_min_srno,ls_psrno
select kitgubun,pcgubun,psrno
  into :ls_kitgubun,:ls_pcgubun,:ls_psrno
  from tsrorder
 where srno = :fs_srno
   and areacode = :is_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
	
if ls_kitgubun = 'Y' then
	ls_kitgubun = ls_pcgubun
else
	ls_kitgubun = ''
end if	

Insert tshipsheet(ShipDate,Areacode,  DivisionCode,  SRNo,Truckorder, shipsheetno, Truckno, Custcode,shipqty,
                  Printcount,confirmflag,saleconfirmflag, lastemp, lastDate,deliveryflag)
 Values (:fs_applydate,:is_areacode,:fs_divisioncode,:fs_srno,:fi_truckorder, :fs_shipsheetno,:is_truckno, :fs_custcode,:fl_shipqty,
                  0,'N','N','Y', GetDate(),'N')
using sqlpis;
if SQLPIS.SQLCode <> 0 then
	uo_status.st_message.text = '출하전표 저장 error(wf_update_tshipsheet)'	
	Return False
end if

string ls_srno

if right(fs_srno,3) = 'P00' or right(fs_srno,3) = 'C00' then
	select top 1 substring(:fs_srno,1,len(:fs_srno) - 3) 
	  into :ls_srno
	  from sysusers
	  using sqlpis;
else
	ls_srno = fs_srno
end if	
if mid(fs_shipsheetno,3,1) <> 'M' then //이체는 인터페이스 안함
	select max(seqno)
	  into :ll_seqno
	  from tshipsheet_interface
	 where shipdate     = :fs_applydate
		and areacode     = :is_areacode
		and divisioncode = :fs_divisioncode
		and srno = :ls_srno
		and misflag = 'A'
		using sqlpis;
	
	if isnull(ll_seqno) then
		ll_seqno = 0
	end if
	ll_seqno = ll_seqno + 1
	INSERT INTO Tshipsheet_interface  
			( shipdate,AreaCode,DivisionCode,srno,seqno,
			  shipsheetno,kitgubun,shipQty,
			  misflag,interfaceflag,LastEmp,LastDate )  
	VALUES (:fs_applydate,:is_areacode,:fs_divisioncode,:ls_srno,:ll_seqno,
			  :fs_shipsheetno,:ls_kitgubun,:fl_shipqty,   
			  'A','Y',:g_s_empno,getdate() )  
			  using sqlpis;
	if SQLPIS.SQLCode <> 0 then
		uo_status.st_message.text = '출하전표 저장error(wf_update_tshipsheet)'	
		Return False
	end if
end if	
/*IF ls_kitgubun = 'Y' then
	select min(srno)
	  into :ls_min_srno
	  from tsrorder
	 where psrno = :ls_psrno
	 using sqlpis;
	if ls_min_srno = fs_srno then
      select truckloadqty
		  into :ll_mo_truckloadqty
		  from tloadplan
		 where areacode = :is_areacode
		   and divisioncode = :fs_divisioncode
			and shipplandate = :fs_applydate
			and truckorder   = :fi_truckorder
			and srno         = :ls_psrno
			using sqlpis;
		ll_seqno = ll_seqno + 1
		INSERT INTO Tshipsheet_interface  
				( shipdate,AreaCode,DivisionCode,srno,seqno,
				  shipsheetno,kitgubun,shipQty,
				  misflag,interfaceflag,LastEmp,LastDate )  
		VALUES (:fs_applydate,:is_areacode,:fs_divisioncode,:ls_psrno,:ll_seqno,
				  :fs_shipsheetno,'P',:ll_mo_truckloadqty,   
				  'A','Y',:g_s_empno,getdate() )  
				  using sqlpis;
	   if sqlpis.sqlcode <> 0 then
			uo_status.st_message.text = '출하전표 모 품번 저장오류(wf_update_tshipsheet)'	
         return false
		end if
	end if
end if
*/
uo_status.st_message.text = '출하전표 저장완료(wf_update_tshipsheet)'	
return true
end function

public function boolean wf_update_tshipkbhis (string fs_areacode, string fs_divisioncode, string fs_shipdate, long fi_truckorder);uo_status.st_message.text = '출하간판 저장중(wf_update_tshipkbhis)'	
string  ls_divisioncode,ls_srno,ls_itemcode,ls_kbno,ls_kbreleasedate,ls_data,ls_shipsheetno,ls_find
string  ls_custcode,ls_shipgubun,ls_shipusage,ls_lotno
long    ll_found,ll_found_1,ll_rowcount,ll_tshipkbhis,ll_truckloadqty,ll_janqty,ll_kbqty
integer li_shipqty,li_kbreleaseseq
boolean lb_return
string ls_close_date
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
lb_return = true
ll_rowcount = dw_shipkb_read.rowcount()
DECLARE tloadplan_cur CURSOR FOR
        SELECT a.divisioncode,a.srno,a.itemcode,a.truckloadqty,a.custcode,b.shipgubun,b.shipusage
		    FROM tloadplan a,tsrorder b
		   WHERE a.areacode     = :fs_areacode
		     and a.divisioncode like :fs_divisioncode
		     and a.truckorder   = :fi_truckorder
		     and a.shipplandate = :fs_shipdate
			  and a.srno         = b.srno
			  and (b.kitgubun = 'N' or (b.kitgubun = 'Y' and b.pcgubun = 'C'))
			  using sqlpis;

open tloadplan_cur;
fetch tloadplan_cur into :ls_divisioncode,:ls_srno,:ls_itemcode,:ll_truckloadqty,:ls_custcode,:ls_shipgubun,:ls_shipusage;

DO UNTIL sqlpis.sqlcode <> 0
   
   ll_found = 0

   DO
		if ll_found + 1 > ll_rowcount then  
			if ll_truckloadqty <> 0 then //간판을 다 안 읽고 처리시
			   if not wf_update_tlotno_no_kbno(ls_divisioncode,ls_srno,ll_truckloadqty) then
					lb_return = false
					exit
            end if
         end if   
			exit
		end if
		ls_find = "divisioncode = '" + ls_divisioncode + "'"
		ls_find = ls_find + " and itemcode = '" + ls_itemcode + "'"
		ls_find = ls_find + " and jan_qty > " + '0'
	   ll_found = dw_shipkb_read.Find(ls_find,ll_found + 1,dw_shipkb_read.rowcount())

		if ll_found <= 0 then
			if ll_truckloadqty <> 0 then //간판을 다 안 읽고 처리시
			   if not wf_update_tlotno_no_kbno(ls_divisioncode,ls_srno,ll_truckloadqty) then
					lb_return = false
					exit
	         end if				
		   end if   
			exit
		end if
		ll_janqty  = dw_shipkb_read.getitemnumber(ll_found,'jan_qty')
		if ll_janqty >= ll_truckloadqty then
   		ll_kbqty = ll_truckloadqty
			ll_janqty = ll_janqty - ll_truckloadqty
			ll_truckloadqty = 0
		else
			ll_kbqty = ll_janqty
			ll_janqty = 0
         ll_truckloadqty = ll_truckloadqty - ll_kbqty
	   end if
		dw_shipkb_read.object.jan_qty[ll_found] = ll_janqty
		ls_kbno    = dw_shipkb_read.getitemstring(ll_found,'kbno')
		Select kbreleasedate,kbreleaseseq,lotno
		  Into :ls_kbreleasedate,:li_kbreleaseseq,:ls_lotno
		  From tkbhis
		 Where KBNo				= :ls_kbno
			and areacode      = :is_areacode
			And KBActiveGubun = 'A'
			And KBStatusCode	= 'D' 
		 using sqlpis;

		SELECT COUNT(*)
		  INTO :ll_tshipkbhis
		  from tshipkbhis
		 where areacode      = :fs_areacode
			and divisioncode  = :ls_divisioncode
			and srno          = :ls_srno
			and shipdate      = :fs_shipdate
			and truckorder    = :fi_truckorder
			and kbreleasedate = :ls_kbreleasedate
			and kbreleaseseq  = :li_kbreleaseseq
			AND kbno          = :ls_kbno
		 using sqlpis;
      ll_found_1 = dw_update_tshipsheet.Find("divisioncode = '" + ls_divisioncode + "' and srno = '" + ls_srno + "'",&
		             1, dw_update_tshipsheet.rowcount())
						
		if ll_found_1 > 0 then
			ls_shipsheetno = dw_update_tshipsheet.getitemstring(ll_found_1,'shipsheetno')
		else
			ls_shipsheetno = ' '
		end if
		if ll_tshipkbhis > 0 then
		   update tshipkbhis
			   set shipqty  = shipqty + :ll_kbqty,
				    lastemp  = 'Y',
					 lastdate = getdate()
		    where areacode      = :fs_areacode
			   and divisioncode  = :ls_divisioncode
			   and srno          = :ls_srno
			   and shipdate      = :fs_shipdate
			   and truckorder    = :fi_truckorder
			   and kbreleasedate = :ls_kbreleasedate
			   and kbreleaseseq  = :li_kbreleaseseq
				and kbno          = :ls_kbno
		    using sqlpis;
		else
		  INSERT INTO TSHIPKBHIS  
					( ShipDate,   
					  AreaCode,   
					  DivisionCode,   
					  SRNo,   
					  TruckOrder,   
					  ShipSheetNo,   
					  KBNo,   
					  KBReleaseDate,   
					  KBReleaseSeq,   
					  ShipQty,   
					  LastEmp,   
					  LastDate )  
		  VALUES ( :is_date,   
					  :is_areacode,   
					  :ls_divisioncode,   
					  :ls_srno,   
					  :fi_truckorder,   
					  :ls_shipsheetno,   
					  :ls_kbno,   
					  :ls_kbreleasedate,   
					  :li_kbreleaseseq,   
					  :ll_kbqty,   
					  'Y',   
					  getdate() )
					  using sqlpis;
				end if
			if sqlpis.sqlcode = 0 then
				lb_return = true
			else
				uo_status.st_message.text = 'TSHIPKBHIS ERROR : ' + SQLPIS.SQLERRTEXT
				lb_return = false
				exit
			end if
		   IF Not wf_update_tlotno(ls_lotno, ls_itemcode, ll_kbqty,ls_divisioncode,ls_custcode,ls_shipgubun,ls_shipusage) then
				uo_status.st_message.text = 'TLOTNO ERROR : '
				lb_return = false
			   exit
			end if
			if ll_truckloadqty = 0 then
			   exit
			end if
			
   LOOP WHILE TRUE
   if lb_return = false then
		exit
	end if
   fetch tloadplan_cur into :ls_divisioncode,:ls_srno,:ls_itemcode,:ll_truckloadqty,:ls_custcode,:ls_shipgubun,:ls_shipusage;
	
LOOP

close tloadplan_cur;
uo_status.st_message.text = '출하간판 저장완료(wf_update_tshipkbhis)'	
return lb_return
end function

public function boolean wf_update_tlotno (string fs_lotno, string fs_itemcode, long fi_shipqty, string fs_divisioncode, string fs_custcode, string fs_shipgubun, string fs_shipusage);uo_status.st_message.text = '로트 저장중(wf_update_tlotno)'	
long ll_count, ll_shipqty
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

select count(LotNo),
		 ShipQty
  Into :ll_count,
  		 :ll_shipqty
  From tlotno
 Where traceDate     = :is_date
   and areacode      = :is_areacode
   and DivisionCode	= :fs_divisioncode
   and Lotno		   = :fs_lotno
   and ItemCode	   = :fs_itemcode
	and custcode      = :fs_custcode
	and shipgubun     = :fs_shipgubun
Group by ShipQty
using sqlpis;
if isnull(ll_count) then
	ll_count = 0
end if	
long ll_stockqty
if f_piss_itemtype_check(is_areacode,fs_divisioncode,fs_itemcode) = '2' then //단품이면
   ll_stockqty = fi_shipqty
else
	ll_stockqty = 0
end if	
//출하일자의 같은 Lotno 의 테이타가 있다면 Update
if ll_count > 0 Then
	Update tlotno
	   Set shipqty		= shipqty + :fi_shipqty,
		    stockqty   = stockqty + :ll_stockqty,
		    lastemp    = 'Y',
			 lastdate   = getdate()
	 Where traceDate     = :is_date
		and areacode      = :is_areacode
		and DivisionCode	= :fs_divisioncode
		and Lotno		   = :fs_lotno
		and ItemCode	   = :fs_itemcode
		and custcode      = :fs_custcode
		and shipgubun     = :fs_shipgubun
 	 using sqlpis;
Else
	// 출고일자의 같은 lotno 가 없다면 insert
	Insert into tlotno 
	           (traceDate,AreaCode,DivisionCode,Lotno,
	            Itemcode,custcode,shipgubun,
	            shipusage,prdqty,shipQty,stockqty,Lastemp, lastdate)
     	 Values (:is_date,:is_areacode,:fs_divisioncode,:fs_lotno,
			      :fs_itemcode,:fs_custcode,:fs_shipgubun,
					:fs_shipusage,0,:fi_shipqty,:ll_stockqty,'Y', GetDate())
			using sqlpis;
end if
	
if Sqlpis.sqlcode = 0 then
   uo_status.st_message.text = '로트 저장완료(wf_update_tlotno)'		
	return true
else
   uo_status.st_message.text = '로트 저장error(wf_update_tlotno)'	
	return false
End if
end function

public function boolean wf_update_tlotno_no_kbno (string fs_divisioncode, string fs_srno, long fl_shipqty);uo_status.st_message.text = '로트 저장중(wf_update_tlotno_no_kbno)'	
long ll_count, ll_shipqty,ll_find,ll_stockqty
string ls_custcode,ls_itemcode,ls_shipgubun,ls_shipusage,ls_shipsheetno,ls_string
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
//string ls_shift  //주야
//ls_shift = f_pisc_get_date_shift_close(is_areacode,fs_divisioncode,f_pisc_get_date_nowtime())
//
//string ls_lotno
//ls_lotno = f_pisc_get_lotno(is_areacode,fs_divisioncode,ls_close_date,ls_shift)
//
select custcode,itemcode,shipgubun,shipusage
  into :ls_custcode,:ls_itemcode,:ls_shipgubun,:ls_shipusage
  from tsrorder
  where srno    = :fs_srno 
   and areacode = :is_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if f_piss_itemtype_check(is_areacode,fs_divisioncode,ls_itemcode) = '2' then //단품이면
   ll_stockqty = fl_shipqty
else
	ll_stockqty = 0
end if	
select count(LotNo),
		 ShipQty
  Into :ll_count,
  		 :ll_shipqty
  From tlotno
 Where traceDate     = :is_date
   and areacode      = :is_areacode
   and DivisionCode	= :fs_divisioncode
   and Lotno		   = 'XXXXXX'
   and ItemCode	   = :ls_itemcode
	and custcode      = :ls_custcode
	and shipgubun     = :ls_shipgubun
Group by ShipQty
using sqlpis;
if isnull(ll_count) then
	ll_count = 0
end if	

//출하일자의 같은 Lotno 의 테이타가 있다면 Update
if ll_count > 0 Then
	Update tlotno
	   Set shipqty		   = shipqty + :fl_shipqty,
		    stockqty      = stockqty + :ll_stockqty,
		    lastemp       = 'Y',
			 lastdate      = getdate()
	 Where traceDate     = :is_date
		and areacode      = :is_areacode
		and DivisionCode	= :fs_divisioncode
		and Lotno		   = 'XXXXXX'
		and ItemCode	   = :ls_itemcode
		and custcode      = :ls_custcode
		and shipgubun     = :ls_shipgubun
 	 using sqlpis;
Else
	// 출고일자의 같은 lotno 가 없다면 insert
	Insert into tlotno 
	           (traceDate,AreaCode,DivisionCode,Lotno,
	            Itemcode,custcode,shipgubun,
	            shipusage,prdqty,shipQty,stockqty,Lastemp, lastdate)
     	 Values (:is_date,:is_areacode,:fs_divisioncode,'XXXXXX',
			      :ls_itemcode,:ls_custcode,:ls_shipgubun,
					:ls_shipusage,0,:fl_shipqty,:ll_stockqty,'Y', GetDate())
	using sqlpis;
end if
	
if Sqlpis.sqlcode = 0 then
else
   uo_status.st_message.text = '로트 저장 error(wf_update_tlotno_no_kbno)'	
	return false
End if
//재고에 더하기(단품시)
//if ll_stockqty > 0 then
//	select count(*)
//	  Into :ll_count
//	  From tinv
//	 Where areacode      = :is_areacode
//		and DivisionCode	= :fs_divisioncode
//		and ItemCode	   = :ls_itemcode
//	using sqlpis;
//	if isnull(ll_count) then
//		ll_count = 0
//	end if	
//	if ll_count > 0 Then
//		Update tinv
//			Set invqty		   = invqty + :ll_stockqty,
//				 lastemp       = 'Y',
//				 lastdate      = getdate()
//		 Where areacode      = :is_areacode
//			and DivisionCode	= :fs_divisioncode
//			and ItemCode	   = :ls_itemcode
//		 using sqlpis;
//	Else
//	  INSERT INTO TINV  
//				( Areacode,DivisionCode,ItemCode,   
//				  InvQty,RepairQty,DefectQty,MoveInvQty,ShipInvQty,InvCompute,   
//				  LastEmp,LastDate )  
//	  VALUES ( :is_areacode,:fs_divisioncode,:ls_itemcode,   
//				  :ll_stockqty,0,0,0,0,null,   
//				  'Y',getdate() ) 
//			using sqlpis;
//	end if
//		
//	if Sqlpis.sqlcode = 0 then
//	else
//      uo_status.st_message.text = 'tinv 단품오류(wf_update_tlotno_no_kbno)'	
//		return false
//	End if
//end if

//간판을 안 읽고 저장시 'XXXXXXXXXXX'간판으로 처리
//전표번호 체크 
ls_string = 'srno = ' + "'" + fs_srno + "'"
ll_find = dw_update_tshipsheet.find(ls_string,1,dw_update_tshipsheet.rowcount())
if ll_find > 0 then
	ls_shipsheetno = dw_update_tshipsheet.object.shipsheetno[ll_find]
else
	ls_shipsheetno = 'xxxxxxxxxx'
end if	

select count(*)
  into :ll_count
  from tshipkbhis
 where shipdate = :is_date
   and areacode = :is_areacode
	and divisioncode = :fs_divisioncode
	and srno = :fs_srno
	and truckorder = :is_truckorder
	and shipsheetno = :ls_shipsheetno
	and kbno        = 'XXXXXXXXXXX'
	and kbreleasedate = 'XXXX.XX.XX'
	and kbreleaseseq  = 1  
	using sqlpis;

if isnull(ll_count) then
	ll_count = 0
end if	

if ll_count = 0 then
	INSERT INTO TSHIPKBHIS  
              (ShipDate,AreaCode,DivisionCode,SRNo,TruckOrder,ShipSheetNo,
			      KBNo,KBReleaseDate,KBReleaseSeq,   
               ShipQty,LastEmp,LastDate )  
       VALUES (:is_date,:is_areacode,:fs_divisioncode,:fs_srno,:is_truckorder,:ls_shipsheetno,
               'XXXXXXXXXXX','XXXX.XX.XX',1,   
               :fl_shipqty,'Y',getdate() ) 
   using sqlpis;
else
   update tshipkbhis
	   set shipqty  = shipqty + :fl_shipqty,
		    lastdate = getdate(),
			 lastemp  = 'Y'
    where shipdate = :is_date
      and areacode = :is_areacode
	   and divisioncode = :fs_divisioncode
	   and srno = :fs_srno
	   and truckorder = :is_truckorder
	   and shipsheetno = :ls_shipsheetno
	   and kbno        = 'XXXXXXXXXXX'
	   and kbreleasedate = 'XXXX.XX.XX'
	   and kbreleaseseq  = 1  
	 using sqlpis;
end if	 
if Sqlpis.sqlcode = 0 then
   uo_status.st_message.text = '로트 저장완료(wf_update_tlotno_no_kbno)'		
else
   uo_status.st_message.text = '로트 저장 error(wf_update_tlotno_no_kbno)'		
	return false
End if

return true
end function

public subroutine wf_shipqty_check ();uo_status.st_message.text = '상차계획 확인 중'	
long ll_row, ll_i

dw_shipqty_check.AcceptText( )	
ll_row = dw_shipqty_check.retrieve(is_date,is_areacode,is_divisioncode,integer(is_truckorder))
If ll_row > 0 then
	st_loadqty.text = string(dw_shipqty_check.GetitemNumber(1, 'shipqty_sum'), '#,##0')
//	FOR ll_i = 1 TO ll_row
//		dw_shipqty_check.SetItem(ll_i, 'truckno',is_truckno)
//		dw_shipqty_check.SetItem(ll_i, 'applydate',		is_date)
//	NEXT
else
	Messagebox('조 회', '상차계획이 수립되어 있지 않습니다.')
end if
uo_status.st_message.text = '상차계획 확인 완료'	

end subroutine

public function boolean wf_update_tlotno_stock (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, long fl_stockqty);long ll_count
select count(*) 
  into :ll_count
  from tlotno
  where tracedate    = :fs_close_date
    and areacode     = :fs_areacode
	 and divisioncode = :fs_divisioncode
	 and lotno        = :fs_lotno
	 and itemcode     = :fs_itemcode
	 and custcode     = 'XXXXXX'
	 and shipgubun    = 'X'
	 using sqlpis;
if isnull(ll_count)	 then
	ll_count = 0
end if	
if ll_count = 0 then
  INSERT INTO TLOTNO  
         ( TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,custcode,shipgubun,
           shipusage,PrdQty,StockQty,ShipQty,
           LastEmp,LastDate )  
  VALUES ( :fs_close_date,:fs_areacode,:fs_divisioncode,:fs_lotno,:fs_itemcode,'XXXXXX','X',
           'X',0,:fl_stockqty,0,   
           'Y',getdate() ) 
	  using sqlpis;
else			  
	update tlotno
	   set stockqty     = stockqty + :fl_stockqty,
		    lastemp      = 'Y',
			 lastdate     = getdate()
    where tracedate    = :fs_close_date
      and areacode     = :fs_areacode
	   and divisioncode = :fs_divisioncode
	   and lotno        = :fs_lotno
	   and itemcode     = :fs_itemcode
	   and custcode     = 'XXXXXX'
	   and shipgubun    = 'X'
	 using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "Tlotno insert시 오류가 발생하였습니다."
	return false
end if
return true

end function

public function boolean wf_update_tstock_interface (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_deptcode, string fs_itemcode, string fs_kbno, string fs_kbreleasedate, long fl_kbreleaseseq, long fl_stockqty);long ll_seqno
select max(seqno)
   into :ll_seqno
	from tstock_interface
	where kbno = :fs_kbno
	  and kbreleasedate = :fs_kbreleasedate
	  and kbreleaseseq  = :fl_kbreleaseseq
	  using sqlpis;
	  
if isnull(ll_seqno) then	  
	ll_seqno = 0
end if

ll_seqno = ll_seqno + 1

INSERT INTO Tstock_interface  
		( kbno,kbreleasedate,kbreleaseseq,seqno,
		  stockdate,areacode,divisioncode,workcenter,linecode,ItemCode,
		  stockQty,misflag,interfaceflag,LastEmp,LastDate )  
VALUES (:fs_kbno,:fs_kbreleasedate,:fl_kbreleaseseq,:ll_seqno,
        :fs_close_date,:fs_areacode,:fs_divisioncode,:fs_deptcode,'X',:fs_itemcode,
		  :fl_stockqty,'A','Y',:g_s_empno,getdate() )  
using sqlpis;

if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "Tstock_inetrface insert시 오류가 발생하였습니다."
	return false
end if

return true

end function

public function boolean wf_update_tloadplan ();uo_status.st_message.text = '상차계획 저장중(wf_update_tloadplan)'	
update tloadplan
   set 	truckno	= :is_truckno,
	     	lastemp  = :g_s_empno,
		  	lastdate = getdate()
 where truckorder   = :ii_truckorder
   and areacode     = :is_areacode
   and ShipPlandate = :is_date
   and truckno is Null
	and divisioncode like :is_divisioncode
	using sqlpis;
	
if SQLPIS.Sqlcode <> 0 then
   uo_status.st_message.text = '상차계획 저장 error(wf_update_tloadplan)'	
	return false
end if

update tloadplanhis
   set truckno	 = :is_truckno,
	    shipdate = :is_date,
		 lastemp  = :g_s_empno,
		 lastdate = getdate()
 where truckorder	= :ii_truckorder
   and ShipPlandate	= :is_date
   and truckno is Null
	and areacode = :is_areacode
	and divisioncode like :is_divisioncode
	using sqlpis;

if SQLPIS.Sqlcode = 0 then
   uo_status.st_message.text = '상차계획 저장완료(wf_update_tloadplan)'		
	return true
else	
   uo_status.st_message.text = '상차계획 저장 error(wf_update_tloadplan)'	
	return false
end if

end function

public function boolean wf_save ();boolean lb_commit
long ll_row , ll_i,ll_shipqty,ll_cnt
long  li_truckorder, li_shipqty, li_originalqty, li_remainqty,li_shipplanqty
string ls_shipsheetno, ls_srno, ls_custcode, ls_applydate, ls_truckno, ls_kbno, ls_asgubun, ls_separateflag
string ls_divisioncode,ls_shipgubun,ls_shipusage
string ls_itemcode, ls_shipendflag, ls_srgubun, ls_lotno, ls_shipdate, ls_shipendgubun, ls_shipcountend, ls_dansugubun
string ls_sheetflag,ls_today,ls_pcgubun,ls_kitgubun,ls_close_date
string ls_max_shipsheetno,ls_seq,ls_itemtype
string ls_org_shipsheetno,ls_old_shipsheetno,ls_old_new_shipsheetno
ls_org_shipsheetno = ' '
// tshipsheet 저장
ll_row = dw_update_tshipsheet.rowcount()
ll_cnt = 0
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
FOR ll_i = 1 TO ll_row
	ls_divisioncode = dw_update_tshipsheet.GetitemString(ll_i, 'divisioncode')
	ls_shipsheetno	 = dw_update_tshipsheet.GetitemString(ll_i, 'shipsheetno')
	ls_srno			 = dw_update_tshipsheet.GetitemString(ll_i, 'srno')
	li_truckorder	 = dw_update_tshipsheet.GetitemNumber(ll_i, 'truckorder')
	ls_truckno		 = dw_update_tshipsheet.GetitemString(ll_i, 'truckno')
	ls_custcode		 = dw_update_tshipsheet.GetitemString(ll_i, 'custcode')
	ll_Shipqty	    = dw_update_tshipsheet.GetitemNumber(ll_i, 'shipqty')
	ls_old_shipsheetno = ls_shipsheetno
	ll_cnt = ll_cnt + 1
//	if (ls_shipsheetno <> ls_org_shipsheetno) or (ll_cnt > 10) then
   if ls_old_shipsheetno <> ls_old_new_shipsheetno then
		ls_old_new_shipsheetno = ls_old_shipsheetno
		ll_cnt = 1
		select max(shipsheetno)
		  into :ls_max_shipsheetno
		  from tshipsheet
		 where areacode     = :is_areacode
		   and divisioncode = :ls_divisioncode
			AND shipsheetno  like substring(:ls_shipsheetno,1,6) + '%'
		 using sqlpis;
	  if ls_max_shipsheetno = '' or isnull(ls_max_shipsheetno) then
		  ls_seq = '0000'
	  else
		  ls_seq = right(ls_max_shipsheetno,4) 
	  end if
	  f_pisc_get_string_add(ls_seq,ls_seq)
	  ls_org_shipsheetno = left(ls_shipsheetno,6) + ls_seq
	end if
	ls_shipsheetno = ls_org_shipsheetno
	dw_update_tshipsheet.object.shipsheetno[ll_i] = ls_shipsheetno
	IF Not wf_update_tshipsheet(ls_srno,li_truckorder, ls_truckno, ls_custcode, is_date,ls_shipsheetno, ls_divisioncode,ll_shipqty) then
		lb_commit	= False
		uo_status.st_message.text = "출하전표 작성시 오류발생."
		EXIT
	end if
	lb_commit = true
next
if lb_commit = false then
  return false
end if  
if not wf_update_tshipkbhis(is_areacode,is_divisioncode,is_date,long(is_truckorder)) then
   uo_status.st_message.text = "tshipkbhis오류"
	lb_commit = false
else
      lb_commit = true
end if	
if lb_commit = false then
	 return lb_commit
end if	
if lb_commit then
// tsrorder,tinv,tshipstatus,tshipinv Table 저장
	ll_row	=  dw_update_tsrorder.rowcount()
	FOR ll_i = 1 TO ll_row
		 ls_divisioncode	= dw_update_tsrorder.GetitemString(ll_i, 'divisioncode')
		 ls_srno	         = dw_update_tsrorder.GetitemString(ll_i, 'srno')
		 li_remainqty	   = dw_update_tsrorder.GetitemNumber(ll_i, 'shipremainqty')
		 ls_shipendgubun  = dw_update_tsrorder.GetitemString(ll_i, 'shipendgubun')
		 ls_shipdate		= dw_update_tsrorder.GetitemString(ll_i, 'shipdate')
		 
		 IF Not wf_update_tsrorder(ls_srno, li_remainqty, ls_shipendgubun,ls_shipdate,ls_divisioncode) then
		    uo_status.st_message.text = "SR변경시 오류발생."
		 	 lb_commit	= False
			 Exit
		 end if

		 select a.truckloadqty,b.shipgubun,b.shipusage,a.itemcode,a.custcode,b.pcgubun,b.kitgubun
	      into :li_shipplanqty,:ls_shipgubun,:ls_shipusage,:ls_itemcode,:ls_custcode,:ls_pcgubun,:ls_kitgubun
	      from tloadplan a,tsrorder b
	     where a.areacode = :is_areacode
	       and a.shipplandate = :is_date
		    and a.divisioncode = :ls_divisioncode
		  	 and a.srno = :ls_srno
			 and a.srno = b.srno
			 AND A.TRUCKorder = :is_truckorder
		 using sqlpis;
		ls_itemtype     = f_piss_itemtype_check(is_areacode,ls_divisioncode,ls_itemcode)
		if  ls_itemtype = '2' or ls_itemtype = '4'  then //단품,상품이면
		 
		else 
			 if (ls_kitgubun = 'N') or (ls_pcgubun = 'C' and ls_kitgubun = 'Y') then //모품번은 처리안함
					 IF Not wf_update_tinv(ls_divisioncode,ls_itemcode,li_shipplanqty,ls_shipgubun) then
						 uo_status.st_message.text = "tinv오류"
						 lb_commit	= False
						Exit
					 end if
			  end if
		end if
		 
		 if ls_shipgubun = 'M' then
		    IF Not wf_update_tshipinv(ls_divisioncode,ls_srno,li_shipplanqty) then
			   lb_commit	= False
			   Exit
			end if
		 end if
		 lb_commit = true
	NEXT
else
	return lb_commit
end if
if lb_commit = false then
	 return lb_commit
end if	
//if ii_notreading = 1 then  //간판을 다 읽지 않고 처리시
//	if not wf_update_tshipkbhis1(is_areacode,ls_close_date,long(is_truckorder)) then
//      messagebox("확인","tshipkbhis오류")
//		lb_commit = false
//	else
//      lb_commit = true
//	end if	
//else                       //간판을 다 읽고 처리시
//	if Not wf_update_tkbhistory(is_areacode,is_divisioncode,ls_close_date,integer(is_truckorder)) then
//      messagebox("확인","tkbhistory 오류")
//		lb_commit = false
//	else
//		lb_commit = true
//	end if
//end if
//
if lb_commit then
// tkbhis,Tkb Table 저장
	ll_row = dw_shipkb_read.rowcount()
	
	FOR ll_i = 1 TO ll_row
		ls_divisioncode = dw_shipkb_read.GetitemString(ll_i, 'divisioncode')
		ls_kbno 			 = dw_shipkb_read.GetitemString(ll_i, 'kbno')
		ls_dansugubun	 = dw_shipkb_read.GetItemString(ll_i, 'dansuflag')
		li_originalqty	 = dw_shipkb_read.GetitemNumber(ll_i, 'readingqty') + dw_shipkb_read.GetitemNumber(ll_i, 'dansuqty')
		//tkbhistory도 같이 함
		IF Not wf_update_tkbhis(ls_kbno,ls_dansugubun,li_originalqty,ls_divisioncode) Then
         		uo_status.st_message.text = "간판 변경시 오류발생."
			lb_commit	= False
			Exit
		end if
		IF Not wf_update_tkb(ls_kbno,ls_dansugubun, li_originalqty) Then
			uo_status.st_message.text = "tkb error"
			lb_commit	= False
			Exit
		end if
		lb_commit = true
	NEXT
else
	return lb_commit
end if
if lb_commit = false then
	return lb_commit
end if	
if lb_commit then
	if Not wf_update_tloadplan() then
      	uo_status.st_message.text = "tloadplan오류"
		lb_commit = false
	else
		lb_commit = true
	end if
else
	return lb_commit
end if

return lb_commit

end function

public function boolean wf_update_tkbhis (string fs_kbno, string fs_gubun, long fi_shipqty, string fs_divisioncode);uo_status.st_message.text = '간판이력 저장중(wf_update_tkbhis)'	
long ll_seqno, li_count, li_max
string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
long ll_kbreleaseseq
string ls_kbreleasedate,ls_itemcode,ls_kbstatuscode

Select count(KBNO),kbreleasedate,kbreleaseseq,itemcode
  into :li_count,:ls_kbreleasedate,:ll_kbreleaseseq,:ls_itemcode
  From tkbhis
 Where kbno = :fs_kbno
	And KBActiveGubun	= 'A'
	And KBStatusCode	= 'D'
	and areacode = :is_areacode
	and divisioncode = :fs_divisioncode
	group by kbreleasedate,kbreleaseseq,itemcode
	using sqlpis;
	
IF li_count = 1 then
	
	IF fs_gubun = 'N' Then //짜투리 출하가 아니라면
	   ls_kbstatuscode = 'F'
	else
		ls_kbstatuscode = 'D'
	end if
	Update tkbhis
		set CurrentQty = CurrentQty - :fi_shipqty,
			 shipqty    = shipqty + :fi_shipqty,
			 KBStatusCode = :ls_kbstatuscode,			
			 KBShipTime	= GetDate(),
			 Lastemp		= 'Y',
			 shipdate   = :ls_close_date,
			 LastDate	= GetDate()
	 Where KBNO			= :fs_kbno
		and areacode   = :is_areacode
		and divisioncode = :fs_divisioncode
		And KBActiveGubun	= 'A'
		And KBStatusCode	= 'D'
		using sqlpis;
 
//	If sqlpis.sqlcode <> 0 Then
//		uo_status.st_message.text = '간판 저장 error(wf_update_tkbhis)'	
//		return False
//	End if
//Else
//	uo_status.st_message.text = '간판 저장 error(wf_update_tkbhis)'	
//	Return False
End if
uo_status.st_message.text = '간판이력 저장완료(wf_update_tkbhis)'	
return true
end function

public function boolean wf_save_danpum_inv101 (long a_row);int i 
long ll_loadqty,ll_invqty
string ls_itemcode,ls_itemtype,ls_divisioncode

for i = 1 to a_row 
	ls_divisioncode = dw_shipqty_check.object.divisioncode[i]
	ls_itemcode     = trim(dw_shipqty_check.object.itemcode[i])
	ls_itemtype     = f_piss_itemtype_check(is_areacode,ls_divisioncode,ls_itemcode)
	if ( ls_itemtype = '2' or ls_itemtype = '4' ) and f_piss_tmstpartkbvalid(is_areacode,ls_divisioncode,ls_itemcode) = false then //단품,상품이면
	   if isnull(sqlca.dbhandle()) or sqlca.dbhandle() <= 0 then
			return false
		end if 
		ll_loadqty      = dw_shipqty_check.object.loadqty[i]
		update pbinv.inv101
			set iperp1 = iperp1 + : ll_loadqty
		where comltd = :g_s_company     and xplant = :is_areacode and
				div    = :ls_divisioncode and itno   = :ls_itemcode using sqlca ;
	end if
next
return true
end function

public function boolean wf_tstocketc (string fs_itemcode, string fs_deptcode, long fl_stockqty, string fs_divisioncode);string ls_proofno,ls_proofno_seq,ls_year,ls_month,ls_productgroup
string ls_close_date

ls_close_date = f_piss_getdate_close(is_areacode,fs_divisioncode)

select max(substring(proofno,8,4))
  into :ls_proofno
  from tstocketc
  where areacode = :is_areacode
    and divisioncode = :fs_divisioncode
	 and inputdate like substring(:ls_close_date,1,7) + '%'
    using sqlpis;
if ls_proofno = '' or isnull(ls_proofno) then
	ls_proofno_seq = 'Z000'
else
	ls_proofno_seq	= 'Z'+right(ls_proofno,3)
end if
ls_year = mid(ls_close_date,4,1) 
ls_month = mid(ls_close_date,6,2)		

f_pisc_get_string_add(ls_proofno_seq,ls_proofno_seq)
select top 1 productgroup
	    into :ls_productgroup
from tmstmodel
where areacode = :is_areacode
  and divisioncode = :fs_divisioncode
  and itemcode = :fs_itemcode
using sqlpis;
if ls_productgroup = '' or isnull(ls_productgroup) then
  ls_productgroup = '00'
end if

ls_proofno = is_areacode + fs_divisioncode + ls_productgroup + ls_year + ls_month  + ls_proofno_seq

INSERT INTO TSTOCKETC  
	( AreaCode,   
	DivisionCode,   
	InputDate,   
	InputFlag,   
	ProofNo,   
	DeptCode,   
	ItemCode,   
	InputQty,   
	LastEmp,   
	LastDate )  
VALUES 
	( :is_areacode,   
	:fs_divisioncode,   
	:ls_close_date,   
	'1',   
	:ls_proofno,   
	:fs_deptcode,   
	:fs_itemcode,   
	:fl_stockqty,   
	'Y',   
	getdate() )  
using sqlpis;
if sqlpis.sqlcode <> 0 then
	uo_status.st_message.text = "tstocketc error"
	return false
else
	return true
end if	
end function

public function boolean wf_save_before (string fs_areacode, string fs_divisioncode, string fs_applydate, string fs_deptcode, string fs_itemcode, long fl_stockqty);string ls_kbno,ls_temp_kbno,ls_temp_seqno,ls_productgroup
long ll_count

//창고 입고시 tinv
if wf_tstocketc(fs_itemcode,fs_deptcode,fl_stockqty,fs_divisioncode) = false then
	  uo_status.st_message.text = "Tstocketc insert시 오류가 발생하였습니다."
   Return false
End if
select count(*)
  into :ll_count
  from tinv
 where ItemCode		= :fs_itemcode
	and areacode    = :fs_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if ll_count > 0 then
	Update tinv
		set Invqty	 = invqty	+ :fl_stockqty,
			 LastEmp	 = 'Y',
			 LastDate = GetDate()
	 where ItemCode	  = :fs_itemcode
		and areacode     = :fs_areacode
		and divisioncode = :fs_divisioncode
		using sqlpis;
else
	Insert into tinv(AreaCode,DivisionCode, Itemcode,
						  Invqty, Lastemp, lastDate)
			Values(:fs_areacode,:fs_divisioncode,:fs_itemcode, &
					 :fl_stockqty, 'Y', Getdate())
	using sqlpis;
end if
if sqlpis.sqlcode = 0 then
Else
	uo_status.st_message.text = "Tinv insert시 오류가 발생하였습니다."
	Return false
End if
return true
end function

public function boolean wf_save_stock ();int i , ln_count
string ls_itemcode,ls_deptcode,ls_divisioncode
long	ln_stockqty

ln_count = dw_plan_read.rowcount()

for i = 1 to ln_count
	if dw_plan_read.object.inoutflag[i] = 1 then
		ls_divisioncode = trim(dw_plan_read.object.divisioncode[i])		
		ls_itemcode = 	trim(dw_plan_read.object.itemcode[i])
		ls_deptcode = 	trim(dw_plan_read.object.deptcode[i])
		ln_stockqty	=	dw_plan_read.object.planqty[i]
		if wf_create_kbno(ls_itemcode,ls_deptcode,ln_stockqty,ls_divisioncode) then
			if wf_save_before(is_areacode,ls_divisioncode,is_kbno,ls_deptcode,ls_itemcode,ln_stockqty) then
			else
				return false
			end if
		else
			return false
		end if
	end if
next

return true
end function

public function boolean wf_create_kbno (string fs_itemcode, string fs_deptcode, long fs_stockqty, string fs_divisioncode);string ls_tempkbsn,ls_kbsn,ls_applyfrom,ls_temp_kbno
long ll_rackqty,i,ll_remainqty,ll_count
string ls_close_date,ls_apply_date
string ls_shift  //주야
string ls_lotno,ls_item_type
 
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_apply_date = f_pisc_get_date_applydate("%", "%",f_pisc_get_date_nowtime())
ls_shift = f_pisc_get_date_shift_close(is_areacode,fs_divisioncode,f_pisc_get_date_nowtime())
ls_lotno = f_pisc_get_lotno(is_areacode,fs_divisioncode,ls_close_date,ls_shift)
if not wf_update_tlotno_stock(ls_close_date,is_areacode,fs_divisioncode,ls_lotno,fs_itemcode,fs_stockqty) then
	return false
end if	
select top 1 rackqty
  into :ll_rackqty
  from tmstkb
 where areacode 		= :is_areacode
   and divisioncode 	= :fs_divisioncode
	and itemcode 		= :fs_itemcode
  using sqlpis;
if ll_rackqty = 0 or isnull(ll_rackqty) then
   ll_rackqty = fs_stockqty
end if	

ll_remainqty = fs_stockqty

ll_count = ceiling(fs_stockqty/ll_rackqty)
ls_item_type = f_piss_itemtype_check(is_areacode,fs_divisioncode,fs_itemcode)

for i = 1 to ll_count step 1
	select max(kbno)
	  into :ls_temp_kbno
	  from tkb
	 where kbno like :is_areacode + :fs_divisioncode + 'Z' + substring(:is_date,3,2) + substring(:is_date,6,2) + '%'
		using sqlpis;
	if ls_temp_kbno = '' or isnull(ls_temp_kbno) then
		ls_temp_kbno = is_areacode + fs_divisioncode + 'Z' + mid(ls_close_date,3,2) +mid(ls_close_date,6,2) + '0000'
	end if
	ls_kbsn	= Right(ls_temp_kbno, 4)
	If not f_pisc_get_string_add(ls_kbsn, ls_kbsn) Then
		uo_status.st_message.text = "f_pisc_get_string_add error"
		return false
	end if	
	if ll_remainqty <= ll_rackqty then
		ll_rackqty = ll_remainqty
	else
		ll_remainqty = ll_remainqty - ll_rackqty
	end if
	ls_temp_kbno	= Left(ls_temp_kbno, 7) + ls_kbsn
	dw_save.ReSet()
	is_kbno = ls_temp_kbno
	If dw_save.Retrieve(is_kbno,is_areacode,fs_divisioncode,fs_deptcode,'X',fs_itemcode,ls_apply_date, &
							  'T','N',ll_rackqty,g_s_empno) > 0 Then
		If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
			update tkbhis
				set kbreleasedate = :ls_apply_date,
					 kbreleaseseq  = 1,
					 printcount    = 1,
					 kbactivegubun = 'A',
					 kbprinttime   = getdate(),
					 stockqty      = :ll_rackqty,
					 stockdate     = :is_date,
					 kbstocktime   = getdate(),
					 kbstatuscode  = 'D',
					 lastemp       = 'Y',
					 lastdate      = getdate(),
					 lotno         = :ls_lotno
				where areacode     = :is_areacode
				  and divisioncode = :fs_divisioncode
				  and kbno         = :is_kbno
			   using sqlpis;
			update tkb
				set kbstatuscode  = 'D',
				    kbactivegubun = 'A',
					 printcount    = 1,
					 kbprinttime   = getdate(),
					 stockqty      = :ll_rackqty,
					 stockdate     = :is_date,					 
					 kbstocktime   = getdate(),
					 lastemp       = 'Y',
					 lastdate      = getdate(),
 					 lotno         = :ls_lotno
				where areacode     = :is_areacode
				  and divisioncode = :fs_divisioncode
				  and kbno         = :is_kbno
			   using sqlpis;
			
			if ls_item_type <> '2' then //상품은 인터페이스 안함 
				if not wf_update_tstock_interface(ls_close_date,is_areacode,fs_divisioncode,fs_deptcode,fs_itemcode,is_kbno,ls_close_date,1,ll_rackqty) then
					return false
				end if	
		   end if
			wf_kbreading(is_kbno)
		else
			uo_status.st_message.text = "현품표 생성시 오류 발생"
			return false
		end if
	end if
next
return true
end function

on w_piss130u.create
int iCurrent
call super::create
this.uo_date=create uo_date
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_shipkb_read=create dw_shipkb_read
this.st_2=create st_2
this.st_3=create st_3
this.dw_truckorder=create dw_truckorder
this.st_4=create st_4
this.st_5=create st_5
this.st_loadqty=create st_loadqty
this.st_readqty=create st_readqty
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_update_tshiplotno=create dw_update_tshiplotno
this.dw_update_tsrorder=create dw_update_tsrorder
this.dw_update_tinv=create dw_update_tinv
this.st_itemname=create st_itemname
this.dw_update_tshipstatus=create dw_update_tshipstatus
this.sle_kbno=create sle_kbno
this.dw_update_tshipstatus1=create dw_update_tshipstatus1
this.cb_3=create cb_3
this.dw_update_tshipkbhis=create dw_update_tshipkbhis
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_7=create gb_7
this.dw_plan_read=create dw_plan_read
this.dw_update_tshipsheet=create dw_update_tshipsheet
this.em_truckno=create em_truckno
this.dw_2=create dw_2
this.dw_shipqty_check=create dw_shipqty_check
this.dw_save=create dw_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_date
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_shipkb_read
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_truckorder
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.st_loadqty
this.Control[iCurrent+11]=this.st_readqty
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.dw_update_tshiplotno
this.Control[iCurrent+15]=this.dw_update_tsrorder
this.Control[iCurrent+16]=this.dw_update_tinv
this.Control[iCurrent+17]=this.st_itemname
this.Control[iCurrent+18]=this.dw_update_tshipstatus
this.Control[iCurrent+19]=this.sle_kbno
this.Control[iCurrent+20]=this.dw_update_tshipstatus1
this.Control[iCurrent+21]=this.cb_3
this.Control[iCurrent+22]=this.dw_update_tshipkbhis
this.Control[iCurrent+23]=this.gb_1
this.Control[iCurrent+24]=this.gb_2
this.Control[iCurrent+25]=this.gb_3
this.Control[iCurrent+26]=this.gb_4
this.Control[iCurrent+27]=this.gb_5
this.Control[iCurrent+28]=this.gb_7
this.Control[iCurrent+29]=this.dw_plan_read
this.Control[iCurrent+30]=this.dw_update_tshipsheet
this.Control[iCurrent+31]=this.em_truckno
this.Control[iCurrent+32]=this.dw_2
this.Control[iCurrent+33]=this.dw_shipqty_check
this.Control[iCurrent+34]=this.dw_save
end on

on w_piss130u.destroy
call super::destroy
destroy(this.uo_date)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_shipkb_read)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_truckorder)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_loadqty)
destroy(this.st_readqty)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_update_tshiplotno)
destroy(this.dw_update_tsrorder)
destroy(this.dw_update_tinv)
destroy(this.st_itemname)
destroy(this.dw_update_tshipstatus)
destroy(this.sle_kbno)
destroy(this.dw_update_tshipstatus1)
destroy(this.cb_3)
destroy(this.dw_update_tshipkbhis)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_7)
destroy(this.dw_plan_read)
destroy(this.dw_update_tshipsheet)
destroy(this.em_truckno)
destroy(this.dw_2)
destroy(this.dw_shipqty_check)
destroy(this.dw_save)
end on

event open;call super::open;//SetPointer(HourGlass!)
//show()
//dw_truckorder.Insertrow(0)
//
////is_today	= f_getcurrentdate()
////wf_status_bar_set()
//
//wf_init()
//
//dw_shipqty_check.SettransObject(SQLPIS)
//
PostEvent('ue_post_open')
//
//
end event

event ue_delete;call super::ue_delete;//string ls_divisioncode,ls_itemcode, ls_kbno, ls_srno,ls_shipsheetno, ls_lotno, ls_custcode, ls_find,ls_asgubun
//integer li_originalqty
//long ll_find, ll_i
//ls_divisioncode = dw_shipkb_read.GetItemString(il_currentrow, 'divisioncode')
//ls_itemcode	    = dw_shipkb_read.GetItemString(il_currentrow, 'itemcode')
//ls_kbno			 = dw_shipkb_read.GetItemString(il_currentrow, 'kbno')
//ls_srno	       = dw_shipkb_read.GetItemString(il_currentrow, 'srno')
//li_originalqty	 = dw_shipkb_read.GetItemNumber(il_currentrow, 'shipqty')
//
////
////
//ls_find = "ItemCode = '" + ls_Itemcode + "' and  DivisionCode = '" + ls_divisioncode + "' and asgubun = '" + ls_asgubun+ "' "
//ll_find = dw_update_tinv.find(ls_find, 1, dw_update_tinv.rowcount())
//if ll_find > 0 then 
//	dw_update_tinv.SetItem(ll_find, 'shipqty', dw_update_tinv.getitemNumber(ll_find, 'shipqty') - li_originalqty)
//end if
////
//ls_find = "itemcode = '" + ls_itemcode + "' and  custcode = '" + ls_custcode + "' and asgubun = '" + ls_asgubun + "'"
//ll_find = dw_update_tshipstatus.find(ls_find, 1, dw_update_tshipstatus.rowcount())
//if ll_find > 0 then 
//	dw_update_tshipstatus.SetItem(ll_find, 'shipqty', dw_update_tshipstatus.getitemNumber(ll_find, 'shipqty') - li_originalqty)
//end if
////
//ls_find = "itemcode = '" + ls_itemcode + "' and  lotno = '" + ls_lotno + "' "
//ll_find = dw_update_tshiplotno.find(ls_find, 1, dw_update_tshiplotno.rowcount())
//if ll_find > 0 then 
//	dw_update_tshiplotno.SetItem(ll_find, 'shipqty', dw_update_tshiplotno.getitemNumber(ll_find, 'shipqty') - li_originalqty)
//end if
////
//ls_find = "itemcode = '" + ls_itemcode + "'"
//ll_find = dw_shipqty_check.find(ls_find, 1, dw_shipqty_check.rowcount())
//if ll_find > 0 then 
//	dw_shipqty_check.SetItem(ll_find, 'readingqty', dw_shipqty_check.getitemNumber(ll_find, 'readingqty') - li_originalqty)
//end if
////
//st_readqty.text = string(dw_shipqty_check.getitemNumber(ll_find, 'readingqty'), '#,##0')
//dw_shipkb_read.deleterow(il_currentrow)
//if dw_shipkb_read.rowcount() > 0 then 
//	dw_shipkb_read.Post Event RowFocusChanged(1)
//	dw_shipkb_read.setfocus()
//	dw_shipkb_read.scrolltorow(1)
//end if
////
//////cb_save.enabled		= false
//////cb_srview.enabled		= false
//
end event

event ue_save;boolean lb_jaego
lb_jaego = true
long ll_invqty,ll_loadqty
string ls_close_date,ls_itemtype

ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
IF is_date > ls_close_date THEN
	messagebox("확인","마감일 이후는 출하할 수 없읍니다.")
	return 
end if	
IF mid(is_date,1,7) <> mid(ls_close_date,1,7) THEN
	messagebox("확인","이미 마감된 월입니다.")
	return 
end if	

long ll_row, ll_i, ll_rowmove,i
integer li_rtn,li_inout = 0
string ls_shipsheetno,ls_divisioncode,ls_itemcode,ls_check_flag
Boolean lb_commit	= True
boolean lb_item = true
string ls_today 

ll_row = dw_shipqty_check.rowcount()
lb_item = true
uo_status.st_message.text = '재고 확인 중'
for i = 1 to ll_row step 1
	ls_divisioncode = dw_shipqty_check.object.divisioncode[i]
	ls_itemcode     = dw_shipqty_check.object.itemcode[i]
	ls_check_flag   = dw_shipqty_check.object.check_flag[i]
	ll_loadqty      = dw_shipqty_check.object.loadqty[i]
	ls_itemtype     = f_piss_itemtype_check(is_areacode,ls_divisioncode,ls_itemcode)
	if  ls_itemtype <> '2' and ls_itemtype <> '4' then //단품,상품이 아니면
		if f_piss_inoutitem_check(is_areacode,ls_divisioncode,ls_itemcode) < 1 then
			select invqty
				into :ll_invqty
				from tinv
			  where areacode     = :is_areacode
				 and divisioncode = :ls_divisioncode
				 and itemcode     = :ls_itemcode
				 using sqlpis;
			 if isnull(ll_invqty)  then
				 ll_invqty = 0
			 end if
			 if ll_loadqty > ll_invqty then
				 messagebox("확인","공장 : " + ls_divisioncode + " 품번 : "  + ls_itemcode + '~r~n' + &
										 "출하수량 : " + string(ll_loadqty) + " 재고수량 : " + string(ll_invqty) + '~r~n'+ &
										 "재고가 출하 수량보다 작습니다. " + "~r~n" + &
										 "제품입고 처리를 하십시요.")
				 lb_jaego = false 
				 exit
			 end if
			 if ls_check_flag <> 'Y' then //다 읽지 않았으면
				 lb_item = false
			 end if
		else
			li_inout += 1
		end if
	elseif f_piss_tmstpartkbvalid(is_areacode,ls_divisioncode,ls_itemcode) = false then
		string ls_danpum_check
		ls_danpum_check = f_piss_danpum_check(is_areacode,ls_divisioncode,ls_itemcode,ll_loadqty) 
		if ls_danpum_check = 'S' then
			messagebox("확인","공장 : " + ls_divisioncode + " 단품  : "  + ls_itemcode + '~r~n' + &
			                   "재고가 출하 수량보다 작습니다. " + "~r~n" + &
									 "재고 수량을 증가 후 재작업 바랍니다")
			lb_jaego = false 
         exit
		elseif ls_danpum_check = 'F' then
			messagebox("확인","현재 KDAC 생산 시스템에 접근불가 상태입니다.")
			lb_jaego = false 
         exit
		end if
	end if
next	

if lb_jaego = false then
   return 
end if	
ii_notreading = 3

//단품 품번 check
if lb_item = false then
	messagebox('확인', '단품이 아닌 품번 중 Reading 하지 않은 간판이 있습니다.')
	return 
end if
//if lb_item = false then
//	ii_notreading = messagebox('확인', '아직 단품이 아닌 품번 Reading 하지 않은 간판이 있습니다. .',Exclamation!, OKCancel!, 2)
//end if
//if ii_notreading = 2 then
//	return 
//end if
//전체 품번 check
//if (st_readqty.text <> st_loadQty.text)  then
//	messagebox('확인', '아직 Reading 하지 않은 간판이 있습니다.')
//	return 
//end if
//if (st_readqty.text <> st_loadQty.text)  then
//	ii_notreading = messagebox('확인', '아직 Reading 하지 않은 간판이 있습니다.',Exclamation!, OKCancel!, 2)
//end if
//if ii_notreading = 2 then
//	return 
//end if

dw_shipkb_read.SetRedraw(false)
dw_shipkb_read.setFilter('')
dw_shipkb_read.filter()
dw_shipkb_read.SetRedraw(true)

SQLPIS.AutoCommit	= False
uo_status.st_message.text = '저장 시작'	
SetPointer(HourGlass!)
if li_inout > 0 then
	if wf_save_stock() = false then
		RollBack using SQLPIS;
		SQLPIS.AutoCommit	= true	
		uo_status.st_message.text = '저장 실패'		
		MessageBox("SQL Error", "데이타베이스에 오류가 발생하였습니다.", StopSign!)
		TriggerEvent('ue_reset')
		return
	end if
end if
if wf_save() then
	if wf_save_danpum_inv101(ll_row) = true then
		Commit using sqlpis;
		SQLPIS.AutoCommit	= true		
		uo_status.st_message.text = '저장 완료'	
		messagebox("확인","출하가 완료되었읍니다.")
		dw_plan_read.reset()
	else
		RollBack using SQLPIS;
		SQLPIS.AutoCommit	= true	
		uo_status.st_message.text = '저장 실패'
		messagebox("확인","현재 KDAC 생산 시스템에 접근불가 상태입니다.")
	end if
else
	RollBack using SQLPIS;
	SQLPIS.AutoCommit	= true	
	uo_status.st_message.text = '저장 실패'		
	MessageBox("SQL Error", "데이타베이스에 오류가 발생하였습니다.", StopSign!)
end if

TriggerEvent('ue_reset')
end event
event ue_reset;call super::ue_reset;wf_init()

st_loadqty.text = ''
st_readqty.text = ''
//dw_shipsheet.reset()
dw_shipqty_check.reset()
dw_shipkb_read.reset()
dw_update_tshiplotno.reset()
dw_update_tshipsheet.reset()
dw_update_tshipstatus.reset()
dw_update_tsrorder.reset()
dw_update_tinv.reset()
//dw_update_tuploadsr.reset()
//dw_update_tuploadmove.reset()
wf_truckorder()
wf_truck_set()
dw_truckorder.SetItem(1, 'truckorder', '')
em_truckno.text = ''
sle_kbno.text = ''
st_itemname.text = ''

//
end event

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_shipkb_read, FULL)
//
//of_resize()
//
end event

event ue_retrieve;string ls_truckno
ls_truckno = trim(em_truckno.text)
if ls_truckno = '' or isnull(ls_truckno) then
	messagebox("확인","차량번호를 입력하세요.")
	em_truckno.setfocus()
	return
end if
integer li_rtn
long ll_row, ll_qty, ll_i
//string ls_truckno

ls_truckno	= trim(em_truckno.text)
if ls_truckno = '' or isnull(ls_truckno) then  //트럭번호를 입력안하면 return
	return
end if	
is_truckno = ls_truckno
ii_truckorder = long(is_truckorder)
li_rtn =  MessageBox('확인', '~r~n1. 출하일자 : ' + mid(is_date, 1, 4) + '년' + mid(is_date, 6, 2) + '월' + mid(is_date, 9, 2) + '일' + &
							  '~r~n2. 차량번호 : ' + string(is_truckorder) + ' 호' + &
							  '~r~n~r~n 정확합니까?', question!,  YesNo!, 1)
IF li_rtn = 1 then
	is_truckno	= ls_truckno
	dw_truckorder.enabled = true
	wf_shipqty_check()
	
	dw_update_tshipsheet.Retrieve(is_areacode,is_divisioncode,ii_truckorder,is_truckno,is_month,is_date)
   dw_shipkb_read.reset()
   dw_plan_read.reset()
	
	dw_update_tsrorder.Retrieve(is_date,is_areacode,is_divisioncode, ii_truckorder)

   sle_kbno.text = ''
	sle_kbno.setfocus()
Else
	em_truckno.text = ''
	em_truckno.setfocus()
	return 
end if

dw_shipkb_read.reset()
sle_kbno.text = ''

if dw_plan_read.retrieve(is_date,is_areacode,is_divisioncode,integer(is_truckorder)) = 0 then
	messagebox("확인","출하 계획이 없읍니다.")
	dw_truckorder.setfocus()
	em_truckno.text = ''
	return 
end if	

end event

event activate;call super::activate;dw_shipqty_check.SettransObject(SQLPIS)
dw_plan_read.SetTransObject(SQLPIS)
dw_update_tshipkbhis.SetTransObject(SQLPIS)
dw_update_tshipsheet.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
dw_update_tsrorder.SetTransObject(SQLPIS)
dw_update_tshipstatus.SetTransObject(SQLPIS)
dw_update_tshipstatus1.SetTransObject(SQLPIS)
dw_shipqty_check.SetTransObject(SQLPIS)
                    
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss130u
integer y = 2400
end type

type uo_date from u_pisc_date_applydate within w_piss130u
event destroy ( )
integer x = 73
integer y = 96
integer taborder = 60
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event constructor;call super::constructor;is_date = is_uo_date
is_month = mid(is_date,1,7)

end event

event ue_losefocus;call super::ue_losefocus;is_date = is_uo_date
is_month = mid(is_date,1,7)
end event

event ue_select;call super::ue_select;if is_date <> is_uo_date then
	dw_shipkb_read.reset()
end if	
is_date = is_uo_date
is_month = mid(is_date,1,7)
//wf_truckorder()
wf_reset()

end event

type uo_area from u_pisc_select_area within w_piss130u
event destroy ( )
integer x = 795
integer y = 96
integer taborder = 160
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_shipqty_check.SettransObject(SQLPIS)
dw_plan_read.SetTransObject(SQLPIS)
dw_update_tshipkbhis.SetTransObject(SQLPIS)
dw_update_tshipsheet.SetTransObject(SQLPIS)
dw_update_tsrorder.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
dw_update_tshipstatus.SetTransObject(SQLPIS)
dw_update_tshipstatus1.SetTransObject(SQLPIS)
dw_shipqty_check.SetTransObject(SQLPIS)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_shipkb_read.reset()
//wf_truckorder()
//wf_reset()
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_empno					조회하고자 하는 사번 (지역별/공장별 권한에 따른 조회를 위하여)
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 공장 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (공장코드는 '%', 공장명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_divisioncode		선택된 공장 코드 (reference)
//						string			rs_divisionname		선택된 공장 명 (reference)
//						string			rs_divisionnameeng	선택된 공장 영문 명 (reference)
//	Returns		: none
//	Description	: 공장을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss130u
event destroy ( )
integer x = 1367
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_shipqty_check.SettransObject(SQLPIS)
dw_plan_read.SetTransObject(SQLPIS)
dw_update_tshipkbhis.SetTransObject(SQLPIS)
dw_update_tshipsheet.SetTransObject(SQLPIS)
dw_update_tsrorder.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
dw_update_tshipstatus.SetTransObject(SQLPIS)
dw_update_tshipstatus1.SetTransObject(SQLPIS)
dw_shipqty_check.SetTransObject(SQLPIS)

is_divisioncode = is_uo_divisioncode
dw_shipkb_read.reset()
//wf_truckorder()
wf_reset()


end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event constructor;call super::constructor;is_divisioncode = is_uo_divisioncode
end event

type dw_shipkb_read from u_vi_std_datawindow within w_piss130u
integer x = 3552
integer y = 520
integer width = 997
integer height = 1960
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss130u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type st_2 from statictext within w_piss130u
integer x = 59
integer y = 288
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "차량순번"
boolean focusrectangle = false
end type

type st_3 from statictext within w_piss130u
integer x = 59
integer y = 376
integer width = 274
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "차량번호"
boolean focusrectangle = false
end type

type dw_truckorder from datawindow within w_piss130u
integer x = 329
integer y = 268
integer width = 425
integer height = 88
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_02"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_truckorder = data
em_truckno.text = ''
dw_shipkb_read.reset()
dw_plan_read.reset()
em_truckno.setfocus()
end event

type st_4 from statictext within w_piss130u
integer x = 3177
integer y = 296
integer width = 375
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "상차수량"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_piss130u
integer x = 3177
integer y = 376
integer width = 375
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "READING수량"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_loadqty from statictext within w_piss130u
integer x = 3570
integer y = 284
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_readqty from statictext within w_piss130u
integer x = 3570
integer y = 368
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_piss130u
integer x = 2185
integer y = 88
integer width = 457
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판입력"
end type

event clicked;iw_this.TriggerEvent('ue_kbinput')
end event

type cb_2 from commandbutton within w_piss130u
integer x = 2642
integer y = 88
integer width = 457
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "상차계획"
end type

event clicked;string ls_parm, ls_size

ls_size	= Left(String(WorkSpaceX()) + Space(10), 10)	+ &
			  Left(String(WorkSpaceY()) + Space(10), 10)	+ &
			  Left(String(WorkSpaceWidth()) + Space(10), 10) + &
			  Left(String(WorkSpaceHeight()) + Space(10), 10)

ls_parm			= is_areacode + is_divisioncode + Left(is_date 					+ Space(10), 10) + &
					  Left(string(ii_truckorder)	+ Space(10), 10) + ls_size
					  
OpenWithParm(w_piss120i, ls_parm)



		  
end event

type dw_update_tshiplotno from datawindow within w_piss130u
boolean visible = false
integer x = 1106
integer y = 1732
integer width = 411
integer height = 432
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_update_tsrorder from datawindow within w_piss130u
boolean visible = false
integer x = 1339
integer y = 1804
integer width = 411
integer height = 432
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_07"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_update_tinv from datawindow within w_piss130u
boolean visible = false
integer x = 1801
integer y = 1832
integer width = 411
integer height = 432
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_08"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_itemname from statictext within w_piss130u
integer x = 1934
integer y = 308
integer width = 1170
integer height = 112
boolean bringtotop = true
integer textsize = -15
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_update_tshipstatus from datawindow within w_piss130u
boolean visible = false
integer x = 2217
integer y = 1832
integer width = 411
integer height = 432
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_10"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_kbno from singlelineedit within w_piss130u
integer x = 859
integer y = 288
integer width = 992
integer height = 160
integer taborder = 190
boolean bringtotop = true
integer textsize = -26
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
textcase textcase = upper!
integer limit = 11
borderstyle borderstyle = stylelowered!
end type

event modified;String	ls_modelcode, ls_modelname, ls_modelid, ls_pcserialno, ls_custcode
Integer	li_originalqty

if ii_truckorder = 0 then
	messagebox('확인', '출하 트럭 순번이 지정되지 않았습니다.')
	return
end if

if is_truckno = '' then
	messagebox('확인', '출하 트럭 번호가 지정되지 않았습니다.')
	return
end if
if dw_plan_read.rowcount() = 0  then
	messagebox('확인', '조회 후 간판을 Reading하세요.')
	return
end if

if (st_readqty.text = st_loadqty.text) and integer(st_loadqty.text) > 0  then
//	cb_save.enabled		= true
	messagebox('확 인', '출하제품의 수량이 모두 입력되었습니다.')
	return
end if

If wf_kbreading(This.Text) Then
	ib_change	= True
	if st_readqty.text = st_loadqty.text then
		messagebox('확 인', '상차수량과 Reading한 수량이 일치합니다.')
	ELSE
		THIS.TEXT = ''
		this.SetFocus()
	end if
Else
	THIS.TEXT = ''
	this.SetFocus()
End If

//if dw_shipkb_read.rowcount() > 0 Then
//	cb_del.enabled	= True
//Else
//	cb_del.enabled	= False
//End if
end event

type dw_update_tshipstatus1 from datawindow within w_piss130u
boolean visible = false
integer x = 2656
integer y = 1832
integer width = 411
integer height = 432
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_09"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_piss130u
boolean visible = false
integer x = 3099
integer y = 88
integer width = 457
integer height = 92
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "출고전표"
end type

type dw_update_tshipkbhis from datawindow within w_piss130u
boolean visible = false
integer x = 3104
integer y = 1812
integer width = 411
integer height = 432
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_11"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss130u
integer x = 23
integer y = 28
integer width = 2107
integer height = 172
integer taborder = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
end type

type gb_2 from groupbox within w_piss130u
integer x = 27
integer y = 216
integer width = 791
integer height = 260
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "차량정보"
end type

type gb_3 from groupbox within w_piss130u
integer x = 827
integer y = 216
integer width = 1056
integer height = 260
integer taborder = 210
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "간판번호"
end type

type gb_4 from groupbox within w_piss130u
integer x = 3145
integer y = 216
integer width = 878
integer height = 260
integer taborder = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "수량정보"
end type

type gb_5 from groupbox within w_piss130u
integer x = 2153
integer y = 28
integer width = 983
integer height = 172
integer taborder = 240
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "버튼정보"
end type

type gb_7 from groupbox within w_piss130u
integer x = 1893
integer y = 216
integer width = 1243
integer height = 260
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품명"
end type

type dw_plan_read from u_vi_std_datawindow within w_piss130u
integer x = 14
integer y = 520
integer width = 3529
integer height = 1964
integer taborder = 20
string dataobject = "d_piss130u_12"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;STRING ls_itemcode
if row > 0 then
	ls_itemcode = this.object.itemcode[row]
	wf_shipkb_read_filter(ls_itemcode)
end if	
end event

event retrieveend;call super::retrieveend;//int i,ln_shipeditno,ln_min = 100
//string ls_checksrno,ls_applyfrom,ls_before_date
//
//ls_before_date = mid(is_date,1,4) + mid(is_date,6,2) + mid(is_date,9,2)
//ls_before_date = String(RelativeDate(Date(String(ls_before_date,"@@@@-@@-@@")),-30),"yyyy.mm.dd")
//
//for i = 1 to rowcount
//	ln_shipeditno = this.object.shipeditno[i]
//	if mid(trim(this.object.checksrno[i]),3,1) = 'A' and &
//		( 	trim(this.object.custcode[i]) = 'L10500' or & 
//	   	trim(this.object.custcode[i]) = 'L10502' or &
//			trim(this.object.custcode[i]) = 'L11100' )  then	
//		if ln_min > ln_shipeditno then
//			ln_min = ln_shipeditno
//		end if
//	end if
//next
// 
//if ln_min <> 100 then
//	select 	isnull(applyfrom,''),isnull(shipeditno,0) into :ls_applyfrom,:ln_shipeditno from tsrorder
//	where		applyfrom = :is_date and shipendgubun = 'N' and shipremainqty > 0 and custcode in ( 'L10500','L10502','L11100' ) 
//				and substring(checksrno,3,1) = 'A' and shipeditno < :ln_min
//	union
//	select 	isnull(applyfrom,''),isnull(shipeditno,0)  from tsrorder
//	where  	applyfrom >= :ls_before_date and applyfrom < :is_date  and shipendgubun = 'N' and shipremainqty > 0 and custcode in ( 'L10500','L10502','L11100' ) 
//				and substring(checksrno,3,1) = 'A'
//	order by isnull(applyfrom,'') desc ,isnull(shipeditno,0) desc 
//	using sqlpis ;
//	if ls_applyfrom <> '' then
//   	messagebox("확인",string(ls_applyfrom) + "일자" + string(ln_shipeditno) + "편 S/R 정보가 " + "~r~n" + "아직 출하 미완료 상태입니다")
//	end if
//end if


end event

type dw_update_tshipsheet from datawindow within w_piss130u
boolean visible = false
integer x = 1166
integer y = 904
integer width = 2651
integer height = 584
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_truckno from singlelineedit within w_piss130u
integer x = 329
integer y = 364
integer width = 457
integer height = 80
integer taborder = 200
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15793151
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_piss130u
boolean visible = false
integer x = 2715
integer y = 232
integer width = 411
integer height = 432
integer taborder = 200
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_13"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_shipqty_check from datawindow within w_piss130u
boolean visible = false
integer x = 530
integer y = 936
integer width = 2958
integer height = 1028
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss130u_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_save from datawindow within w_piss130u
boolean visible = false
integer x = 1371
integer y = 900
integer width = 937
integer height = 840
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss220u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

