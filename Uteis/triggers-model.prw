#include 'protheus.ch'
#include 'topconn.ch'
#Include "Totvs.ch"
#Include "parmtype.ch"
#Include "tbiconn.ch"

class TriggersModel from longclassname
    method New() CONSTRUCTOR
    method CheckTriggers()
    method GetTriggers()
    method GetConditionsByTriggerId()
    method GetActionsByTriggerId()
    method GetFilteredTicketsByConditions()
    method IsTicketAffectedByConditions()
    method ApplyActionsInTicket()
    method ReplacePlaceholders()
endclass

method New() class TriggersModel
    return self

Method CheckTriggers(cTicketId) Class TriggersModel
    Local aActions    := {}
    Local aConditions := {}
    Local nIndex      := 1

    aTriggers := ::GetTriggers()

    If len(aTriggers) > 0
        For nIndex := 1 to len(aTriggers)
            aConditions := ::GetConditionsByTriggerId(aTriggers[nIndex]['id'])
            aActions    := ::GetActionsByTriggerId(aTriggers[nIndex]['id'])

            If len(aActions) > 0 .AND. ::IsTicketAffectedByConditions(aConditions, cTicketId)
                ::ApplyActionsInTicket(aActions, cTicketId)
            EndIf
        Next
    EndIf

    Return .T.

method GetConditionsByTriggerId(cTriggerId) class TriggersModel
    local aConditions := {}
    local oCondition  := JsonObject():New()

    BeginSql Alias "SQL_Z3W"
        SELECT
            Z3W_CAMPO,
            Z3W_OPERAD,
            Z3W_VALOR,
            Z3W_MATCH
        FROM
            Z3W010
        WHERE
            Z3W_IDGATI = %Exp:cTriggerId%
        AND
            D_E_L_E_T_ = ''
    EndSql

    While !SQL_Z3W->(EoF())
        oCondition[ 'field' ]     := SQL_Z3W->Z3W_CAMPO
        oCondition[ 'operator' ]  := SQL_Z3W->Z3W_OPERAD
        oCondition[ 'value' ]     := SQL_Z3W->Z3W_VALOR
        oCondition[ 'matchType' ] := SQL_Z3W->Z3W_MATCH

        AAdd(aConditions, oCondition)
        oCondition := JsonObject():New()

        SQL_Z3W->(DbSkip())
    EndDo
    SQL_Z3W->(DbCloseArea())

    return aConditions

method GetActionsByTriggerId(cTriggerId) class TriggersModel
    local aActions := {}
    local oAction  := JsonObject():New()

    BeginSql Alias "SQL_Z3Y"
        SELECT
            Z3Y_TIPO,
            Z3Y_CAMPO,
            Z3Y_VALOR,
            Z3Y_CATDES,
            Z3Y_DESTIN,
            Z3Y_ASSUNT,
            ISNULL(CAST(CAST(Z3Y_CONEMA AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS CONTEUDO
        FROM
            Z3Y010
        WHERE
            Z3Y_IDGATI = %Exp:cTriggerId%
        AND
            D_E_L_E_T_ = ''
    EndSql

    While !SQL_Z3Y->(EoF())
        oAction[ 'field' ]         := SQL_Z3Y->Z3Y_CAMPO
        oAction[ 'type' ]          := SQL_Z3Y->Z3Y_TIPO
        oAction[ 'value' ]         := SQL_Z3Y->Z3Y_VALOR
        oAction[ 'recipientType' ] := SQL_Z3Y->Z3Y_CATDES
        oAction[ 'recipient' ]     := SQL_Z3Y->Z3Y_DESTIN
        oAction[ 'subject' ]       := SQL_Z3Y->Z3Y_ASSUNT
        oAction[ 'emailContent' ]  := Alltrim(SQL_Z3Y->CONTEUDO)

        AAdd(aActions, oAction)
        oAction := JsonObject():New()

        SQL_Z3Y->(DbSkip())
    EndDo
    SQL_Z3Y->(DbCloseArea())

    return aActions

method GetTriggers() class TriggersModel
    local aTriggers := {}
    local oTrigger := JsonObject():New()

    BeginSql Alias "SQL_DEPARA"
        SELECT
            Z3S_ID
        FROM
            Z3S010
        WHERE
            D_E_L_E_T_ = ''
    EndSql

    While !SQL_DEPARA->(EoF())
        oTrigger['id'] := SQL_DEPARA->Z3S_ID

        AAdd(aTriggers, oTrigger)
        oTrigger := JsonObject():New()
        SQL_DEPARA->(DbSkip())
    EndDo
    SQL_DEPARA->(DbCloseArea())

    return aTriggers

method IsTicketAffectedByConditions(aConditions, cTicketId) class TriggersModel
    local nIndex           := 1
    Local cTriggerWhere := ""
    local IsTicketAffectedByConditions := .F.

    For nIndex := 1 to len(aConditions)
        If aConditions[nIndex]['operator'] == '2'
            cTriggerWhere += aConditions[nIndex]['field'] + " = '" + Alltrim(aConditions[nIndex]['value']) + "'"
        Else
            cTriggerWhere += aConditions[nIndex]['field'] + " != '" + Alltrim(aConditions[nIndex]['value']) + "'"
        EndIf
        
        If nIndex < len(aConditions)
            If aConditions[nIndex]['matchType'] == '1'
                cTriggerWhere += " AND "
            Else
                cTriggerWhere += " OR "
            EndIf
        EndIf
    Next

    If cTriggerWhere == ''
        cTriggerWhere := " '1' = '2'"
    EndIf

    cTriggerWhere := "%" + cTriggerWhere + "%"

    BeginSql Alias "SQL_DEPARA"
        SELECT
            Z3A_ID
        FROM
            Z3A010
        WHERE
            Z3A_ID = %Exp:cTicketId%
        AND
            D_E_L_E_T_ = ''
        AND
            %Exp:cTriggerWhere%
    EndSql

    If !SQL_DEPARA->(EoF())
        IsTicketAffectedByConditions := .T.
    EndIf
    SQL_DEPARA->(DbCloseArea())

    return IsTicketAffectedByConditions

method ApplyActionsInTicket(aActions, cTicketId) class TriggersModel
    local nIndex := 1
    local cReceiver := ""

    If len(aActions) > 0
        For nIndex := 1 to len(aActions)
            oAction := aActions[nIndex] 
            If oAction['type'] == '2'
                DbSelectArea("Z3A")
                Z3A->(DbSetOrder(1))
                If Z3A->(MsSeek(xFilial("Z3A") + cTicketId))
                    RecLock("Z3A", .F.)
                        Z3A->&(oAction['field']) := oAction['value']
                    Z3A->(MsUnlock())
                    EndIf
                Z3A->(DbCloseArea())
            Else
                cEmailContent := ::ReplacePlaceholders(oAction['emailContent'], cTicketId)

                If oAction['recipientType'] == '2' //Usuario
                    If Z3F->(MsSeek(xFilial("Z3F")+Alltrim(oAction['recipient'])))
                        RecLock("Z3F", .F.)
                            cReceiver := Alltrim(Z3F->Z3F_EMAIL)
                        Z3F->(MsUnlock())
                    EndIf
                    
                    EnviaEmail(cReceiver, oAction['subject'], cEmailContent, {}, .F., .T., .F.)

                ElseIf oAction['recipientType'] == '1' //Grupos
                    cRecipientId := oAction['recipient']
                    BeginSql Alias "SQL_Z3F"
                        SELECT
                            Z3F_EMAIL
                        FROM
                            Z3F010
                        WHERE
                            Z3F_GRUPO = %Exp:cRecipientId%
                        AND
                            D_E_L_E_T_ = ''
                    EndSql

                    While !SQL_Z3F->(Eof())
                        EnviaEmail(Alltrim(SQL_Z3F->Z3F_EMAIL), oAction['subject'], cEmailContent, {}, .F., .T., .F.)

                        SQL_Z3F->(DbSkip())
                    EndDo
                    SQL_Z3F->(DbCloseArea())
                EndIf
            EndIf
        Next
    EndIf

    return

method ReplacePlaceholders(cEmail, cTicketId) class TriggersModel
    local cEmailReplaced    := cEmail
    local cRequesterName    := ""
    local cOrganizationName := ""
    local cGroupName := ""

    DbSelectArea("Z3A")
    Z3F->(DbSetOrder(1))

    DbSelectArea("Z3A")
    Z3A->(DbSetOrder(1))
    If Z3A->(MsSeek(xFilial("Z3A") + cTicketId))
        If Z3F->(MsSeek(xFilial("Z3F") + Z3A->Z3A_IDSOL))
            cRequesterName := Alltrim(Z3F->Z3F_NAME)
        EndIf

        If Z3K->(MsSeek(xFilial("Z3K") + Z3A->Z3A_GRUPO))
            cGroupName := Alltrim(Z3K->Z3K_NOME)
        EndIf

        If Z3H->(MsSeek(xFilial("Z3H") + Z3A->Z3A_IDORG))
            cOrganizationName := Alltrim(Z3H->Z3H_NOME)
        EndIf
    EndIf
    Z3A->(DbCloseArea())
    Z3F->(DbCloseArea())
    Z3H->(DbCloseArea())
    Z3K->(DbCloseArea())

    cEmailReplaced := StrTran(cEmailReplaced, '{{requesterName}}', cRequesterName)
    cEmailReplaced := StrTran(cEmailReplaced, '{{ticketId}}', cTicketId)
    cEmailReplaced := StrTran(cEmailReplaced, '{{groupName}}', cGroupName)
    cEmailReplaced := StrTran(cEmailReplaced, '{{organizationName}}', cOrganizationName)

    ConOut("Texto replace")
    ConOut(cEmailReplaced)

    return cEmailReplaced

Static Function EnviaEmail(cPara, cAssunto, cMensagem, aAnexos, lMostraLog, lUsaTLS, nTipoMsg)
	Local oServer     := TMailManager():New()
	Local oMessage     := TMailMessage():New()
	Local cConta     := "reports@3corp.com.br" 
	Local cSenha     := "y1jpD54D}X#Z" 
	Local cSMTP     := "smtp.office365.com" 
	Local nPorta     := 587 // Porta segura com TLS
	Local lRet         := .T.

	Default cMensagem := ""
	oMessage:Clear()
	oMessage:cFrom := 'reports@3corp.com.br' //cConta
	oMessage:cTo := cPara
	oMessage:cSubject := cAssunto
	oMessage:cBody := cMensagem
	oMessage:MsgBodyType("text/html")

	oServer:SetUseTLS(.T.)
	oServer:SetUseSSL(.T.)
	oServer:Init("", cSMTP, cConta, cSenha, 0, nPorta)

	If oServer:SMTPConnect() != 0
		ConOut("Erro ao conectar ao servidor SMTP.")
		Return
	EndIf

	If oServer:SmtpAuth(cConta, cSenha) != 0
		ConOut("Erro na autenticação SMTP.")
		oServer:SMTPDisconnect()
		Return
	EndIf

	If oMessage:Send(oServer) != 0
		ConOut("Erro ao enviar o e-mail.")
	Else
		ConOut("E-mail enviado com sucesso!")
	EndIf

	oServer:SMTPDisconnect()

    Return lRet
