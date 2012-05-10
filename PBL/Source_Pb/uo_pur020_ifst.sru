$PBExportHeader$uo_pur020_ifst.sru
$PBExportComments$가로-물성분류체계(물성/대/중분류/소분류)
forward
global type uo_pur020_ifst from userobject
end type
type dw_thd from datawindow within uo_pur020_ifst
end type
type st_thd from statictext within uo_pur020_ifst
end type
type st_snd from statictext within uo_pur020_ifst
end type
type st_fst from statictext within uo_pur020_ifst
end type
type dw_snd from datawindow within uo_pur020_ifst
end type
type dw_fst from datawindow within uo_pur020_ifst
end type
type dw_inl from datawindow within uo_pur020_ifst
end type
type st_inl from statictext within uo_pur020_ifst
end type
end forward

global type uo_pur020_ifst from userobject
integer width = 4210
integer height = 108
boolean border = true
long backcolor = 12632256
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event ue_constructor ( string ag_gubun )
dw_thd dw_thd
st_thd st_thd
st_snd st_snd
st_fst st_fst
dw_snd dw_snd
dw_fst dw_fst
dw_inl dw_inl
st_inl st_inl
end type
global uo_pur020_ifst uo_pur020_ifst

type variables
string i_s_gubun 
DataWindowChild idwc_inl, idwc_fst, idwc_snd , idwc_thd


end variables

forward prototypes
public function string uf_get_inl ()
public function string uf_get_snd ()
public function string uf_get_thd ()
public function string uf_get_fst ()
public function string uf_get_ifst ()
end prototypes

event ue_constructor(string ag_gubun);//////////////////////////////////////////////
//                구분 : 0 간접재
//                       1 업무지원
/////////////////////////////////////////////

DataWindowChild ldwc_inl, ldwc_fst, ldwc_snd

// 초기화
dw_inl.reset()
dw_fst.reset()
dw_snd.reset()
dw_thd.reset()

i_s_gubun = ag_gubun
//----------- 물성분류 ---------- 
dw_inl.getchild("bjdesc",idwc_inl)
idwc_inl.settransobject(sqlca)

if idwc_inl.retrieve(i_s_gubun) < 1 then
	messagebox("자료없슴!", "물성분류DATA가 한건도 없습니다.")
	return
end if
dw_inl.InsertRow(0)

//----------대분류--------------
dw_fst.getchild("bjdesc",idwc_fst)
idwc_fst.settransobject(sqlca)

dw_fst.visible = false
st_fst.visible   = false
//----------중분류--------------
dw_snd.getchild("bjdesc",idwc_snd)
idwc_snd.settransobject(sqlca)

dw_snd.visible = false
st_snd.visible   = false
//----------소분류--------------
dw_thd.getchild("bjdesc",idwc_thd)
idwc_thd.settransobject(sqlca)

dw_thd.visible = false
st_thd.visible   = false

end event

public function string uf_get_inl ();//물성분류
string ls_inl
dw_inl.Accepttext()
ls_inl = trim(dw_inl.GetText())
return ls_inl
end function

public function string uf_get_snd ();//중분류
string ls_snd
dw_snd.Accepttext()
ls_snd = trim(dw_snd.GetText())
return ls_snd
end function

public function string uf_get_thd ();//소분류
string ls_thd
dw_thd.Accepttext()
ls_thd = trim(dw_thd.GetText())
return ls_thd
end function

public function string uf_get_fst ();//대분류
string ls_fst
dw_fst.Accepttext()
ls_fst = trim(dw_fst.GetText())
return ls_fst
end function

public function string uf_get_ifst ();string ls_inl ,ls_fst, ls_snd, ls_thd ,ls_ifst

//물성분류
dw_inl.Accepttext()
ls_inl = trim(dw_inl.GetText())
//대분류
dw_fst.Accepttext()
ls_fst = trim(dw_fst.GetText())
//중분류
dw_snd.Accepttext()
ls_snd = trim(dw_snd.GetText())
//소분류
dw_thd.Accepttext()
ls_thd = trim(dw_thd.GetText())

ls_ifst =ls_inl + ls_fst + ls_snd + ls_thd

return ls_ifst
end function

on uo_pur020_ifst.create
this.dw_thd=create dw_thd
this.st_thd=create st_thd
this.st_snd=create st_snd
this.st_fst=create st_fst
this.dw_snd=create dw_snd
this.dw_fst=create dw_fst
this.dw_inl=create dw_inl
this.st_inl=create st_inl
this.Control[]={this.dw_thd,&
this.st_thd,&
this.st_snd,&
this.st_fst,&
this.dw_snd,&
this.dw_fst,&
this.dw_inl,&
this.st_inl}
end on

on uo_pur020_ifst.destroy
destroy(this.dw_thd)
destroy(this.st_thd)
destroy(this.st_snd)
destroy(this.st_fst)
destroy(this.dw_snd)
destroy(this.dw_fst)
destroy(this.dw_inl)
destroy(this.st_inl)
end on

event constructor;//DataWindowChild ldwc_inl, ldwc_fst, ldwc_snd
//
////----------- 물성분류 ----------
//dw_inl.getchild("bjdesc",idwc_inl)
//idwc_inl.settransobject(sqlca)
//
//i_s_gubun = '1'
//if idwc_inl.retrieve('1') < 1 then
//	messagebox("자료없슴!", "물성분류DATA가 한건도 없습니다.")
//	return
//end if
//dw_inl.InsertRow(0)
//
////----------대분류--------------
//dw_fst.getchild("bjdesc",idwc_fst)
//idwc_fst.settransobject(sqlca)
//
//dw_fst.visible = false
//st_2.visible   = false
////----------중분류--------------
//dw_snd.getchild("bjdesc",idwc_snd)
//idwc_snd.settransobject(sqlca)
//
//dw_snd.visible = false
//st_3.visible   = false
////----------소분류--------------
//dw_thd.getchild("bjdesc",idwc_thd)
//idwc_thd.settransobject(sqlca)
//
//dw_thd.visible = false
//st_4.visible   = false
//
end event

type dw_thd from datawindow within uo_pur020_ifst
integer x = 3310
integer width = 878
integer height = 96
integer taborder = 10
string dataobject = "d_pur010_ifst04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;dw_inl.AcceptText()
dw_fst.AcceptText()
dw_snd.AcceptText()
dw_thd.AcceptText()

string ls_inl ,ls_fst, ls_snd, ls_thd

//----------- 물성분류 --------
ls_inl  = idwc_inl.getitemstring(idwc_inl.getrow(), "inl")
dw_inl.insertrow(0)
//----------- 대분류 ---------
ls_fst = idwc_fst.getitemstring(idwc_fst.getrow(), "fst")
dw_fst.insertrow(0)
//----------- 중분류 ---------
ls_snd = idwc_snd.getitemstring(idwc_snd.getrow(), "snd")
dw_snd.insertrow(0)
//----------- 소분류 ---------
ls_thd = idwc_snd.getitemstring(idwc_thd.getrow(), "thd")
dw_thd.insertrow(0)




end event

event itemfocuschanged;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event getfocus;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event losefocus;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

type st_thd from statictext within uo_pur020_ifst
integer x = 3200
integer y = 24
integer width = 96
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "소"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_snd from statictext within uo_pur020_ifst
integer x = 2199
integer y = 24
integer width = 96
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "중"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_fst from statictext within uo_pur020_ifst
integer x = 1175
integer y = 24
integer width = 96
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "대"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_snd from datawindow within uo_pur020_ifst
integer x = 2304
integer width = 878
integer height = 96
integer taborder = 30
string dataobject = "d_pur010_ifst03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string l_s_inl, l_s_fst, l_s_snd
//초기화
dw_thd.reset()
//----------- 물성분류 --------
l_s_inl  = idwc_inl.getitemstring(idwc_inl.getrow(), "inl")
dw_inl.insertrow(0)
//----------- 대분류 ---------
l_s_fst = idwc_fst.getitemstring(idwc_fst.getrow(), "fst")
dw_fst.insertrow(0)
//----------- 중분류 ---------
l_s_snd = idwc_snd.getitemstring(idwc_snd.getrow(), "snd")
dw_snd.insertrow(0)
//----------- 소분류 ---------
if idwc_thd.retrieve(l_s_inl,l_s_fst,l_s_snd,i_s_gubun) <= 0 then
	dw_thd.visible = false
	st_thd.visible   = false
	return 0
Else	
	dw_thd.visible = true
	st_thd.visible = true	
	dw_thd.InsertRow(0)	
End IF


end event

event getfocus;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event itemfocuschanged;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event losefocus;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

type dw_fst from datawindow within uo_pur020_ifst
integer x = 1275
integer width = 878
integer height = 96
integer taborder = 20
string dataobject = "d_pur010_ifst02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string l_s_inl, l_s_fst
//초기화
dw_snd.reset()
dw_thd.reset()
//----------- 물성분류 --------
l_s_inl  = idwc_inl.getitemstring(idwc_inl.getrow(), "inl")
dw_inl.insertrow(0)

//----------- 대분류 ---------
l_s_fst = idwc_fst.getitemstring(idwc_fst.getrow(), "fst")
dw_fst.insertrow(0)
//----------- 중분류 ---------
if idwc_snd.retrieve(l_s_inl,l_s_fst,i_s_gubun) <= 0 then
	dw_snd.visible = false
	st_snd.visible   = false
	return 0
Else
	dw_snd.visible =True
	st_snd.visible =True
	dw_snd.InsertRow(0)
	
	dw_thd.visible = false
	st_thd.visible = false
End IF


end event

event itemfocuschanged;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event losefocus;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event getfocus;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

type dw_inl from datawindow within uo_pur020_ifst
integer x = 279
integer width = 878
integer height = 96
integer taborder = 10
string dataobject = "d_pur010_ifst01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string l_s_inl
// 초기화
dw_fst.reset()
dw_snd.reset()
dw_thd.reset()
//----------- 물성분류 --------
l_s_inl = idwc_inl.getitemstring(idwc_inl.getrow(), "inl")
//----------- 대분류 ---------
if idwc_fst.retrieve(l_s_inl,i_s_gubun) <= 0 then
	st_fst.visible   = false
	dw_fst.visible = false	
	return 0
Else
	// 대분류
	st_fst.visible = true
	dw_fst.visible = true
	
	dw_fst.insertrow(0)
	
	// 중분류
	st_snd.visible   = false
	dw_snd.visible = false
	
	// 소분류
	st_thd.visible   = false
	dw_thd.visible = false
End IF

	
end event

event getfocus;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event itemfocuschanged;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event losefocus;//f_kor_eng_toggle( handle(This), 'KOR' )
//f_kor_eng_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

type st_inl from statictext within uo_pur020_ifst
integer y = 24
integer width = 274
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "물성분류"
alignment alignment = right!
boolean focusrectangle = false
end type

