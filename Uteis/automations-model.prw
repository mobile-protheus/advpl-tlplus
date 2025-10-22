#include 'protheus.ch'
#include 'topconn.ch'
#Include "Totvs.ch"
#Include "parmtype.ch"
#Include "tbiconn.ch"

class AutomationsModel from longclassname
    method New() CONSTRUCTOR
    method CheckAutomations()
    method GetAutomations()
    method GetConditionsByAutomationId()
    method GetActionsByAutomationId()
    method GetFilteredTicketsByConditions()
    method ApplyActionsInTicket()
    method ReplacePlaceholders()
    method CreateAutomationHistoryItem()
    method CheckStatusConditions()
    method IsActionTicketResolution()
endclass

method New() class AutomationsModel
    return self

Method CheckAutomations() Class AutomationsModel
    Local aActions    := {}
    Local aConditions := {}
    Local nIndex      := 1
    local nJIndex     := 1

    RpcClearEnv()
    RpcSetType(3)
    RpcSetEnv("01", "01")

    aAutomations := ::GetAutomations()

    If len(aAutomations) > 0
        For nIndex := 1 to len(aAutomations)
            cAutomationId := aAutomations[nIndex]['id']
            aConditions := ::GetConditionsByAutomationId(cAutomationId)
            aActions    := ::GetActionsByAutomationId(cAutomationId)
            aTickets    := ::GetFilteredTicketsByConditions(aConditions)

            If len(aActions) > 0 .AND. len(aTickets)
                For nJIndex := 1 to len(aTickets)
                    cTicketId := aTickets[nJIndex]['id']
                    
                    BeginSql Alias "SQL_Z33"
                        SELECT
                            Z33_ID
                        FROM
                            Z33010
                        WHERE
                            Z33_IDTICK = %Exp:cTicketId%
                        AND
                            Z33_IDAUTO = %Exp:cAutomationId%
                    EndSql

                    If SQL_Z33->(Eof())
                        ::ApplyActionsInTicket(aActions, cTicketId)
                        ::CreateAutomationHistoryItem(cAutomationId, cTicketId)
                    EndIf
                    SQL_Z33->(DbCloseArea())
                Next
            EndIf
        Next
    EndIf

    Return .T.

method GetConditionsByAutomationId(cAutomationId) class AutomationsModel
    local aConditions := {}
    local oCondition  := JsonObject():New()

    BeginSql Alias "SQL_Z3X"
        SELECT
            Z3X_CAMPO,
            Z3X_OPERAD,
            Z3X_VALOR,
            Z3X_MATCH
        FROM
            Z3X010
        WHERE
            Z3X_IDAUTO = %Exp:cAutomationId%
        AND
            D_E_L_E_T_ = ''
    EndSql

    While !SQL_Z3X->(EoF())
        oCondition[ 'field' ]     := SQL_Z3X->Z3X_CAMPO
        oCondition[ 'operator' ]  := SQL_Z3X->Z3X_OPERAD
        oCondition[ 'value' ]     := SQL_Z3X->Z3X_VALOR
        oCondition[ 'matchType' ] := SQL_Z3X->Z3X_MATCH

        AAdd(aConditions, oCondition)
        oCondition := JsonObject():New()

        SQL_Z3X->(DbSkip())
    EndDo
    SQL_Z3X->(DbCloseArea())

    return aConditions

method GetActionsByAutomationId(cAutomationId) class AutomationsModel
    local aActions := {}
    local oAction  := JsonObject():New()

    BeginSql Alias "SQL_Z31"
        SELECT
            Z31_TIPO,
            Z31_CAMPO,
            Z31_VALOR,
            Z31_CATDES,
            Z31_DESTIN,
            Z31_ASSUNT,
            ISNULL(CAST(CAST(Z31_CONEMA AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS CONTEUDO
        FROM
            Z31010
        WHERE
            Z31_IDAUTO = %Exp:cAutomationId%
        AND
            D_E_L_E_T_ = ''
    EndSql

    While !SQL_Z31->(EoF())
        oAction[ 'field' ]         := SQL_Z31->Z31_CAMPO
        oAction[ 'type' ]          := SQL_Z31->Z31_TIPO
        oAction[ 'value' ]         := SQL_Z31->Z31_VALOR
        oAction[ 'recipientType' ] := SQL_Z31->Z31_CATDES
        oAction[ 'recipient' ]     := SQL_Z31->Z31_DESTIN
        oAction[ 'subject' ]       := SQL_Z31->Z31_ASSUNT
        oAction[ 'emailContent' ]  := Alltrim(SQL_Z31->CONTEUDO)

        AAdd(aActions, oAction)
        oAction := JsonObject():New()

        SQL_Z31->(DbSkip())
    EndDo
    SQL_Z31->(DbCloseArea())

    return aActions

method GetAutomations() class AutomationsModel
    local aAutomations := {}
    local oAutomation := JsonObject():New()

    BeginSql Alias "SQL_DEPARA"
        SELECT
            Z3R_ID
        FROM
            Z3R010
        WHERE
            D_E_L_E_T_ = ''
    EndSql

    While !SQL_DEPARA->(EoF())
        oAutomation['id'] := SQL_DEPARA->Z3R_ID

        AAdd(aAutomations, oAutomation)
        oAutomation := JsonObject():New()
        SQL_DEPARA->(DbSkip())
    EndDo
    SQL_DEPARA->(DbCloseArea())

    return aAutomations

method GetFilteredTicketsByConditions(aConditions) class AutomationsModel
    local aTickets         := {}
    local oTicket          := JsonObject():New()
    local nIndex           := 1
    Local cAutomationWhere := ""
    Local aStatusConditions := {}

    // Monta WHERE só para condições "normais"
    For nIndex := 1 to len(aConditions)
        If SubStr(aConditions[nIndex]['field'],1,3) == 'sts'
            AAdd(aStatusConditions, aConditions[nIndex]) 
            ConOut(">> Detectado campo de status: " + aConditions[nIndex]['field'] + ;
                   " valor: " + aConditions[nIndex]['value'])
        Else
            If nIndex < len(aConditions) .AND. nIndex > 1
                If aConditions[nIndex]['matchType'] == '1'
                    cAutomationWhere += " AND "
                Else
                    cAutomationWhere += " OR "
                EndIf
            EndIf

            If aConditions[nIndex]['operator'] == '2'
                cAutomationWhere += aConditions[nIndex]['field'] + " = '" + Alltrim(aConditions[nIndex]['value']) + "'"
            Else
                cAutomationWhere += aConditions[nIndex]['field'] + " != '" + Alltrim(aConditions[nIndex]['value']) + "'"
            EndIf
        EndIf
    Next

    If cAutomationWhere == ''
        cAutomationWhere := " '1' = '2'"
    EndIf

    cAutomationWhere := "%" + cAutomationWhere + "%"

    ConOut(">> WHERE montado: " + cAutomationWhere)

    BeginSql Alias "SQL_DEPARA"
        SELECT
            Z3A_ID,
            Z3A_DATA,
            Z3A_HORA,
            Z3A_STATUS
        FROM
            Z3A010
        WHERE
            D_E_L_E_T_ = ''
        AND
            %Exp:cAutomationWhere%
    EndSql

    While !SQL_DEPARA->(EoF())
        oTicket['id']     := SQL_DEPARA->Z3A_ID
        oTicket['status'] := SQL_DEPARA->Z3A_STATUS
        oTicket['data']   := SQL_DEPARA->Z3A_DATA
        oTicket['hora']   := SQL_DEPARA->Z3A_HORA

        ConOut(">> Ticket encontrado: ID=" + oTicket['id'] + " STATUS=" + oTicket['status'])

        If ::CheckStatusConditions(oTicket, aStatusConditions)
            ConOut("   -> Ticket " + oTicket['id'] + " ATENDEU condições de status")
            aAdd(aTickets, oTicket)
        Else
            ConOut("   -> Ticket " + oTicket['id'] + " NÃO atendeu condições de status")
        EndIf

        oTicket := JsonObject():New()
        SQL_DEPARA->(DbSkip())
    EndDo
    SQL_DEPARA->(DbCloseArea())

    return aTickets


// -----------------------------------------------------------------
// Verificação das condições sts001..sts006
// -----------------------------------------------------------------
method CheckStatusConditions(oTicket, aStatusConditions) class AutomationsModel
    local nIndex      := 1
    local lOk         := .T.
    local cTicketId   := oTicket[ 'id' ]
    local dInicio     := nil
    local cHoraInicio := ""
    local cStatus     := ''

    If Len(aStatusConditions) == 0
        Return .T.
    EndIf

    For nIndex := 1 to Len(aStatusConditions)
        cStatus := Alltrim(Right(aStatusConditions[nIndex]['field'], 1))
        ConOut(">> Verificando condição: " + aStatusConditions[nIndex]['field'] + ;
               " valor=" + aStatusConditions[nIndex]['value'])

        ConOut("Valor de cStatus:" + cStatus)

        BeginSql Alias "SQL_Z3P"
            SELECT
                TOP 1 Z3P_DATINT,
                Z3P_HORINT
            FROM
                Z3P010
            WHERE
                Z3P_IDTICK = %Exp:cTicketId%
                AND Z3P_CAMPO = 'Z3A_STATUS'
                AND ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(8000)) AS VARCHAR(8000)),'') LIKE %Exp:cStatus% + "%"
                AND D_E_L_E_T_ = ''
            ORDER BY
                Z3P_DATINT DESC,
                Z3P_HORINT DESC
        EndSql

        If !SQL_Z3P->(EoF())
            ConOut("   -> Último status encontrado em Z3P: " + SQL_Z3P->Z3P_DATINT + " " + SQL_Z3P->Z3P_HORINT)
            dInicio := stod(SQL_Z3P->Z3P_DATINT)
            cHoraInicio := LEFT(SQL_Z3P->Z3P_HORINT, 5)

            nTempoDecorrido := SubtHoras(dInicio, cHoraInicio, Date(), Time(), .T.)
            ConOut("Tempo decorrido em horas:" + cValtochar(nTempoDecorrido))

            lOk := nTempoDecorrido > val(aStatusConditions[nIndex]['value'])
        Else
            ConOut("   -> Nenhum histórico encontrado em Z3P para esse status!")
            lOk := .F.
        EndIf
        SQL_Z3P->(DbCloseArea())
    Next

    Return lOk


method ApplyActionsInTicket(aActions, cTicketId) class AutomationsModel
    local nIndex        := 1
    local cEmail        := ""
    local oArgusModel   := JsonObject():New()
    local oTicketChange := JsonObject():New()
    local nPos          := 1
    local aFields       := { ;
        {"Z3A_STATUS", "status"}, ;
        {"Z3A_ATRIBU", "assigned"}, ;
        {"Z3A_TIPO"  , "type"}, ;
        {"Z3A_TPATEN", "serviceType"}, ;
        {"Z3A_CRITIC", "criticality"}, ;
        {"Z3A_PRIORI", "priority"}, ;
        {"Z3A_INDISP", "downTime"}, ;
        {"Z3A_EQUIP" , "equipment"}, ;
        {"Z3A_CLASSI", "classification"}, ;
        {"Z3A_TECHLI", "techLeader"}, ;
        {"Z3A_GRUPO" , "resolverGroup"}, ;
        {"Z3A_IDFILA", "queue"}, ;
        {"Z3A_PROTOC", "customerProtocol"}, ;
        {"Z3A_TEMIND", "unavailabilityTime"}, ;
        {"Z3A_DTVENC", "dueDate"}, ;
        {"Z3A_LOCALI", "locality"}, ;
        {"Z3A_TPTECH", "technologyType"}, ;
        {"Z3A_IDSOL" , "requesterId"}, ;
        {"Z3A_TAGS"  , "tags"}, ;
        {"Z3A_SEGUID", "followers"}, ;
        {"Z3A_OCORRE", "occurrences"}, ;
        {"Z3A_ASSUNT", "title"} ;
    }

    oArgusModel := ArgusModel():New()

    If len(aActions) > 0
        For nIndex := 1 to len(aActions)
            oAction := aActions[nIndex] 
            If oAction['type'] == '2'
                DbSelectArea("Z3A")
                Z3A->(DbSetOrder(1))

                If Z3A->(MsSeek(xFilial("Z3A") + cTicketId))
                    DbSelectArea("Z3F")
                    Z3F->(DbSetOrder(1))
                    ConOut("Área Z3F selecionada e ordem definida")

                    If ::IsActionTicketResolution(oAction)
                        ConOut("O Action é de tipo Ticket Resolution")

                        If Z3F->(MsSeek(xFilial("Z3F")+Z3A->Z3A_IDUSER))
                            ConOut("Registro encontrado para filial + ID User")
                            
                            RecLock("Z3F", .F.)
                                cRequesterName := Alltrim(Z3F->Z3F_EMAIL)
                                cEmail := Alltrim(Z3F->Z3F_EMAIL)
                                ConOut("Email extraído: " + cEmail)
                            Z3F->(MsUnlock())
                            ConOut("Registro desbloqueado")
                        Else
                            ConOut("Registro não encontrado para filial + ID User")
                        EndIf

                        oFile := JsonObject():New()
                        ConOut("Objeto JSON inicializado")

                        oFile := FWFileReader():New("\workflow\portal\avaliar.htm")
                        ConOut("Objeto FWFileReader criado")

                        oFile:Open()
                        ConOut("Arquivo HTML aberto")

                        cHtml := oFile:FullRead()
                        ConOut("HTML lido do arquivo, tamanho: " + Ltrim(Str(Len(cHtml))))

                        cHtml := StrTran(cHtml, '%{{requesterName}}%', cRequesterName)
                        cHtml := StrTran(cHtml, '%{{ticketId}}%', cTicketId)
                        EnviaEmail(cEmail, "[3Corp] Avalie Nosso Atendimento", cHtml, {}, .F., .T., .F.)
                        ConOut("Email enviado para: " + cEmail)
                    Else
                        ConOut("O Action NÃO é de tipo Ticket Resolution")
                    EndIf


                    RecLock("Z3A", .F.)
                        Z3A->&(oAction['field']) := oAction['value']
                    Z3A->(MsUnlock())

                    oTicketChange := JsonObject():New()
                    nPos := aScan(aFields, {|x| x[1] == oAction['field']})

                    cFieldName := aFields[nPos][2]

                    oTicketChange['id'] := cTicketId
                    oTicketChange['operatorId'] := "AUTOM."
                    oTicketChange[cFieldName] := oAction['value']
                    oArgusModel:PostInterationsInTicket(oTicketChange)
                EndIf
            Else
                cEmailContent := ::ReplacePlaceholders(oAction['emailContent'], cTicketId)

                If oAction['recipientType'] == '2' //Usuario
                    If Z3F->(MsSeek(xFilial("Z3F")+Alltrim(oAction['recipient'])))
                        RecLock("Z3F", .F.)
                            cEmail := Alltrim(Z3F->Z3F_EMAIL)
                        Z3F->(MsUnlock())
                    EndIf

                    EnviaEmail(cEmail, oAction['subject'], cEmailContent, {}, .F., .T., .F.)

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

method ReplacePlaceholders(cEmail, cTicketId) class AutomationsModel
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
            cRequesterName := Alltrim(Z3F_NAME)
        EndIf

        If Z3K->(MsSeek(xFilial("Z3K") + Z3A->Z3A_GRUPO))
            cGroupName := Alltrim(Z3K_NOME)
        EndIf

        If Z3H->(MsSeek(xFilial("Z3H") + Z3A->Z3A_IDORG))
            cOrganizationName := Alltrim(Z3H_NOME)
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

    return cEmailReplaced

method CreateAutomationHistoryItem(cAutomationId, cTicketId) class AutomationsModel

    RecLock("Z33", .T.)
        Z33->Z33_FILIAL := xFilial("Z33")
        Z33->Z33_ID     := NextNumero("Z33", 1, "Z33_ID", .T.)
        Z33->Z33_IDTICK := cTicketId
        Z33->Z33_IDAUTO := cAutomationId
        Z33->Z33_DATA   := Date()
        Z33->Z33_HORAEX := TIME()
    Z33->(MsUnlock())

    return

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


method IsActionTicketResolution(oAction) class AutomationsModel
    local bIsActionTicketResolution := .F.

    If oAction['field'] == 'Z3A_STATUS' .AND. alltrim(oAction['value']) == '5'
        bIsActionTicketResolution := .T.
    Endif

    return bIsActionTicketResolution
