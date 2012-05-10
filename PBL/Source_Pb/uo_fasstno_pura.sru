$PBExportHeader$uo_fasstno_pura.sru
$PBExportComments$고정자산분류체계 선택
forward
global type uo_fasstno_pura from userobject
end type
type dw_lvl3 from datawindow within uo_fasstno_pura
end type
type st_4 from statictext within uo_fasstno_pura
end type
type st_3 from statictext within uo_fasstno_pura
end type
type st_2 from statictext within uo_fasstno_pura
end type
type dw_lvl2 from datawindow within uo_fasstno_pura
end type
type dw_lvl1 from datawindow within uo_fasstno_pura
end type
type dw_acc from datawindow within uo_fasstno_pura
end type
type st_1 from statictext within uo_fasstno_pura
end type
end forward

global type uo_fasstno_pura from userobject
integer width = 3479
integer height = 128
boolean border = true
long backcolor = 12632256
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_lvl3 dw_lvl3
st_4 st_4
st_3 st_3
st_2 st_2
dw_lvl2 dw_lvl2
dw_lvl1 dw_lvl1
dw_acc dw_acc
st_1 st_1
end type
global uo_fasstno_pura uo_fasstno_pura

type variables
Private:
DataWindowChild idwc_inl, idwc_fst, idwc_snd , idwc_thd

end variables

forward prototypes
public subroutine uf_set_snd (string ag_snd)
end prototypes

public subroutine uf_set_snd (string ag_snd);ag_snd = Trim(ag_snd)

IF Len(ag_snd) <= 0 Then Return
dw_lvl2.SetItem(1,"filvl2",ag_snd)

string l_s_inl, l_s_fst, l_s_snd
dw_lvl3.reset()

l_s_inl = idwc_inl.getitemstring(idwc_inl.getrow(), "fiid")
l_s_fst = idwc_fst.getitemstring(idwc_fst.getrow(), "filvl1")
l_s_snd = idwc_snd.getitemstring(idwc_snd.getrow(), "filvl2")

dw_lvl2.Enabled = False
if idwc_thd.retrieve(l_s_inl,l_s_fst,l_s_snd) <= 0 then
	dw_lvl3.visible = false
	st_4.visible    = false	
Else	
	dw_lvl3.visible = true
	st_4.visible    = true	
	dw_lvl3.InsertRow(0)	
End IF
end subroutine

on uo_fasstno_pura.create
this.dw_lvl3=create dw_lvl3
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_lvl2=create dw_lvl2
this.dw_lvl1=create dw_lvl1
this.dw_acc=create dw_acc
this.st_1=create st_1
this.Control[]={this.dw_lvl3,&
this.st_4,&
this.st_3,&
this.st_2,&
this.dw_lvl2,&
this.dw_lvl1,&
this.dw_acc,&
this.st_1}
end on

on uo_fasstno_pura.destroy
destroy(this.dw_lvl3)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_lvl2)
destroy(this.dw_lvl1)
destroy(this.dw_acc)
destroy(this.st_1)
end on

event constructor;//계정(물성분류)
dw_acc.getchild("fiid", idwc_inl)
idwc_inl.settransobject(sqlca)

if idwc_inl.retrieve() < 1 then
	messagebox("자료없슴!", "고정자산체계 DATA 가 한건도 없습니다.")
	return
end if
dw_acc.InsertRow(0)
//dw_acc.Object.fiid[1] = 'F'
dw_acc.SetItem(1,"fiid","F")
dw_acc.Enabled = False

//----------대분류--------------
dw_lvl1.getchild("filvl1", idwc_fst)
idwc_fst.settransobject(sqlca)
idwc_fst.Retrieve("F")
dw_lvl1.InsertRow(0)
dw_lvl1.SetItem(1,"filvl1","6")

dw_lvl1.Enabled = False
//dw_lvl1.visible = false
//st_2.visible   = false
//----------중분류--------------
dw_lvl2.getchild("filvl2", idwc_snd)
idwc_snd.settransobject(sqlca)
idwc_snd.Retrieve("F","6")
dw_lvl2.InsertRow(0)

//dw_lvl2.visible = false
//st_3.visible   = false
//----------소분류--------------
dw_lvl3.getchild("filvl3", idwc_thd)
idwc_thd.settransobject(sqlca)

dw_lvl3.visible = false
st_4.visible   = false
end event

type dw_lvl3 from datawindow within uo_fasstno_pura
integer x = 2624
integer y = 8
integer width = 795
integer height = 96
integer taborder = 10
string dataobject = "dddw_filvl3_ext_pura"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within uo_fasstno_pura
integer x = 2546
integer y = 28
integer width = 69
integer height = 48
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "소"
boolean focusrectangle = false
end type

type st_3 from statictext within uo_fasstno_pura
integer x = 1650
integer y = 28
integer width = 69
integer height = 48
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "중"
boolean focusrectangle = false
end type

type st_2 from statictext within uo_fasstno_pura
integer x = 686
integer y = 28
integer width = 73
integer height = 48
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "대"
boolean focusrectangle = false
end type

type dw_lvl2 from datawindow within uo_fasstno_pura
integer x = 1723
integer y = 8
integer width = 795
integer height = 96
integer taborder = 30
string dataobject = "dddw_filvl2_ext_pura"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string l_s_inl, l_s_fst, l_s_snd

dw_lvl3.reset()

l_s_inl = idwc_inl.getitemstring(idwc_inl.getrow(), "fiid")

l_s_fst = idwc_fst.getitemstring(idwc_fst.getrow(), "filvl1")

l_s_snd = idwc_snd.getitemstring(idwc_snd.getrow(), "filvl2")

if idwc_thd.retrieve(l_s_inl,l_s_fst,l_s_snd) <= 0 then
	dw_lvl3.visible = false
	st_4.visible    = false
	return 0
Else	
	dw_lvl3.visible = true
	st_4.visible    = true	
	dw_lvl3.InsertRow(0)	
End IF
end event

type dw_lvl1 from datawindow within uo_fasstno_pura
integer x = 763
integer y = 8
integer width = 850
integer height = 96
integer taborder = 20
string dataobject = "dddw_filvl1_ext_pura"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string l_s_inl, l_s_fst

dw_lvl2.reset()
dw_lvl3.reset()

l_s_inl = idwc_inl.getitemstring(idwc_inl.getrow(), "fiid")

l_s_fst = idwc_fst.getitemstring(idwc_fst.getrow(), "filvl1")

if idwc_snd.retrieve(l_s_inl,l_s_fst) <= 0 then
	dw_lvl2.visible = false
	st_3.visible    = false
	return 0
Else
	dw_lvl2.visible =True
	st_3.visible    =True
	dw_lvl2.InsertRow(0)
End IF

dw_lvl3.visible = false
st_4.visible = false
end event

type dw_acc from datawindow within uo_fasstno_pura
integer x = 178
integer y = 8
integer width = 466
integer height = 96
integer taborder = 10
string dataobject = "dddw_fiid_ext_pura"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string l_s_inl

dw_lvl1.reset()
dw_lvl2.reset()
dw_lvl3.reset()

l_s_inl  = idwc_inl.getitemstring(idwc_inl.getrow(), "fiid")

if idwc_fst.retrieve(l_s_inl) <= 0 then
	st_2.visible    = false
	dw_lvl1.visible = false	
	return 0
Else
	st_2.visible    = true
	dw_lvl1.visible = true
	dw_lvl1.insertrow(0)
End IF

st_3.visible    = false
dw_lvl2.visible = false

st_4.visible    = false
dw_lvl3.visible = false
end event

type st_1 from statictext within uo_fasstno_pura
integer x = 5
integer y = 28
integer width = 174
integer height = 48
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "계 정"
boolean focusrectangle = false
end type

