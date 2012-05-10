$PBExportHeader$w_graph_change_r.srw
$PBExportComments$graph 변경
forward
global type w_graph_change_r from window
end type
type cb_cancel from commandbutton within w_graph_change_r
end type
type cb_ok from commandbutton within w_graph_change_r
end type
type tab_1 from tab within w_graph_change_r
end type
type tabpage_1 from userobject within tab_1
end type
type st_4 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type vsb_elevation from vscrollbar within tabpage_1
end type
type hsb_rotation from hscrollbar within tabpage_1
end type
type vsb_perspective from vscrollbar within tabpage_1
end type
type lv_1 from listview within tabpage_1
end type
type gr_1 from graph within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
vsb_elevation vsb_elevation
hsb_rotation hsb_rotation
vsb_perspective vsb_perspective
lv_1 lv_1
gr_1 gr_1
end type
type tab_1 from tab within w_graph_change_r
tabpage_1 tabpage_1
end type
end forward

global type w_graph_change_r from window
integer x = 832
integer y = 360
integer width = 2491
integer height = 1248
boolean titlebar = true
string title = "그래프 모양"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 78698728
event ue_ok ( )
event ue_cancel ( )
event ue_postopen ( )
cb_cancel cb_cancel
cb_ok cb_ok
tab_1 tab_1
end type
global w_graph_change_r w_graph_change_r

type variables
GRAPH 		igr_parm
DATAWINDOW 	idw_parm
OBJECT 		io_passed

BOOLEAN	ib_scatter = FALSE
end variables

forward prototypes
public subroutine wf_add_data_except_scatter (boolean ab_delete)
private subroutine wf_add_data_2_scatter (boolean ab_delete)
end prototypes

event ue_ok();LISTVIEWITEM		lvi_current
STRING				ls_type
INTEGER				li_index
BOOLEAN				lb_3dgraph = FALSE

li_index = tab_1.tabpage_1.lv_1.FindItem(1,DirectionAll!,TRUE,TRUE,FALSE,FALSE)
IF li_index > 0 THEN
	IF tab_1.tabpage_1.lv_1.GetItem(li_index, lvi_current) < 1 THEN
		Messagebox ("선택에러","지원하지 않는 형태입니다")
		RETURN
	END IF
		
	IF io_passed = Graph! THEN
		// Graph
		igr_parm.GraphType = tab_1.tabpage_1.gr_1.GraphType	
	ELSE
		// Datawindow
		ls_type = Trim(lvi_current.label)
		CHOOSE CASE ls_type
			CASE "3D 영역형"		//area3d			
				idw_parm.Modify ("gr_1.graphtype=15")		
				//3D
				lb_3dgraph = TRUE
			CASE "영역형"			//areagraph
				idw_parm.Modify ("gr_1.graphtype=1")			
			CASE "3D 가로"			//bar3dgraph
				idw_parm.Modify ("gr_1.graphtype=4")			
				lb_3dgraph = TRUE
			CASE "Solid Bar"		//bar3dobjgraph
				idw_parm.Modify ("gr_1.graphtype=6")			
			CASE "가로"				//bargraph
				idw_parm.Modify ("gr_1.graphtype=2")			
			CASE "Solid Stacked Bar"	//barstack3dobjgraph
				idw_parm.Modify ("gr_1.graphtype=3")			
			CASE "Stacked Bar"	//barstackgraph
				idw_parm.Modify ("gr_1.graphtype=5")			
			CASE "세로"				//colgraph
				idw_parm.Modify ("gr_1.graphtype=8")			
			CASE "3D 세로"			//col3dgraph
				idw_parm.Modify ("gr_1.graphtype=9")			
				lb_3dgraph = TRUE
			CASE "Solid Column"	//col3dobjgraph
				idw_parm.Modify ("gr_1.graphtype=7")			
			CASE "Solid Stacked Column"	//colstack3dobjgraph
				idw_parm.Modify ("gr_1.graphtype=11")			
			CASE "Stacked Column"	//colstackgraph
				idw_parm.Modify ("gr_1.graphtype=10")			
			CASE "3D 꺽은선"		//line3d
				idw_parm.Modify ("gr_1.graphtype=16")			
				lb_3dgraph = TRUE
			CASE "꺽은선"			//linegraph
				idw_parm.Modify ("gr_1.graphtype=12")			
			CASE "3D 원형"		//pie3d
				idw_parm.Modify ("gr_1.graphtype=17")			
				lb_3dgraph = TRUE
			CASE "원형"				//piegraph
				idw_parm.Modify ("gr_1.graphtype=13")			
			CASE "분산형"			//scattergraph
				idw_parm.Modify ("gr_1.graphtype=14")			
			CASE ELSE
				Messagebox ("선택에러","지원하지 않는 형태입니다")
				RETURN
		END CHOOSE
	END IF	
	//3D properity
	IF lb_3dgraph = TRUE THEN
		IF io_passed = Graph! THEN
			// Graph
			igr_parm.Perspective = tab_1.tabpage_1.gr_1.Perspective
			igr_parm.Elevation = tab_1.tabpage_1.gr_1.Elevation
			igr_parm.Rotation = tab_1.tabpage_1.gr_1.Rotation
		
		ELSE
			// Datawindow
			idw_parm.Modify( "gr_1.Perspective=" + String(tab_1.tabpage_1.gr_1.Perspective) )
			idw_parm.Modify( "gr_1.Elevation=" + String(tab_1.tabpage_1.gr_1.Elevation) )
			idw_parm.Modify( "gr_1.Rotation=" + String(tab_1.tabpage_1.gr_1.Rotation) )
		END IF	
	END IF
	
ELSE
	Messagebox ("선택에러","지원하지 않는 형태입니다")
	RETURN
END IF

CLOSE(THIS)
end event

event ue_cancel;Close(THIS)
end event

event ue_postopen;//TestData를 설정한다

IF ib_scatter THEN
	wf_add_data_except_scatter(FALSE)
ELSE
	wf_add_data_2_scatter(FALSE)
END IF

end event

public subroutine wf_add_data_except_scatter (boolean ab_delete);GRAPH		lgr_1

lgr_1 = tab_1.tabpage_1.gr_1

lgr_1.SetRedraw(FALSE)

IF ab_delete THEN
	lgr_1.DeleteSeries("A")
	lgr_1.DeleteSeries("B")
	lgr_1.DeleteSeries("C")	
END IF

//Add Series
lgr_1.AddSeries( "A" )
lgr_1.AddSeries( "B" )
lgr_1.AddSeries( "C" )

//Add Category
lgr_1.AddSeries( "1월" )
lgr_1.AddSeries( "2월" )
lgr_1.AddSeries( "3월" )

//Add Data
lgr_1.AddData( 1, 2 ,"1월")
lgr_1.AddData( 1, 5 ,"2월")
lgr_1.AddData( 1, 7 ,"3월")

lgr_1.AddData( 2, 5 ,"1월")
lgr_1.AddData( 2, 4 ,"2월")
lgr_1.AddData( 2, 7 ,"3월")

lgr_1.AddData( 3, 10 ,"1월")
lgr_1.AddData( 3, 9 ,"2월")
lgr_1.AddData( 3, 2 ,"3월")

lgr_1.SetRedraw(TRUE)
end subroutine

private subroutine wf_add_data_2_scatter (boolean ab_delete);GRAPH		lgr_1

lgr_1 = tab_1.tabpage_1.gr_1

lgr_1.SetRedraw(FALSE)

//Clear
IF ab_delete THEN
	lgr_1.DeleteSeries("A")
	lgr_1.DeleteSeries("B")
	lgr_1.DeleteSeries("C")	
	lgr_1.DeleteCategory(1)
	lgr_1.DeleteCategory(2)
	lgr_1.DeleteCategory(3)
	
END IF

//Add Series
lgr_1.AddSeries( "A" )
lgr_1.AddSeries( "B" )
lgr_1.AddSeries( "C" )

lgr_1.AddData( 1, 3, 2)
lgr_1.AddData( 1, 3, 4)
lgr_1.AddData( 1, 5, 6)

lgr_1.AddData( 2, 7, 5)
lgr_1.AddData( 2, 4, 4)
lgr_1.AddData( 2, 6, 6)

lgr_1.AddData( 3, 1, 10)
lgr_1.AddData( 3, 4, 2)
lgr_1.AddData( 3, 8, 3)

lgr_1.SetRedraw(TRUE)
end subroutine

on w_graph_change_r.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.tab_1=create tab_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.tab_1}
end on

on w_graph_change_r.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.tab_1)
end on

event open;// Receive and remember in the igr_parm or idw_parm instance variable, the
// object that has been passed by the window that opened this.
GRAPHICOBJECT	lgro_hold
INTEGER			li_index = 0
STRING			ls_type
LISTVIEWITEM	llvi_current
INTEGER		li_perspective
INTEGER		li_elevation
INTEGER		li_rotation

f_pisc_win_center_move(This)
lgro_hold = message.powerobjectparm

li_perspective = tab_1.tabpage_1.gr_1.perspective
li_elevation = tab_1.tabpage_1.gr_1.elevation
li_rotation = tab_1.tabpage_1.gr_1.rotation


IF lgro_hold.TypeOf() = Graph! THEN
	io_passed = Graph!
	igr_parm = message.powerobjectparm
	
	//현재의 상태표시
	tab_1.tabpage_1.gr_1.GraphType = igr_parm.GraphType
	CHOOSE CASE igr_parm.GraphType
		CASE area3d!
			li_index = 7
		CASE areagraph!
			li_index = 1
		CASE bar3dgraph!
			li_index = 8
		CASE bar3dobjgraph!
			li_index = 14
		CASE bargraph!
			li_index = 2
		CASE barstack3dobjgraph!
			li_index = 16
		CASE barstackgraph!
			li_index = 12
		CASE colgraph!
			li_index = 3
		CASE col3dgraph!
			li_index = 9
		CASE col3dobjgraph!
			li_index = 15
		CASE colstack3dobjgraph!
			li_index = 17
		CASE colstackgraph!
			li_index = 13
		CASE line3d!
			li_index = 10
		CASE linegraph!
			li_index = 4
		CASE pie3d!
			li_index = 11
		CASE piegraph!
			li_index = 5
		CASE scattergraph!
			//
			ib_scatter = TRUE
			li_index = 6
	END CHOOSE

	li_perspective = igr_parm.Perspective
	li_elevation = igr_parm.Elevation
	li_Rotation = igr_parm.Rotation	
	
ELSEIF lgro_hold.TypeOf() = Datawindow! THEN
	io_passed = Datawindow!
	idw_parm = message.powerobjectparm
	ls_type = idw_parm.Describe("gr_1.graphtype")
	CHOOSE CASE ls_type
		CASE "15"		//area3d
			tab_1.tabpage_1.gr_1.GraphType = area3d!
			li_index = 7
		CASE "1"			//areagraph
			tab_1.tabpage_1.gr_1.GraphType = areagraph!
			li_index = 1
		CASE "4"			//"3D 가로"			//bar3dgraph
			tab_1.tabpage_1.gr_1.GraphType = bar3dgraph!
			li_index = 8
		CASE "6"			//"Solid Bar"		//bar3dobjgraph
			tab_1.tabpage_1.gr_1.GraphType = bar3dobjgraph!
			li_index = 14
		CASE "2"			//"가로"				//bargraph
			tab_1.tabpage_1.gr_1.GraphType = bargraph!
			li_index = 2
		CASE "3"			//"Solid Stacked Bar"	//barstack3dobjgraph
			tab_1.tabpage_1.gr_1.GraphType = barstack3dobjgraph!
			li_index = 16
		CASE "5"			//"Stacked Bar"	//barstackgraph
			tab_1.tabpage_1.gr_1.GraphType = barstackgraph!
			li_index = 12
		CASE "8"			//"세로"				//colgraph
			tab_1.tabpage_1.gr_1.GraphType = colgraph!
			li_index = 3
		CASE "9"			//"3D 세로"			//col3dgraph
			tab_1.tabpage_1.gr_1.GraphType = col3dgraph!
			li_index = 9
		CASE "7"			//"Solid Column"	//col3dobjgraph
			tab_1.tabpage_1.gr_1.GraphType = col3dobjgraph!
			li_index = 15
		CASE "11"		//"Solid Stacked Column"	//colstack3dobjgraph
			tab_1.tabpage_1.gr_1.GraphType = colstack3dobjgraph!
			li_index = 17
		CASE "10"		//"Stacked Column"	//colstackgraph
			tab_1.tabpage_1.gr_1.GraphType = colstackgraph!
			li_index = 13
		CASE "16"		//"3D 꺽은선"		//line3d
			tab_1.tabpage_1.gr_1.GraphType = line3d!
			li_index = 10
		CASE "12"		//"꺽은선"			//linegraph
			tab_1.tabpage_1.gr_1.GraphType = linegraph!
			li_index = 4
		CASE "17"		//"3D 원형"		//pie3d
			tab_1.tabpage_1.gr_1.GraphType = pie3d!
			li_index = 11
		CASE "13"		//"원형"				//piegraph
			tab_1.tabpage_1.gr_1.GraphType = piegraph!
			li_index = 5
		CASE "14"		//"분산형"			//scattergraph
			ib_scatter = TRUE			
			tab_1.tabpage_1.gr_1.GraphType = scattergraph!
			li_index = 6
	END CHOOSE	
	
	li_perspective = Integer(idw_parm.Describe("gr_1.perspective"))
	li_elevation = Integer(idw_parm.Describe("gr_1.elevation"))
	li_Rotation = Integer(idw_parm.Describe("gr_1.Rotation"))
END IF

//Set Focus
IF li_index > 0  THEN
	IF tab_1.tabpage_1.lv_1.GetItem(li_index, llvi_current) <> -1 THEN
		llvi_current.Selected = TRUE
		llvi_current.HasFocus = TRUE
		//Set Item
		tab_1.tabpage_1.lv_1.SetItem(li_index , llvi_current)	
	END IF
END IF

//Set ScrollBar
tab_1.tabpage_1.vsb_perspective.Position = li_perspective
tab_1.tabpage_1.vsb_elevation.Position = li_elevation
tab_1.tabpage_1.hsb_rotation.Position = li_rotation

Post Event ue_postopen()


end event

type cb_cancel from commandbutton within w_graph_change_r
integer x = 1472
integer y = 1004
integer width = 347
integer height = 108
integer taborder = 4
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취소(&C)"
boolean cancel = true
end type

event clicked;PARENT.TriggerEvent( "ue_cancel" )
end event

type cb_ok from commandbutton within w_graph_change_r
integer x = 704
integer y = 1004
integer width = 347
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "확인(&O)"
boolean default = true
end type

event clicked;PARENT.TriggerEvent( "ue_ok" )
end event

type tab_1 from tab within w_graph_change_r
integer x = 18
integer y = 16
integer width = 2427
integer height = 964
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 78698728
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2391
integer height = 836
long backcolor = 78698728
string text = "Graph"
long tabtextcolor = 33554432
long tabbackcolor = 78698728
string picturename = "Graph!"
long picturemaskcolor = 12632256
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
vsb_elevation vsb_elevation
hsb_rotation hsb_rotation
vsb_perspective vsb_perspective
lv_1 lv_1
gr_1 gr_1
end type

on tabpage_1.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.vsb_elevation=create vsb_elevation
this.hsb_rotation=create hsb_rotation
this.vsb_perspective=create vsb_perspective
this.lv_1=create lv_1
this.gr_1=create gr_1
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.vsb_elevation,&
this.hsb_rotation,&
this.vsb_perspective,&
this.lv_1,&
this.gr_1}
end on

on tabpage_1.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.vsb_elevation)
destroy(this.hsb_rotation)
destroy(this.vsb_perspective)
destroy(this.lv_1)
destroy(this.gr_1)
end on

type st_4 from statictext within tabpage_1
integer x = 1513
integer y = 732
integer width = 530
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 78698728
boolean enabled = false
string text = "좌우회전(Rotation)"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_1
integer x = 1856
integer y = 72
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 78698728
boolean enabled = false
string text = "앞뒤회전(Elevation)"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_1
integer x = 1138
integer y = 68
integer width = 530
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 78698728
boolean enabled = false
string text = "원근(Perspective)"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_1
integer x = 32
integer y = 68
integer width = 311
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 78698728
boolean enabled = false
string text = "Graph모양"
boolean focusrectangle = false
end type

type vsb_elevation from vscrollbar within tabpage_1
integer x = 2190
integer y = 140
integer width = 73
integer height = 516
integer maxposition = 360
integer position = 180
end type

event moved;//앞뒤회전각을 바꾼다 
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Elevation = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event linedown;//앞뒤회전각을 바꾼다 
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Elevation = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event lineup;//앞뒤회전각을 바꾼다 
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Elevation = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event pagedown;//앞뒤회전각을 바꾼다 
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Elevation = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event pageup;//앞뒤회전각을 바꾼다 
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Elevation = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

type hsb_rotation from hscrollbar within tabpage_1
integer x = 1303
integer y = 656
integer width = 887
integer height = 64
integer maxposition = 360
integer position = 200
end type

event moved;tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Rotation = THIS.Position - 180
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event lineleft;INTEGER		li_pos

li_pos = THIS.Position
li_pos = li_pos - 5
IF li_pos < THIS.MinPosition THEN
	li_pos = THIS.MinPosition
END IF
THIS.Position = li_pos

tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Rotation = THIS.Position - 180
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event lineright;INTEGER		li_pos

li_pos = THIS.Position
li_pos = li_pos + 5
IF li_pos > THIS.MaxPosition THEN
	li_pos = THIS.MaxPosition
END IF
THIS.Position = li_pos

tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Rotation = THIS.Position - 180
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event pageleft;INTEGER		li_pos

li_pos = THIS.Position
li_pos = li_pos - 30
IF li_pos < THIS.MinPosition THEN
	li_pos = THIS.MinPosition
END IF
THIS.Position = li_pos

tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Rotation = THIS.Position - 180
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event pageright;INTEGER		li_pos

li_pos = THIS.Position
li_pos = li_pos + 30
IF li_pos > THIS.MaxPosition THEN
	li_pos = THIS.MaxPosition
END IF
THIS.Position = li_pos

tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Rotation = THIS.Position - 180
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

type vsb_perspective from vscrollbar within tabpage_1
integer x = 1239
integer y = 140
integer width = 73
integer height = 516
integer maxposition = 100
end type

event moved;//원근치를 바꾼다
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Perspective = scrollpos
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event linedown;//원근치를 바꾼다
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Perspective = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event lineup;//원근치를 바꾼다
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Perspective = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event pagedown;//원근치를 바꾼다
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Perspective = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

event pageup;//원근치를 바꾼다
tab_1.tabpage_1.gr_1.SetRedraw(FALSE)
tab_1.tabpage_1.gr_1.Perspective = THIS.Position
tab_1.tabpage_1.gr_1.SetRedraw(TRUE)
end event

type lv_1 from listview within tabpage_1
integer x = 18
integer y = 140
integer width = 1120
integer height = 568
integer taborder = 2
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean hideselection = false
string item[] = {"영역형","가로","세로","꺽은선","원형","분산형","3D 영역형","3D 가로","3D 세로","3D 꺽은선","3D 원형","Stacked Bar","Stacked Column","Solid Bar","Solid Column","Solid Stacked Bar","Solid Stacked Column"}
integer itempictureindex[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17}
string largepicturename[] = {".\resource\gt_area.bmp",".\resource\gt_bar.bmp",".\resource\gt_col.bmp",".\resource\gt_line.bmp",".\resource\gt_pie.bmp",".\resource\gt_scat.bmp",".\resource\gt_area3d.bmp",".\resource\gt_bar3d.bmp",".\resource\gt_col3d.bmp",".\resource\gt_line3d.bmp",".\resource\gt_pie3d.bmp",".\resource\gt_barstack.bmp",".\resource\gt_colstack.bmp",".\resource\gt_barsolid.bmp",".\resource\gt_colsolid.bmp",".\resource\gt_barstacksolid.bmp",".\resource\gt_colstacksolid.bmp"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 16777215
string smallpicturename[] = {"Custom039!"}
integer smallpicturewidth = 16
integer smallpictureheight = 16
long smallpicturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

event itemchanged;LISTVIEWITEM		llvi_current
STRING				ls_type

IF index > 0 THEN
	IF THIS.GetItem(index, llvi_current) < 1 THEN
		RETURN
	END IF
	//
	ls_type = Trim(llvi_current.label)
	CHOOSE CASE ls_type
		CASE "3D 영역형"		//area3d
			tab_1.tabpage_1.gr_1.GraphType = Area3D!
		CASE "영역형"			//areagraph
			tab_1.tabpage_1.gr_1.GraphType = AreaGraph!
		CASE "3D 가로"			//bar3dgraph
			tab_1.tabpage_1.gr_1.GraphType = Bar3dGraph!
		CASE "Solid Bar"		//bar3dobjgraph
			tab_1.tabpage_1.gr_1.GraphType = Bar3dObjGraph!
		CASE "가로"				//bargraph
			tab_1.tabpage_1.gr_1.GraphType = BarGraph!
		CASE "Solid Stacked Bar"	//barstack3dobjgraph
			tab_1.tabpage_1.gr_1.GraphType = BarStack3dObjGraph!
		CASE "Stacked Bar"	//barstackgraph
			tab_1.tabpage_1.gr_1.GraphType = BarStackGraph!
		CASE "세로"				//colgraph
			tab_1.tabpage_1.gr_1.GraphType = ColGraph!
		CASE "3D 세로"			//col3dgraph
			tab_1.tabpage_1.gr_1.GraphType = Col3dGraph!
		CASE "Solid Column"	//col3dobjgraph
			tab_1.tabpage_1.gr_1.GraphType = Col3dObjGraph!
		CASE "Solid Stacked Column"	//colstack3dobjgraph
			tab_1.tabpage_1.gr_1.GraphType = ColStack3dObjGraph!
		CASE "Stacked Column"	//colstackgraph
			tab_1.tabpage_1.gr_1.GraphType = ColStackGraph!
		CASE "3D 꺽은선"		//line3d
			tab_1.tabpage_1.gr_1.GraphType = Line3D!
		CASE "꺽은선"			//linegraph
			tab_1.tabpage_1.gr_1.GraphType = LineGraph!
		CASE "3D 원형"		//pie3d
			tab_1.tabpage_1.gr_1.GraphType = Pie3D!
		CASE "원형"				//piegraph
			tab_1.tabpage_1.gr_1.GraphType = PieGraph!
		CASE "분산형"			//scattergraph
			tab_1.tabpage_1.gr_1.GraphType = ScatterGraph!
		CASE ELSE
			RETURN
	END CHOOSE
END IF

IF ib_scatter AND tab_1.tabpage_1.gr_1.GraphType <> ScatterGraph! THEN
	ib_scatter = FALSE
	wf_add_data_except_scatter(TRUE)
ELSEIF ib_scatter = FALSE AND tab_1.tabpage_1.gr_1.GraphType = ScatterGraph! THEN
	ib_scatter = TRUE
	wf_add_data_2_scatter(TRUE)
END IF
	
end event

type gr_1 from graph within tabpage_1
integer x = 1307
integer y = 144
integer width = 896
integer height = 516
boolean enabled = false
grgraphtype graphtype = bar3dgraph!
long backcolor = 16777215
long shadecolor = 8355711
integer spacing = 50
string title = "(None)"
integer elevation = 20
integer rotation = -20
integer perspective = 2
integer depth = 100
grlegendtype legend = atbottom!
boolean focusrectangle = false
grsorttype seriessort = ascending!
grsorttype categorysort = ascending!
end type

on gr_1.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="Arial"
TitleDispAttr.FontCharSet=DefaultCharSet!
TitleDispAttr.FontFamily=Swiss!
TitleDispAttr.FontPitch=Variable!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=536870912
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
TitleDispAttr.AutoSize=true
Category.Label="(None)"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="Arial"
Category.DispAttr.FontCharSet=DefaultCharSet!
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Right!
Category.DispAttr.BackColor=536870912
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="Arial"
Category.LabelDispAttr.FontCharSet=DefaultCharSet!
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=536870912
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Category.LabelDispAttr.Escapement=900
Values.Label="(None)"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="Arial"
Values.DispAttr.FontCharSet=DefaultCharSet!
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Center!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="Arial"
Values.LabelDispAttr.FontCharSet=DefaultCharSet!
Values.LabelDispAttr.FontFamily=Swiss!
Values.LabelDispAttr.FontPitch=Variable!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=536870912
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Series.Label="(None)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="Arial"
Series.DispAttr.FontCharSet=DefaultCharSet!
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="Arial"
Series.LabelDispAttr.FontCharSet=DefaultCharSet!
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=536870912
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="Arial"
LegendDispAttr.FontCharSet=DefaultCharSet!
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=536870912
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression="series"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="Arial"
PieDispAttr.FontCharSet=DefaultCharSet!
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=536870912
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on gr_1.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

