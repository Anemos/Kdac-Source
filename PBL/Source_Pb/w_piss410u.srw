$PBExportHeader$w_piss410u.srw
$PBExportComments$생관SR취소관리
forward
global type w_piss410u from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss410u
end type
type uo_division from u_pisc_select_division within w_piss410u
end type
type uo_area from u_pisc_select_area within w_piss410u
end type
type st_8 from statictext within w_piss410u
end type
type uo_scustgubun from u_pisc_select_code within w_piss410u
end type
type uo_custcode from u_piss_select_custcode within w_piss410u
end type
type dw_2 from u_vi_std_datawindow within w_piss410u
end type
type st_v_bar from uo_xc_splitbar within w_piss410u
end type
type gb_1 from groupbox within w_piss410u
end type
end forward

global type w_piss410u from w_ipis_sheet01
integer width = 4517
integer height = 2700
string title = "생관SR취소관리"
event ue_postopen ( )
dw_sheet dw_sheet
uo_division uo_division
uo_area uo_area
st_8 st_8
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
dw_2 dw_2
st_v_bar st_v_bar
gb_1 gb_1
end type
global w_piss410u w_piss410u

type variables
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,  is_mod[],is_custgubun
string is_shipoemgubun,is_areacode,is_divisioncode
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
end variables

forward prototypes
public function boolean wf_update_tsrcancel ()
end prototypes

event ue_postopen;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
string ls_codegroup,ls_codegroupname,ls_codename,ls_custname

f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
dw_sheet.reset()

end event

public function boolean wf_update_tsrcancel ();long ll_count,i,ll_cnt
string ls_srcancelgubun,ls_srno,ls_checksrno,ls_itemcode
string ls_pcgubun,ls_kitgubun,ls_confirmdate
boolean lb_commit
lb_commit = true
ls_confirmdate = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

ll_count = dw_sheet.rowcount()
for i = 1 to ll_count step 1
	ls_srcancelgubun = dw_sheet.object.srcancelgubun[i]
	if ls_srcancelgubun = 'Y' then
      ls_checksrno = dw_sheet.object.checksrno[i]
		update tsrorder
		   set srcancelgubun = 'Y',
	          lastemp = 'Y',
				 lastdate = getdate()
		 where areacode = :is_areacode
		   and divisioncode = :is_divisioncode
			and checksrno like :ls_checksrno
			using sqlpis;
		if sqlpis.sqlcode <> 0 then
		   uo_status.st_message.text = "tsrorder update error : " + sqlpis.sqlerrtext
			lb_commit = false
			exit
		end if
		select count(*)
		  into :ll_cnt
		  from tsrconfirm02_interface
		  where srno         = :ls_checksrno
		    and areacode     = :is_areacode
			 and divisioncode = :is_divisioncode
		  using sqlpis;
		ll_cnt = ll_cnt + 1
		INSERT INTO TSRCONFIRM02_INTERFACE  
                ( ConfirmDate,SRNo,SeqNo,
			         MISFlag,InterfaceFlag,AreaCode,DivisionCode,   
                  LastEmp,LastDate )  
         VALUES ( :ls_confirmdate,:ls_checksrno,:ll_cnt,   
                  'A','Y',:is_areacode,:is_divisioncode,   
                  :g_s_empno,getdate() ) 
		    using sqlpis;

		if sqlpis.sqlcode <> 0 then
		   uo_status.st_message.text = "tsrconfirm02_interface insert error : " + sqlpis.sqlerrtext
			lb_commit = false
			exit
		end if
	end if
next
return true

end function

on w_piss410u.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_division=create uo_division
this.uo_area=create uo_area
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.dw_2=create dw_2
this.st_v_bar=create st_v_bar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.uo_scustgubun
this.Control[iCurrent+6]=this.uo_custcode
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.st_v_bar
this.Control[iCurrent+9]=this.gb_1
end on

on w_piss410u.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.dw_2)
destroy(this.st_v_bar)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, LEFT)
of_resize_register(st_v_bar, SPLIT)
of_resize_register(dw_2, RIGHT)

of_resize()
end event

event ue_retrieve;setpointer(hourglass!)
dw_2.reset()
dw_sheet.retrieve(is_areacode,is_divisioncode,is_custcode)
setpointer(arrow!)
if dw_sheet.rowcount() = 0 then
	messagebox("확인","조회할 자료가 없읍니다.")
	return
end if	

end event

event ue_save;call super::ue_save;setpointer(hourglass!)
sqlpis.autocommit = false
if wf_update_tsrcancel() then
	commit using sqlpis;
   sqlpis.autocommit= true
	messagebox("확인","작업이 완료되었읍니다.")
else
	rollback using sqlpis;
	sqlpis.autocommit= true
end if

setpointer(arrow!)
postevent('ue_retrieve')

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)


end event

type uo_status from w_ipis_sheet01`uo_status within w_piss410u
end type

type dw_sheet from u_vi_std_datawindow within w_piss410u
integer x = 18
integer y = 224
integer width = 2400
integer height = 2252
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss410u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;string ls_checksrno
if row > 0 then
	ls_checksrno = dw_sheet.object.checksrno[row]
	dw_2.retrieve(is_areacode,is_divisioncode,is_custcode,ls_checksrno)
end if	
end event

type uo_division from u_pisc_select_division within w_piss410u
integer x = 672
integer y = 100
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)

is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
dw_2.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss410u
integer x = 59
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

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
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type st_8 from statictext within w_piss410u
integer x = 1367
integer y = 108
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "거래처구분"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_piss410u
integer x = 1714
integer y = 96
integer width = 709
integer taborder = 70
boolean bringtotop = true
end type

event constructor;call super::constructor;//postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
dw_sheet.reset()
dw_2.reset()
end event

event ue_post_constructor;string ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

type uo_custcode from u_piss_select_custcode within w_piss410u
integer x = 2574
integer y = 104
integer taborder = 80
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
dw_sheet.reset()
dw_2.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

type dw_2 from u_vi_std_datawindow within w_piss410u
integer x = 2478
integer y = 228
integer width = 1984
integer height = 2252
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_piss410u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type st_v_bar from uo_xc_splitbar within w_piss410u
integer x = 2427
integer y = 228
integer width = 18
boolean bringtotop = true
integer textsize = -9
end type

event constructor;call super::constructor;of_register(dw_sheet,LEFT)
of_register(dw_2,RIGHT)
end event

type gb_1 from groupbox within w_piss410u
integer x = 23
integer y = 28
integer width = 4421
integer height = 184
integer taborder = 50
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

