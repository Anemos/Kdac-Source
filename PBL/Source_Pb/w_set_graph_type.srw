$PBExportHeader$w_set_graph_type.srw
forward
global type w_set_graph_type from window
end type
type cb_3 from commandbutton within w_set_graph_type
end type
type cb_2 from commandbutton within w_set_graph_type
end type
type sle_y from singlelineedit within w_set_graph_type
end type
type st_2 from statictext within w_set_graph_type
end type
type cb_1 from commandbutton within w_set_graph_type
end type
type sle_x from singlelineedit within w_set_graph_type
end type
type st_x from statictext within w_set_graph_type
end type
type st_1 from statictext within w_set_graph_type
end type
type p_gallery from picture within w_set_graph_type
end type
type cb_set_graphtype from commandbutton within w_set_graph_type
end type
type cb_18 from commandbutton within w_set_graph_type
end type
type sle_title from singlelineedit within w_set_graph_type
end type
type st_title from statictext within w_set_graph_type
end type
type gb_3 from groupbox within w_set_graph_type
end type
type mle_1 from multilineedit within w_set_graph_type
end type
type gb_1 from groupbox within w_set_graph_type
end type
end forward

global type w_set_graph_type from window
integer x = 1723
integer y = 496
integer width = 1915
integer height = 1916
boolean titlebar = true
string title = "±×·¡ÇÁ Style ¼³Á¤"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cb_3 cb_3
cb_2 cb_2
sle_y sle_y
st_2 st_2
cb_1 cb_1
sle_x sle_x
st_x st_x
st_1 st_1
p_gallery p_gallery
cb_set_graphtype cb_set_graphtype
cb_18 cb_18
sle_title sle_title
st_title st_title
gb_3 gb_3
mle_1 mle_1
gb_1 gb_1
end type
global w_set_graph_type w_set_graph_type

type variables
string is_GraphType

integer ii_col, ii_row
datawindow idw
end variables

on w_set_graph_type.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.sle_y=create sle_y
this.st_2=create st_2
this.cb_1=create cb_1
this.sle_x=create sle_x
this.st_x=create st_x
this.st_1=create st_1
this.p_gallery=create p_gallery
this.cb_set_graphtype=create cb_set_graphtype
this.cb_18=create cb_18
this.sle_title=create sle_title
this.st_title=create st_title
this.gb_3=create gb_3
this.mle_1=create mle_1
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.sle_y,&
this.st_2,&
this.cb_1,&
this.sle_x,&
this.st_x,&
this.st_1,&
this.p_gallery,&
this.cb_set_graphtype,&
this.cb_18,&
this.sle_title,&
this.st_title,&
this.gb_3,&
this.mle_1,&
this.gb_1}
end on

on w_set_graph_type.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.sle_y)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.sle_x)
destroy(this.st_x)
destroy(this.st_1)
destroy(this.p_gallery)
destroy(this.cb_set_graphtype)
destroy(this.cb_18)
destroy(this.sle_title)
destroy(this.st_title)
destroy(this.gb_3)
destroy(this.mle_1)
destroy(this.gb_1)
end on

event open;str_sort str_param

//str_param = Message.PowerObjectParm
//
//idw = str_param.ldw
//		
//this.move(str_param.ll_x, str_param.ll_y)

this.SetPosition(TopMost!)
end event

type cb_3 from commandbutton within w_set_graph_type
integer x = 1577
integer y = 1496
integer width = 247
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = "Àû¿ë(&Y)"
end type

event clicked;idw.object.gr_1.values.label = sle_y.text
end event

type cb_2 from commandbutton within w_set_graph_type
integer x = 1577
integer y = 1388
integer width = 247
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = "Àû¿ë(&X)"
end type

event clicked;idw.object.gr_1.category.label = sle_x.text

end event

type sle_y from singlelineedit within w_set_graph_type
integer x = 265
integer y = 1492
integer width = 1312
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 32567536
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_set_graph_type
integer x = 69
integer y = 1496
integer width = 174
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "°ª:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_set_graph_type
integer x = 704
integer y = 1676
integer width = 480
integer height = 108
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = "´Ý±â"
boolean cancel = true
boolean default = true
end type

event clicked;close(parent)
end event

type sle_x from singlelineedit within w_set_graph_type
integer x = 265
integer y = 1384
integer width = 1312
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 32567536
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_x from statictext within w_set_graph_type
integer x = 69
integer y = 1404
integer width = 174
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "¹üÁÖ:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_set_graph_type
boolean visible = false
integer x = 27
integer y = 1060
integer width = 201
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "none"
alignment alignment = center!
end type

type p_gallery from picture within w_set_graph_type
integer x = 27
integer y = 44
integer width = 1792
integer height = 992
string picturename = "pic/grgallry.bmp"
end type

event clicked;// Clicked script for P_GALLERY

Constant Integer		iCOLWIDTH = 287, iROWHEIGHT = 308
Integer	li_X, li_Y, li_TextX, li_TextY
String	ls_Title, &
			ls_Titles1[6] = {"Area", "Bar", "Column", "Line", "Pie", "Scatter"}, &
			ls_Titles3[6] = {"Bar", "Column", "Bar", "Column", "Bar", "Column"}, &
			ls_GraphType[6,3] = { &
				"areagraph","bargraph","colgraph","linegraph","piegraph","scattergraph",&
				"area3d","bar3dgraph","col3dgraph","line3d","pie3d","error",&
				"barstackgraph","colstackgraph","bar3dobjgraph","col3dobjgraph",&
				"barstack3dobjgraph","colstack3dobjgraph"}						

li_X = This.PointerX()
li_Y = This.PointerY()
If li_X < 25 or li_X > 1747 or li_Y < 30 or li_Y > 954 Then
	st_1.Hide()
	Beep(1)
	Return
End If

ii_Col = ((li_X - 25) / iCOLWIDTH) + 1
ii_Row = ((li_Y - 30) / iROWHEIGHT) + 1

If ii_Row = 3 Then
	ls_Title = ls_Titles3[ii_Col]
Else
	ls_Title = ls_Titles1[ii_Col]
End If

li_TextY = (ii_Row * iROWHEIGHT) + ((ii_Row - 1) * 10)

st_1.Text = ls_Title
li_TextX = This.x + ((ii_Col - 1) * iCOLWIDTH) + 75
li_TextY = li_TextY - This.y

st_1.Hide ()
If ii_Row = 2 And ii_Col = 6 Then
	Beep (1)			// Only 5 entries in Row 2 (no 3D Scatter)
Else
	st_1.Move (li_TextX, li_TextY)
	st_1.Show ()
End If

is_GraphType = ls_GraphType[ii_Col, ii_Row]

end event

event doubleclicked;cb_set_graphtype.TriggerEvent(clicked!)
end event

type cb_set_graphtype from commandbutton within w_set_graph_type
integer x = 1161
integer y = 1056
integer width = 667
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = "Graph &Style Àû¿ë"
end type

event clicked;// ¸ðµç µ¥ÀÌÅÍÀÇ graph object´Â gr_1ÀÌ¶ó´Â °¡Á¤
// ÄÚµùÇÒ¶§ default·Î ºÎ¿©µÈ ÀÌ¸§

choose case is_graphtype
	case 'area3d'
		idw.object.gr_1.GraphType = 15 // Area3D!
	case 'areagraph'
		idw.object.gr_1.GraphType = 1 // AreaGraph!
	case 'bar3dgraph'
		idw.object.gr_1.GraphType = 3 // Bar3dGraph!
	case 'bar3dobjgraph'
		idw.object.gr_1.GraphType = 4 // Bar3dObjGraph!
	case 'bargraph'
		idw.object.gr_1.GraphType = 2 // BarGraph!
	case 'barstack3dobjgraph'
		idw.object.gr_1.GraphType = 6 // BarStack3dObjGraph!
	case 'barstackgraph'
		idw.object.gr_1.GraphType = 5 // BarStackGraph!
	case 'colgraph'
		idw.object.gr_1.GraphType = 7 // ColGraph!
	case 'col3dgraph'
		idw.object.gr_1.GraphType = 8 // Col3dGraph!
	case 'col3dobjgraph'
		idw.object.gr_1.GraphType = 9 // Col3dObjGraph!
	case 'colstack3dobjgraph'
		idw.object.gr_1.GraphType = 11 // ColStack3dObjGraph!
	case 'colstackgraph'
		idw.object.gr_1.GraphType = 10 // ColStackGraph!
	case 'line3d'
		idw.object.gr_1.GraphType = 16 // Line3D!
	case 'linegraph'
		idw.object.gr_1.GraphType = 12 // LineGraph!
	case 'pie3d'
		idw.object.gr_1.GraphType = 17 // Pie3D!
	case 'piegraph'
		idw.object.gr_1.GraphType = 13 // PieGraph!
	case 'scattergraph'
		idw.object.gr_1.GraphType = 14 // ScatterGraph!
end choose		

end event

type cb_18 from commandbutton within w_set_graph_type
integer x = 1577
integer y = 1272
integer width = 247
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = "Àû¿ë(&T)"
end type

event clicked;idw.object.gr_1.title = sle_title.text

end event

type sle_title from singlelineedit within w_set_graph_type
integer x = 265
integer y = 1272
integer width = 1312
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 32567536
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_title from statictext within w_set_graph_type
integer x = 50
integer y = 1292
integer width = 197
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "±×·¡ÇÁ:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_set_graph_type
integer x = 5
integer y = 1200
integer width = 1838
integer height = 432
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 67108864
string text = "Title"
borderstyle borderstyle = stylelowered!
end type

type mle_1 from multilineedit within w_set_graph_type
integer x = 14
integer y = 36
integer width = 1815
integer height = 1008
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_set_graph_type
integer x = 5
integer width = 1838
integer height = 1172
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

