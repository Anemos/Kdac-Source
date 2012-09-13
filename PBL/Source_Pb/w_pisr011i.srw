$PBExportHeader$w_pisr011i.srw
$PBExportComments$간판품목검색( 자재이원화 업체 검색)
forward
global type w_pisr011i from window
end type
type st_4 from statictext within w_pisr011i
end type
type sle_area from singlelineedit within w_pisr011i
end type
type st_1 from statictext within w_pisr011i
end type
type sle_division from singlelineedit within w_pisr011i
end type
type pb_2 from picturebutton within w_pisr011i
end type
type pb_1 from picturebutton within w_pisr011i
end type
type dw_disp from u_vi_std_datawindow within w_pisr011i
end type
type st_3 from statictext within w_pisr011i
end type
type st_2 from statictext within w_pisr011i
end type
type sle_itemname from singlelineedit within w_pisr011i
end type
type sle_itemcode from singlelineedit within w_pisr011i
end type
type gb_2 from groupbox within w_pisr011i
end type
type gb_1 from groupbox within w_pisr011i
end type
end forward

global type w_pisr011i from window
integer width = 3954
integer height = 1976
boolean titlebar = true
string title = "간판품목검색"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
event ue_retrieve ( )
st_4 st_4
sle_area sle_area
st_1 st_1
sle_division sle_division
pb_2 pb_2
pb_1 pb_1
dw_disp dw_disp
st_3 st_3
st_2 st_2
sle_itemname sle_itemname
sle_itemcode sle_itemcode
gb_2 gb_2
gb_1 gb_1
end type
global w_pisr011i w_pisr011i

type variables
str_pisr_partkb istr_partkb
string 	is_searchkey, is_itemsubname
Boolean	ib_Open
end variables

event ue_retrieve();
IF is_searchkey = 'Not' THEN
	MessageBox( "입력오류" , "검색할 품번이나 품명을 입력하세요", Information! )
	return 
END IF

String 	ls_itemsubname

dw_disp.SetRedraw(False)
IF is_searchkey = 'No' THEN
	dw_disp.DataObject = "d_pisr011i_01"
	dw_disp.SetTransObject(Sqlpis)
	dw_disp.Retrieve( istr_partkb.areacode, istr_partkb.divcode, istr_partkb.itemcode ) 
ELSE
	ls_itemsubname = '%' + trim(is_itemsubname) + '%'
	dw_disp.DataObject = "d_pisr011i_02"
	dw_disp.SetTransObject(Sqlpis)
	dw_disp.Retrieve( istr_partkb.areacode, istr_partkb.divcode, ls_itemsubname ) 
END IF
dw_disp.SetRedraw(True)

end event

on w_pisr011i.create
this.st_4=create st_4
this.sle_area=create sle_area
this.st_1=create st_1
this.sle_division=create sle_division
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_disp=create dw_disp
this.st_3=create st_3
this.st_2=create st_2
this.sle_itemname=create sle_itemname
this.sle_itemcode=create sle_itemcode
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_4,&
this.sle_area,&
this.st_1,&
this.sle_division,&
this.pb_2,&
this.pb_1,&
this.dw_disp,&
this.st_3,&
this.st_2,&
this.sle_itemname,&
this.sle_itemcode,&
this.gb_2,&
this.gb_1}
end on

on w_pisr011i.destroy
destroy(this.st_4)
destroy(this.sle_area)
destroy(this.st_1)
destroy(this.sle_division)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_disp)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_itemname)
destroy(this.sle_itemcode)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;
f_pisc_win_center_move(this)

String	ls_sleText

f_pisc_win_center_move(this)		//POPUP 화면가운데 정렬

istr_partkb = Message.PowerObjectParm	//Argumant 받기 

  SELECT TMSTAREA.AreaName  
    INTO :ls_sleText  
    FROM TMSTAREA  
   WHERE TMSTAREA.AreaCode = :istr_partkb.areacode   
	USING	sqlpis	;
	
sle_area.Text = ls_sleText

  SELECT TMSTDIVISION.DivisionName  
    INTO :ls_sleText  
    FROM TMSTDIVISION  
   WHERE TMSTDIVISION.AreaCode 		= :istr_partkb.areacode AND  
         TMSTDIVISION.DivisionCode 	= :istr_partkb.divcode   
	USING	sqlpis	;

sle_division.Text = ls_sleText

end event

type st_4 from statictext within w_pisr011i
integer x = 69
integer y = 72
integer width = 169
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "지역:"
boolean focusrectangle = false
end type

type sle_area from singlelineedit within w_pisr011i
integer x = 247
integer y = 60
integer width = 320
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_pisr011i
integer x = 567
integer y = 72
integer width = 187
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "공장:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_division from singlelineedit within w_pisr011i
integer x = 754
integer y = 60
integer width = 384
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type pb_2 from picturebutton within w_pisr011i
integer x = 3470
integer y = 20
integer width = 443
integer height = 148
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
boolean originalsize = true
end type

event clicked;closewithreturn(parent,'')
end event

type pb_1 from picturebutton within w_pisr011i
integer x = 3003
integer y = 20
integer width = 443
integer height = 148
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
end type

event clicked;parent.TriggerEvent( "ue_retrieve" )
end event

type dw_disp from u_vi_std_datawindow within w_pisr011i
integer x = 9
integer y = 180
integer width = 3922
integer height = 1704
integer taborder = 40
string dataobject = "d_pisr011i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_3 from statictext within w_pisr011i
integer x = 1897
integer y = 68
integer width = 178
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "품명:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisr011i
integer x = 1207
integer y = 68
integer width = 178
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "품번:"
boolean focusrectangle = false
end type

type sle_itemname from singlelineedit within w_pisr011i
integer x = 2085
integer y = 60
integer width = 837
integer height = 72
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modified;is_itemsubname = this.Text

IF IsNull(is_itemsubname) or trim( is_itemsubname ) = '' THEN 
	is_searchkey = 'Not'
ELSE 
	is_searchkey = 'Name'
END IF

sle_itemcode.Text = ''

end event

type sle_itemcode from singlelineedit within w_pisr011i
integer x = 1381
integer y = 60
integer width = 434
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modified;String	ls_itemCode, ls_itemName 
Integer 	li_itemChk

ls_itemCode = this.Text 
	
IF IsNull(ls_itemCode) THEN
	is_searchkey = 'Name'
//ELSEIF len(ls_itemCode) <> 12 THEN
//	is_searchkey = 'Name'
//	MessageBox( "입력오류", "품번이 올바르지 않습니다.", StopSign! )
ELSE
  SELECT count(*)  
    INTO :li_itemChk  
    FROM TMSTPARTKB  
   WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode AND  
         TMSTPARTKB.DivisionCode	= :istr_partkb.divcode  AND  
         TMSTPARTKB.ItemCode 		= :ls_itemCode 
	USING	sqlpis	;
	IF li_itemChk > 0 THEN
//	IF f_pisr_partkbitemvalid( istr_partkb.areacode, istr_partkb.divcode, ls_itemCode ) THEN
		  SELECT TMSTITEM.ItemName  
			 INTO :ls_itemName  
			 FROM TMSTITEM  
			WHERE TMSTITEM.ItemCode = :ls_itemCode
			USING sqlpis	;
		is_searchkey = 'No'
		sle_itemname.Text 	= ls_itemName
		istr_partkb.itemcode = ls_itemCode
	ELSE
		is_searchkey = 'Not'
		setNull(ls_itemName)
		sle_itemname.Text 	= ls_itemName
		MessageBox( "입력오류", "품번이 올바르지 않거나 취급품목이 아닙니다.", StopSign! )
	END IF
END IF
end event

type gb_2 from groupbox within w_pisr011i
integer x = 1184
integer width = 1783
integer height = 164
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisr011i
integer x = 18
integer width = 1143
integer height = 164
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

