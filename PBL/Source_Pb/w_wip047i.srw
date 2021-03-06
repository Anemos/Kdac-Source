$PBExportHeader$w_wip047i.srw
$PBExportComments$품목별재공금액 기간별조회
forward
global type w_wip047i from w_ipis_sheet01
end type
type dw_wip047i_01 from datawindow within w_wip047i
end type
type pb_down from picturebutton within w_wip047i
end type
type rb_line from radiobutton within w_wip047i
end type
type rb_vendor from radiobutton within w_wip047i
end type
type rb_stock from radiobutton within w_wip047i
end type
type tab_work from tab within w_wip047i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_3 from userobject within tab_work
end type
type tabpage_3 from userobject within tab_work
end type
type tab_work from tab within w_wip047i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type dw_wip047i_02 from datawindow within w_wip047i
end type
type dw_wip047i_03 from datawindow within w_wip047i
end type
type cb_execute from commandbutton within w_wip047i
end type
type gb_1 from groupbox within w_wip047i
end type
end forward

global type w_wip047i from w_ipis_sheet01
integer width = 4087
integer height = 2552
dw_wip047i_01 dw_wip047i_01
pb_down pb_down
rb_line rb_line
rb_vendor rb_vendor
rb_stock rb_stock
tab_work tab_work
dw_wip047i_02 dw_wip047i_02
dw_wip047i_03 dw_wip047i_03
cb_execute cb_execute
gb_1 gb_1
end type
global w_wip047i w_wip047i

on w_wip047i.create
int iCurrent
call super::create
this.dw_wip047i_01=create dw_wip047i_01
this.pb_down=create pb_down
this.rb_line=create rb_line
this.rb_vendor=create rb_vendor
this.rb_stock=create rb_stock
this.tab_work=create tab_work
this.dw_wip047i_02=create dw_wip047i_02
this.dw_wip047i_03=create dw_wip047i_03
this.cb_execute=create cb_execute
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_wip047i_01
this.Control[iCurrent+2]=this.pb_down
this.Control[iCurrent+3]=this.rb_line
this.Control[iCurrent+4]=this.rb_vendor
this.Control[iCurrent+5]=this.rb_stock
this.Control[iCurrent+6]=this.tab_work
this.Control[iCurrent+7]=this.dw_wip047i_02
this.Control[iCurrent+8]=this.dw_wip047i_03
this.Control[iCurrent+9]=this.cb_execute
this.Control[iCurrent+10]=this.gb_1
end on

on w_wip047i.destroy
call super::destroy
destroy(this.dw_wip047i_01)
destroy(this.pb_down)
destroy(this.rb_line)
destroy(this.rb_vendor)
destroy(this.rb_stock)
destroy(this.tab_work)
destroy(this.dw_wip047i_02)
destroy(this.dw_wip047i_03)
destroy(this.cb_execute)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

tab_work.Width = newwidth - ( tab_work.x + 20 )
dw_wip047i_01.Width = newwidth	- (ls_gap * 5)
dw_wip047i_01.Height= newheight - (dw_wip047i_01.y + ls_status)

dw_wip047i_02.x = dw_wip047i_01.x
dw_wip047i_02.y = dw_wip047i_01.y
dw_wip047i_02.Width = dw_wip047i_01.Width
dw_wip047i_02.Height= dw_wip047i_01.Height

dw_wip047i_03.x = dw_wip047i_01.x
dw_wip047i_03.y = dw_wip047i_01.y
dw_wip047i_03.Width = dw_wip047i_01.Width
dw_wip047i_03.Height= dw_wip047i_01.Height
end event

event ue_retrieve;call super::ue_retrieve;string ls_plant, ls_dvsn, ls_iocd, ls_pdcd

dw_wip047i_01.reset()
dw_wip047i_02.reset()
dw_wip047i_03.reset()

if rb_line.checked then
	dw_wip047i_01.retrieve('1')
	dw_wip047i_02.retrieve('1')
	dw_wip047i_03.retrieve('1')
	
	uo_status.st_message.text = "조회되었습니다."
end if

if rb_vendor.checked then
	dw_wip047i_01.retrieve('2')
	dw_wip047i_02.retrieve('2')
	dw_wip047i_03.retrieve('2')
	
	uo_status.st_message.text = "조회되었습니다."
end if

if rb_stock.checked then
	dw_wip047i_01.retrieve('3')
	dw_wip047i_02.retrieve('3')
	dw_wip047i_03.retrieve('3')
	
	uo_status.st_message.text = "조회되었습니다."
end if

return 0
end event

event ue_postopen;call super::ue_postopen;dw_wip047i_01.settransobject(sqlca)
dw_wip047i_02.settransobject(sqlca)
dw_wip047i_03.settransobject(sqlca)
end event

type uo_status from w_ipis_sheet01`uo_status within w_wip047i
end type

type dw_wip047i_01 from datawindow within w_wip047i
integer x = 32
integer y = 376
integer width = 1189
integer height = 1308
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_wip047i_01_a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_down from picturebutton within w_wip047i
integer x = 1865
integer y = 40
integer width = 201
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_wip047i_01.rowcount() > 0 then
	f_save_to_excel(dw_wip047i_01)
else
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if
end event

type rb_line from radiobutton within w_wip047i
integer x = 110
integer y = 52
integer width = 329
integer height = 104
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "라인"
end type

event clicked;dw_wip047i_01.dataobject = 'd_wip047i_01_a'
dw_wip047i_01.settransobject(sqlca)

dw_wip047i_02.dataobject = 'd_wip047i_01_b'
dw_wip047i_02.settransobject(sqlca)

dw_wip047i_03.dataobject = 'd_wip047i_01_c'
dw_wip047i_03.settransobject(sqlca)
end event

type rb_vendor from radiobutton within w_wip047i
integer x = 549
integer y = 52
integer width = 329
integer height = 104
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "업체"
end type

event clicked;dw_wip047i_01.dataobject = 'd_wip047i_02_a'
dw_wip047i_01.settransobject(sqlca)

dw_wip047i_02.dataobject = 'd_wip047i_02_b'
dw_wip047i_02.settransobject(sqlca)

dw_wip047i_03.dataobject = 'd_wip047i_02_c'
dw_wip047i_03.settransobject(sqlca)
end event

type rb_stock from radiobutton within w_wip047i
integer x = 992
integer y = 52
integer width = 329
integer height = 104
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "창고"
end type

event clicked;dw_wip047i_01.dataobject = 'd_wip047i_03_a'
dw_wip047i_01.settransobject(sqlca)

dw_wip047i_02.dataobject = 'd_wip047i_03_b'
dw_wip047i_02.settransobject(sqlca)

dw_wip047i_03.dataobject = 'd_wip047i_03_c'
dw_wip047i_03.settransobject(sqlca)
end event

type tab_work from tab within w_wip047i
integer x = 23
integer y = 240
integer width = 3419
integer height = 124
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
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
tabpage_3 tabpage_3
end type

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;Choose Case newindex 
	Case 1
		dw_wip047i_01.Visible = True 
		dw_wip047i_02.Visible = False 
		dw_wip047i_03.Visible = False
	Case 2
		dw_wip047i_01.Visible = False 
		dw_wip047i_02.Visible = True 
		dw_wip047i_03.Visible = False
	Case 3
		dw_wip047i_01.Visible = False 
		dw_wip047i_02.Visible = False 
		dw_wip047i_03.Visible = True
End Choose 
end event

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 3383
integer height = -4
long backcolor = 12632256
string text = "공제전"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 3383
integer height = -4
long backcolor = 12632256
string text = "공제분"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 3383
integer height = -4
long backcolor = 12632256
string text = "공제후"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_wip047i_02 from datawindow within w_wip047i
integer x = 1285
integer y = 492
integer width = 1189
integer height = 1308
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_wip047i_01_b"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_wip047i_03 from datawindow within w_wip047i
integer x = 2551
integer y = 492
integer width = 1189
integer height = 1308
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_wip047i_01_c"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_execute from commandbutton within w_wip047i
integer x = 3077
integer y = 40
integer width = 763
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "재공취합자료생성"
end type

event clicked;
DELETE FROM PBWIP.WIP017
using sqlca;

// 라인재공 자재데이타 생성
INSERT INTO PBWIP.WIP017
( COMLTD,XPLANT,DIV,ITNO,ORCT,IOCD,
P00,P30,P60,P90,P120,P150,INPTID,INPTDT )
SELECT COMLTD, XPLANT, DIV, ITNO,'9999','1',
  SUM( CASE WHEN (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 30 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P00,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 30 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 60 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P30,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 60 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 90 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P60,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 90 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 120 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P90,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 120 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 150 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P120,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 150 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 365 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P150,'',''
  FROM PBINV.INV401
  WHERE COMLTD = '01' AND SLIPTYPE = 'IS' AND TDTE4 >= '20090601' AND SRCE <> '03' 
      AND CLS IN ('10','40','50')
      AND XUSE IN ('01','02','03','05','06') AND TQTY4 <> 0
  GROUP BY COMLTD, XPLANT, DIV, ITNO
using sqlca;

// 업체재공 자재데이타 생성
INSERT INTO PBWIP.WIP017
( COMLTD,XPLANT,DIV,ITNO,ORCT,IOCD,
P00,P30,P60,P90,P120,P150,INPTID,INPTDT )
SELECT COMLTD, XPLANT, DIV, ITNO, VSRNO, '2',
  SUM( CASE WHEN (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 30 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P00,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 30 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 60 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P30,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 60 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 90 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P60,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 90 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 120 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P90,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 120 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 150 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P120,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 150 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 365 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P150,'',''
  FROM PBINV.INV401
  WHERE COMLTD = '01' AND SLIPTYPE = 'IS' AND TDTE4 >= '20090601'
      AND CLS IN ('10','40','50')
      AND XUSE = '04' AND TQTY4 <> 0
		  AND SUBSTR(VSRNO,1,1) = 'D'
  GROUP BY COMLTD, XPLANT, DIV, ITNO, VSRNO
using sqlca;

// 창고재공 자재데이타 생성
INSERT INTO PBWIP.WIP017
( COMLTD,XPLANT,DIV,ITNO,ORCT,IOCD,
P00,P30,P60,P90,P120,P150,INPTID,INPTDT )
SELECT COMLTD, XPLANT, DIV, ITNO, '9999', '3',
  SUM( CASE WHEN (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 30 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P00,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 30 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 60 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P30,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 60 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 90 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P60,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 90 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 120 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P90,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 120 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 150 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P120,
  SUM( CASE WHEN (TDTE4 <= REPLACE(CHAR(DATE('2010-06-30') - 150 DAYS),'-','')) AND
        (TDTE4 > REPLACE(CHAR(DATE('2010-06-30') - 365 DAYS),'-',''))
       THEN TQTY4 ELSE 0 END ) AS P150,'',''
  FROM PBINV.INV401
  WHERE COMLTD = '01' AND SLIPTYPE = 'RP' AND TDTE4 >= '20090601'
      AND SRCE = '04' AND TQTY4 <> 0
  GROUP BY COMLTD, XPLANT, DIV, ITNO
using sqlca;
end event

type gb_1 from groupbox within w_wip047i
integer x = 23
integer y = 4
integer width = 3854
integer height = 192
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
end type

