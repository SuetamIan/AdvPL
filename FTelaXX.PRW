#Include "PROTHEUS.CH"
//--------------------------------------------------------------
/*/{Protheus.doc} FTelaXX
Description                                                     
                                                                
@param xParam Parameter Description                             
@return xRet Return Description                                 
@author  -                                               
@since 16/02/2022                                                   
/*/                                                             
//--------------------------------------------------------------
User Function FTelaXX()                        
Local oGet1                       
Local cGet1 := "Define variable value"
Local oGet2
Local cGet2 := "Define variable value"
Local oGet3
Local cGet3 := "Define variable value"
Local oSay1
Local oSay2
Static oDlg

rpcsettype(3)
rpcsetenv("99","01")

  DEFINE MSDIALOG oDlg TITLE "New Dialog" FROM 000, 000  TO 500, 700 COLORS 0, 16777215 PIXEL

    @ -071, -105 MSGET oGet1 VAR cGet1 SIZE 691, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 061, 064 MSGET oGet2 VAR cGet2 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 049, 064 SAY oSay1 PROMPT "oSay1" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 060, 161 MSGET oGet3 VAR cGet3 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 048, 161 SAY oSay2 PROMPT "oSay1" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    fWBrowse1()
    fWBrowse2()

  ACTIVATE MSDIALOG oDlg CENTERED

Return

//------------------------------------------------ 
Static Function fWBrowse1()
//------------------------------------------------ 
Local oWBrowse1
Local aWBrowse1 := {}

    // Insert items here 
    Aadd(aWBrowse1,{"item","codigo","descrição","quantidade","vl unit","total"})
    Aadd(aWBrowse1,{"item","codigo","descrição","quantidade","vl unit","total"})

    @ 090, 005 LISTBOX oWBrowse1 Fields HEADER "item","codigo","descrição","quantidade","vl unit","total" SIZE 148, 121 OF oDlg PIXEL ColSizes 50,50
    oWBrowse1:SetArray(aWBrowse1)
    oWBrowse1:bLine := {|| {;
      aWBrowse1[oWBrowse1:nAt,1],;
      aWBrowse1[oWBrowse1:nAt,2],;
      aWBrowse1[oWBrowse1:nAt,3],;
      aWBrowse1[oWBrowse1:nAt,4],;
      aWBrowse1[oWBrowse1:nAt,5],;
      aWBrowse1[oWBrowse1:nAt,6];
    }}
    // DoubleClick event
    oWBrowse1:bLDblClick := {|| aWBrowse1[oWBrowse1:nAt,1] := !aWBrowse1[oWBrowse1:nAt,1],;
      oWBrowse1:DrawSelect()}

Return

//------------------------------------------------ 
Static Function fWBrowse2()
//------------------------------------------------ 
Local oWBrowse2
Local aWBrowse2 := {}

    // Insert items here 
    Aadd(aWBrowse2,{"item","codigo","descrição","quantidade","vl unit","total"})
    Aadd(aWBrowse2,{"item","codigo","descrição","quantidade","vl unit","total"})

    @ 089, 162 LISTBOX oWBrowse2 Fields HEADER "item","codigo","descrição","quantidade","vl unit","total" SIZE 160, 123 OF oDlg PIXEL ColSizes 50,50
    oWBrowse2:SetArray(aWBrowse2)
    oWBrowse2:bLine := {|| {;
      aWBrowse2[oWBrowse2:nAt,1],;
      aWBrowse2[oWBrowse2:nAt,2],;
      aWBrowse2[oWBrowse2:nAt,3],;
      aWBrowse2[oWBrowse2:nAt,4],;
      aWBrowse2[oWBrowse2:nAt,5],;
      aWBrowse2[oWBrowse2:nAt,6];
    }}
    // DoubleClick event
    oWBrowse2:bLDblClick := {|| aWBrowse2[oWBrowse2:nAt,1] := !aWBrowse2[oWBrowse2:nAt,1],;
      oWBrowse2:DrawSelect()}

Return
