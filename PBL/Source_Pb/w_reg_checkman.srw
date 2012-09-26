$PBExportHeader$w_reg_checkman.srw
$PBExportComments$실사담당자 등록
forward
global type w_reg_checkman from window
end type
type cb_init from commandbutton within w_reg_checkman
end type
type cb_close from commandbutton within w_reg_checkman
end type
type cb_save from commandbutton within w_reg_checkman
end type
type dw_1 from datawindow within w_reg_checkman
end type
type gb_1 from groupbox within w_reg_checkman
end type
end forward

global type w_reg_checkman from window
integer width = 3790
integer height = 1576
boolean titlebar = true
string title = "제품군별 실사인원 등록"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_init cb_init
cb_close cb_close
cb_save cb_save
dw_1 dw_1
gb_1 gb_1
end type
global w_reg_checkman w_reg_checkman

type variables
string is_year, is_month, is_plant, is_dvsn
end variables

on w_reg_checkman.create
this.cb_init=create cb_init
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_init,&
this.cb_close,&
this.cb_save,&
this.dw_1,&
this.gb_1}
end on

on w_reg_checkman.destroy
destroy(this.cb_init)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;string ls_parm

dw_1.settransobject(sqlca)
ls_parm = message.stringparm

is_year = mid(ls_parm,1,4)
is_month = mid(ls_parm,5,2)
is_plant = mid(ls_parm,7,1)
is_dvsn = mid(ls_parm,8,1)

dw_1.retrieve(is_year,is_month,g_s_company,is_plant,is_dvsn)

end event

type cb_init from commandbutton within w_reg_checkman
integer x = 997
integer y = 1340
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "초기화"
end type

event clicked;
DELETE FROM "PBWIP"."WIP010"  
   WHERE ( "PBWIP"."WIP010"."WHYEAR" = :is_year ) AND  
         ( "PBWIP"."WIP010"."WHMONTH" = :is_month ) AND  
         ( "PBWIP"."WIP010"."WHCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP010"."WHPLANT" = :is_plant ) AND  
         ( "PBWIP"."WIP010"."WHDVSN" = :is_dvsn )   
using sqlca;

messagebox("확인", "초기화되었습니다.")
dw_1.retrieve(is_year,is_month,g_s_company,is_plant,is_dvsn)
end event

type cb_close from commandbutton within w_reg_checkman
integer x = 1993
integer y = 1340
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_reg_checkman
integer x = 1504
integer y = 1340
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;long ll_rowcnt, ll_curcnt
string ls_empt, ls_empm, ls_empb, ls_orct, ls_charge, ls_dept, ls_branch
string ls_emptnm, ls_empmnm, ls_empbnm, ls_parm
dwItemStatus l_status

setpointer(hourglass!)
dw_1.accepttext()
ll_rowcnt = dw_1.rowcount()

for ll_curcnt = 1 to ll_rowcnt
	l_status = dw_1.GetItemStatus(ll_curcnt, 0, Primary!)
//	choose case l_status
//		case DataModified!
//			messagebox("chk","DataModified!")
//		case New!	
//			messagebox("chk","New!")
//		case NewModified!	
//			messagebox("chk","NewModified!")	
//		case NotModified!	
//			messagebox("chk","NotModified!")
//	end choose
	if l_status <> DataModified! then
		continue
	end if
	ls_orct = dw_1.getitemstring(ll_curcnt,"wip006_wfdept")
	ls_charge = dw_1.getitemstring(ll_curcnt,"wip010_whcharge")
	if f_spacechk(ls_charge) = -1 then
		ls_charge = ''
	end if
	ls_dept = dw_1.getitemstring(ll_curcnt,"wip010_whdept")
	if f_spacechk(ls_dept) = -1 then
		ls_dept = ''
	end if
	ls_branch = dw_1.getitemstring(ll_curcnt,"wip010_whbranch")
	if f_spacechk(ls_branch) = -1 then
		ls_branch = ''
	end if
	ls_empt = dw_1.getitemstring(ll_curcnt,"wip010_whempt")
	if f_spacechk(ls_empt) = -1 then
		ls_empt = ' '
		ls_emptnm = ' '
	else
		if len(ls_empt) = 6 then
			SELECT PENAMEK INTO :ls_emptnm
			FROM PBCOMMON.DAC003
			WHERE PEEMPNO = :ls_empt using sqlca;
			
			if sqlca.sqlcode <> 0 then
				if sqlca.sqlcode <> 0 then
					ls_empt = ' '
					ls_emptnm = ' '
				end if
			end if
		else
			openwithparm(w_reg_checkman , ls_empt)
			ls_empt = message.stringparm
			if f_spacechk(ls_empt) = -1 then
				ls_empt = ' '
				ls_emptnm = ' '
			end if
		end if
	end if
	ls_empm = dw_1.getitemstring(ll_curcnt,"wip010_whempm")
	if f_spacechk(ls_empm) = -1 then
		ls_empm = ' '
		ls_empmnm = ' '
	else
		if len(ls_empm) = 6 then
			SELECT PENAMEK INTO :ls_empmnm
			FROM PBCOMMON.DAC003
			WHERE PEEMPNO = :ls_empm using sqlca;
			if sqlca.sqlcode <> 0 then
				ls_empm = ' '
				ls_empmnm = ' '
			end if
		else
			openwithparm(w_reg_checkman , ls_empm)
			ls_empm = message.stringparm
			if f_spacechk(ls_empm) = -1 then
				ls_empt = ' '
				ls_emptnm = ' '
			end if
		end if
	end if
	ls_empb = dw_1.getitemstring(ll_curcnt,"wip010_whempb")
	if f_spacechk(ls_empb) = -1 then
		ls_empb = ' '
		ls_empbnm = ' '
	else
		if len(ls_empb) = 6 then
			SELECT PENAMEK INTO :ls_empbnm
			FROM PBCOMMON.DAC003
			WHERE PEEMPNO = :ls_empb using sqlca;
			if sqlca.sqlcode <> 0 then
				ls_empb = ' '
				ls_empbnm = ' '
			end if
		else
			openwithparm(w_reg_checkman , ls_empb)
			ls_empb = message.stringparm
			if f_spacechk(ls_empb) = -1 then
				ls_empt = ' '
				ls_emptnm = ' '
			end if
		end if
	end if
	
	UPDATE "PBWIP"."WIP010"  
     SET "WHCHARGE" = :ls_charge,   
         "WHDEPT" = :ls_dept,   
         "WHBRANCH" = :ls_branch,
			"WHEMPT" = :ls_empt,   
         "WHEMPTNM" = :ls_emptnm,   
         "WHEMPM" = :ls_empm,   
         "WHEMPMNM" = :ls_empmnm,   
         "WHEMPB" = :ls_empb,   
         "WHEMPBNM" = :ls_empbnm,   
         "WHUPDTID" = :g_s_empno,   
         "WHUPDTDT" = :g_s_date  
	WHERE "PBWIP"."WIP010"."WHYEAR" = :is_year AND
			"PBWIP"."WIP010"."WHMONTH" = :is_month AND
			"PBWIP"."WIP010"."WHCMCD" = :g_s_company AND
			"PBWIP"."WIP010"."WHPLANT" = :is_plant AND
			"PBWIP"."WIP010"."WHDVSN" = :is_dvsn AND
			"PBWIP"."WIP010"."WHORCT" = :ls_orct
	using sqlca;
	
	if sqlca.sqlcode = 0 and sqlca.sqlnrows > 0 then
		//pass
	else
		INSERT INTO "PBWIP"."WIP010"  
		( "WHYEAR", "WHMONTH", "WHCMCD", "WHPLANT", "WHDVSN", "WHORCT", 
		  "WHCHARGE", "WHDEPT", "WHBRANCH", "WHEMPT",   
		  "WHEMPTNM", "WHEMPM", "WHEMPMNM", "WHEMPB","WHEMPBNM", "WHIPADDR",   
		  "WHMACADDR", "WHINPTDT", "WHUPDTID", "WHUPDTDT" )  
		VALUES (:is_year,:is_month,:g_s_company,:is_plant,:is_dvsn,:ls_orct,
		  :ls_charge, :ls_dept, :ls_branch, :ls_empt,
		  :ls_emptnm,:ls_empm,:ls_empmnm,:ls_empb,:ls_empbnm,:g_s_ipaddr,
		  :g_s_macaddr,:g_s_date,:g_s_empno,:g_s_date)  
		using sqlca;
		if sqlca.sqlcode <> 0 then
			messagebox("Error","오류가 발생했습니다. : " + sqlca.sqlerrtext)
			return -1
		end if
	end if
next

messagebox("확인", "저장되었습니다.")
dw_1.retrieve(is_year,is_month,g_s_company,is_plant,is_dvsn)
end event

type dw_1 from datawindow within w_reg_checkman
integer x = 27
integer y = 24
integer width = 3698
integer height = 1280
integer taborder = 10
string title = "none"
string dataobject = "d_reg_checkman"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_reg_checkman
integer x = 923
integer y = 1300
integer width = 1545
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

