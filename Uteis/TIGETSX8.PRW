#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

User Function TIGETSX8()

    Local aEmps := {}
    Local aTabs := {{"CXK", "CXK_NUMERO"}}
    Local nX    := 0
    Local nY    := 0

    RpcClearEnv()
    RpcSetType( 3 )
    RpcSetEnv("00", "00001000100")

    aEmps := GetEmps()

    For nX := 1 To Len(aEmps)
        
        If !(aEmps[nX, 1] == cEmpAnt) 
            RpcSetEnv(aEmps[nX, 1], aEmps[nX, 2])
        Else
			If !(aEmps[nX, 2] == cFilAnt)
				cFilAnt := aEmps[nX, 2]
				FWSM0Util():setSM0PositionBycFilAnt()
			Endif 
		EndIf

        For nY := 1 To Len(aTabs)
            NextHLock(aTabs[nY, 1], aTabs[nY, 2])
        Next nY
    Next nX

Return()

//----------------------------------------------------------------------
Static Function NextHLock(cAlias,cCampo,nIndice,lRollBack)

	//Local nSaveSx8    := GetSx8Len()
	Local cCodigo   := ""
	Local cMay      := ""
	Local aArea     := GetArea()

	DEFAULT lRollBack := .F.

	cCodigo := GetSX8Num(cAlias,cCampo)
	//FreeUsedCode()
	//cMay    := Alltrim(xFilial(cAlias))+cCodigo

	(cAlias)->(dbSetOrder(nIndice) )

	Do While (cAlias)->(dbSeek(xFilial(cAlias)+cCodigo) ) //.Or. !MayIUseCode(cMay)
		//Do While (GetSX8Len() > nSaveSx8)
			ConfirmSx8()
		//EndDo

		cCodigo := GetSX8Num(cAlias,cCampo)
		FreeUsedCode()
		cMay    := Alltrim(xFilial(cAlias))+cCodigo
	EndDo
	ConfirmSx8()

	//If lRollBack .And. __lSX8
		//RollBackSX8()
		//cCodigo := ""
	//Endif

	RestArea( aArea )

Return cCodigo

//----------------------------------------------------------------------
Static Function GetEmps()

    Local cQry  := ""
    Local aRet  := {}
    Local cAlias:= GetNextAlias()

    cQry := "SELECT M0_CODIGO, M0_CODFIL FROM SYS_COMPANY WHERE D_E_L_E_T_ = ' ' ORDER BY 1,2"

    If Select( cAlias ) > 0
        dbSelectArea( cAlias )
        ( cAlias )->( dbCloseArea() )
    EndIf

    TCQUERY cQry NEW ALIAS ( cAlias )

    While ( cAlias )->( !EoF() )
        AADD(aRet, {( cAlias )->M0_CODIGO, ( cAlias )->M0_CODFIL})
        ( cAlias )->( dbSkip() )
    EndDo

    ( cAlias )->( dbCloseArea() )

Return(aRet)
