#include 'protheus.ch'
#include 'topconn.ch'
#Include "Totvs.ch"
#Include "parmtype.ch"
#Include "tbiconn.ch"

class ArgusModel from longclassname
	method New() CONSTRUCTOR
	method getProducts()
	method GetLocalizations()
	method GetMessages()
	method GetAttachments()
	method GetTickets()
	method GetSlaTickets()
	method GetBacklogData()
	method getAgentsUpdates()
	method GetQueueTickets()
	method GetTicket()
	method DoLogin()
	method DoAgentLogin()
	method GetUser()
	method GetUserContacts()
	method GetUsers()
	method createUserContact()
	method updateUserContact()
	method deleteUserContact()
	method GetAgents()
	method GetQueues()
	method GetOccurrences()
	method GetTags()
	method GetArticles()
	method GetTriggers()
	method GetActionsXTriggers()
	method GetActXAutomations()
	method GetAutomations()
	method GetGroups()
	method PutUser()
	method PutOrganization()
	method PostOrganization()
	method PostSLA()
	method PutSLA()
	method getSlaxOrgs()
	method PutTicket()
	method PostUser()
	method PostQueue()
	method PostTag()
	method PostArticle()
	method PostTrigger()
	method PostAutomation()
	method PostGroup()
	method PutQueue()
	method PutTag()
	method PutArticle()
	method PutTrigger()
	method PutAutomation()
	method PutGroup()
	method DeleteTag()
	method DeleteArticle()
	method DeleteTrigger()
	method DeleteAutomation()
	method DeleteQueue()
	method DeleteGroup()
	method GetMacros()
	method PostMacro()
	method PutMacro()
	method DeleteMacro()
	method PutAgent()
	method EvaluateTicket()
	method PostAgent()
	method DeleteAgent()
	method DeleteOrganization()
	method GetOrganizations()
	method DeleteSLA()
	method GetSLAs()
	method GetHistory()
	method GetAgentInfo()
	method GetOrg()
	method PostInterationsInTicket()
	method SendPasswordRecovery()
	method EmailExist()
	method AgentEmailExist()
	method IsCodeValid()
	method ResetPassword()
	method RedefinePassword()
	method ImportUsers()
	method importOrganizations()
	method SendWelcomeAgentEmail()
	method getQueuesXConditions()
	method getTriXConditions()
	method getAutXConditions()
	method GetOrgXAttachments()
	method CheckTriggers()
	method PostOccurrence()
	method PutOccurrence()
	method DeleteOccurrence()
	method PostOrgAttachment()
	method DelOrgAttachment()
	method GetContracts()
	method PostContracts()
	method PutContracts()
	method DeleteContracts()
	method PostLocalizations()
    method PutLocalizations()
    method DeleteLocalizations()
    method GetServiceFormats()
    method PostServiceFormats()
    method PutServiceFormats()
    method DeleteServiceFormats()
endclass

method New() class ArgusModel
return self

method EmailExist(cEmail) class ArgusModel
	local lEmailExist := .F.

	BeginSql Alias "SQL_Z3F"
        SELECT
            Z3F_ID AS ID
        FROM
            Z3F010
        WHERE
            Z3F_EMAIL = %Exp:cEmail%
        AND
            D_E_L_E_T_ = ''
	EndSql

	If !SQL_Z3F->(EoF())
		lEmailExist := .T.
	EndIf
	SQL_Z3F->(DbCloseArea())

return lEmailExist

method AgentEmailExist(cEmail) class ArgusModel
	local lEmailExist := .F.

	BeginSql Alias "SQL_Z3I"
        SELECT
            Z3I_ID AS ID
        FROM
            Z3I010
        WHERE
            Z3I_EMAIL = %Exp:cEmail%
        AND 
            D_E_L_E_T_ = ''
	EndSql

	If !SQL_Z3I->(EoF())
		lEmailExist := .T.
	EndIf
	SQL_Z3I->(DbCloseArea())

return lEmailExist

method GetProducts(page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_PRODUCTS"
        SELECT
            B1_COD,
            B1_DESC,
            COUNT(*) OVER() AS TOTAL
        FROM
            SB1010
        WHERE
            D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(B1_DESC) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
        ORDER BY
            B1_COD
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_PRODUCTS->TOTAL
	oResponse['hasNext'] := SQL_PRODUCTS->TOTAL > page * pageSize

	While !SQL_PRODUCTS->(EoF())
		oItem[ 'value' ]  := Alltrim(SQL_PRODUCTS->B1_COD)
		oItem[ 'label' ]  := alltrim(SQL_PRODUCTS->B1_DESC)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_PRODUCTS->(DbSkip())
	EndDo
	SQL_PRODUCTS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse


method GetOccurrences(page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_OCCURRENCES"
        SELECT
            Z32_ID,
            Z32_DESCRI,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z32010
        WHERE
            D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z32_DESCRI) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
        ORDER BY
            Z32_ID
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_OCCURRENCES->TOTAL
	oResponse['hasNext'] := SQL_OCCURRENCES->TOTAL > page * pageSize

	While !SQL_OCCURRENCES->(EoF())
		oItem[ 'id' ]  := Alltrim(SQL_OCCURRENCES->Z32_ID)
		oItem[ 'description' ]  := alltrim(SQL_OCCURRENCES->Z32_DESCRI)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_OCCURRENCES->(DbSkip())
	EndDo
	SQL_OCCURRENCES->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse



method GetLocalizations(page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_LOCALIZATIONS"
        SELECT
            CC2_CODMUN,
            CC2_EST,
            CC2_MUN,
            COUNT(*) OVER() AS TOTAL
        FROM
            CC2010
        WHERE
            D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(CC2_MUN) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
        ORDER BY
            CC2_MUN
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_LOCALIZATIONS->TOTAL
	oResponse['hasNext'] := SQL_LOCALIZATIONS->TOTAL > page * pageSize

	While !SQL_LOCALIZATIONS->(EoF())
		oItem[ 'state' ]  := Alltrim(SQL_LOCALIZATIONS->CC2_EST)
		oItem[ 'value' ]  := Alltrim(SQL_LOCALIZATIONS->CC2_CODMUN)
		oItem[ 'label' ]  := alltrim(SQL_LOCALIZATIONS->CC2_MUN)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_LOCALIZATIONS->(DbSkip())
	EndDo
	SQL_LOCALIZATIONS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetAttachments(cTicketId) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_ATTACHMENTS"
        SELECT
            Z3D_ID,
            ISNULL(CAST(CAST(Z3D_ANEXO AS VARBINARY(8000)) AS VARCHAR(8000)), '') AS ANEXO,
            Z3D_NOME,
            COUNT(*) OVER() AS TOTAL
        FROM 
            Z3D010 Z3D
        WHERE
            Z3D.D_E_L_E_T_ = ''
            AND Z3D_IDTICK = %Exp:cTicketId%
        ORDER BY
            Z3D_ID DESC
	EndSql

	While !SQL_ATTACHMENTS->(EoF())
		If Z3D->(MsSeek(xFilial("Z3D")+SQL_ATTACHMENTS->Z3D_ID) )
			RecLock("Z3D", .F.)
			oItem[ 'base64' ] := Alltrim(Z3D->Z3D_ANEXO)
			Z3D->(MsUnlock())
		EndIf
		Z3D->(DbCloseArea())

		oItem[ 'id' ]     := Alltrim(SQL_ATTACHMENTS->Z3D_ID)
		//oItem[ 'base64' ] := Alltrim(SQL_ATTACHMENTS->ANEXO)
		oItem[ 'name' ]   := Alltrim(SQL_ATTACHMENTS->Z3D_NOME)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_ATTACHMENTS->(DbSkip())
	EndDo
	SQL_ATTACHMENTS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetOrgXAttachments(cOrganizationId) class ArgusModel
	local oResponse := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}

	BeginSql Alias "SQL_ATTACHMENTS"
        SELECT
            Z3V_ID,
            Z3V_NOME
        FROM 
            Z3V010 Z3V
        WHERE
            Z3V.D_E_L_E_T_ = ''
            AND Z3V_IDORGA = %Exp:cOrganizationId%
        ORDER BY
            Z3V_ID DESC
	EndSql

	While !SQL_ATTACHMENTS->(EoF())
		If Z3V->(MsSeek(xFilial("Z3V")+SQL_ATTACHMENTS->Z3V_ID) )
			RecLock("Z3V", .F.)
			oItem[ 'base64' ] := Alltrim(Z3V->Z3V_ANEXO)
			Z3V->(MsUnlock())
		EndIf
		Z3V->(DbCloseArea())

		oItem['id'] := SQL_ATTACHMENTS->Z3V_ID
		oItem['name'] := Alltrim(SQL_ATTACHMENTS->Z3V_NOME)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_ATTACHMENTS->(DbSkip())
	EndDo
	SQL_ATTACHMENTS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetMessages(cTicketId, page, pageSize, cFilter, cCanGetPrivateMessages) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_MESSAGES"
        SELECT
            Z3C_ID,
            Z3C_IDTICK,
            ISNULL(CAST(CAST(Z3C_DESTIN AS VARBINARY(8000)) AS VARCHAR(8000)), '') AS DESTINATARIO,
            ISNULL(CAST(CAST(Z3C_REMETE AS VARBINARY(8000)) AS VARCHAR(8000)), '') AS REMETENTE,
            Z3C_DATA,
            Z3C_HORA,
            Z3C_PRIVAD,
			Z3F_ID,
            CASE 
                WHEN Z3F_TYPE = '2' THEN 'AGENTE'
                WHEN Z3F_TYPE = '1' THEN 'CLIENTE'
                ELSE 'DESCONHECIDO'
            END AS MENSAGEM_ENVIADA_POR,
            COUNT(*) OVER() AS TOTAL
        FROM Z3C010 Z3C
        LEFT JOIN Z3A010 Z3A ON Z3A_ID = Z3C_IDTICK
        LEFT JOIN Z3F010 Z3F ON Z3F.Z3F_EMAIL = Z3C.Z3C_REMETE AND Z3F.D_E_L_E_T_ = ''
        LEFT JOIN Z3I010 Z3I ON Z3I.Z3I_EMAIL = Z3C.Z3C_REMETE AND Z3I.D_E_L_E_T_ = ''
        WHERE
            Z3C.D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z3C_IDTICK) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
            AND Z3C_IDTICK = %Exp:cTicketId%
            AND (
                %Exp:cCanGetPrivateMessages% = '1'
                OR (%Exp:cCanGetPrivateMessages% <> '1' AND Z3C_PRIVAD <> '1')
            )

        ORDER BY
            Z3C_IDTICK DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_MESSAGES->TOTAL
	oResponse['hasNext'] := SQL_MESSAGES->TOTAL > page * pageSize

	While !SQL_MESSAGES->(EoF())
		If Z3C->(MsSeek(xFilial("Z3C")+SQL_MESSAGES->Z3C_ID) )
			RecLock("Z3C", .F.)
				oItem[ 'message' ] := Alltrim(Z3C->Z3C_MENSAG)	
			Z3C->(MsUnlock())
		EndIf
		Z3C->(DbCloseArea())

		If Z3F->(MsSeek(xFilial("Z3F")+SQL_MESSAGES->Z3F_ID) )
			RecLock("Z3F", .F.)
				oItem[ 'senderPhoto' ] := Alltrim(Z3F->Z3F_PHOTO)
			Z3F->(MsUnlock())
		EndIf
		Z3F->(DbCloseArea())

		oItem[ 'id' ]               := Alltrim(SQL_MESSAGES->Z3C_ID)
		oItem[ 'ticketId' ]         := Alltrim(SQL_MESSAGES->Z3C_IDTICK)
		oItem[ 'to' ]               := Alltrim(SQL_MESSAGES->DESTINATARIO)
		oItem[ 'from' ]             := Alltrim(SQL_MESSAGES->REMETENTE)
		oItem[ 'date' ]             := year2Str(stod(SQL_MESSAGES->Z3C_DATA)) + "-" + Month2Str(stod(SQL_MESSAGES->Z3C_DATA)) + "-" + Day2Str(stod(SQL_MESSAGES->Z3C_DATA))
		oItem[ 'time' ]             := Alltrim(SQL_MESSAGES->Z3C_HORA)
		oItem[ 'isPrivateMessage' ] := Alltrim(SQL_MESSAGES->Z3C_PRIVAD)
		oItem[ 'messageSentBy' ]    := Alltrim(SQL_MESSAGES->MENSAGEM_ENVIADA_POR)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_MESSAGES->(DbSkip())
	EndDo
	SQL_MESSAGES->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetTickets(page, pageSize, cFilter, cRequesterId, cQueueId, cOrganizationId, cAssigned, cInitialDate, cEndDate, cFollower) class ArgusModel
	Local offset            := 0
	Local oResponse         := JsonObject():New()
	Local oItem             := JsonObject():New()
	Local aItems            := {}
	local cQueueWhere       := ""
	//local nIndex            := 1
	local aOccurrences      := {}
	//local oSubItem          := JsonObject():New()
	//local aSubItems         := {}
	Default page            := 1
	Default pageSize        := 10
	Default cFilter         := ''
	Default cRequesterId    := ''
	Default cOrganizationId := ''
	Default cAssigned       := ''
	Default cInitialDate    := ''
	Default cEndDate        := ''
	Default cFollower        := ''

	offset := pageSize * (page - 1)

	If cQueueId != ''
		BeginSql Alias "SQL_Z3U"
            SELECT
                Z3U_CAMPO,
                Z3U_OPERAD,
                Z3U_VALOR,
                Z3U_MATCH
            FROM
                Z3U010
            WHERE
                Z3U_IDFILA = %Exp:cQueueId%
            AND
                D_E_L_E_T_ = ''
		EndSQl

		While !SQL_Z3U->(EoF())
			If SQL_Z3U->Z3U_OPERAD = '2'
				cQueueWhere += SQL_Z3U->Z3U_CAMPO + " = '" + Alltrim(SQL_Z3U->Z3U_VALOR) + "'"
			Else
				cQueueWhere += SQL_Z3U->Z3U_CAMPO + " != '" + Alltrim(SQL_Z3U->Z3U_VALOR) + "'"
			EndIf

			SQL_Z3U->(DbSkip())
			If !SQL_Z3U->(EoF())
				If SQL_Z3U->Z3U_MATCH == '1'
					cQueueWhere += " AND "
				Else
					cQueueWhere += " OR "
				EndIf
			EndIf
		EndDo
		SQL_Z3U->(DbCloseArea())
	EndIf

	If cQueueWhere == ''
		cQueueWhere := " '1' = '2'"
	EndIf

	cQueueWhere := "%" + cQueueWhere + "%"

	// Executa SQL
	BeginSql Alias "SQL_TICKETS"
        SELECT
            Z3A_ID,
            Z3A_STATUS,
            Z3A_CRITIC,
            Z3A_SLA,
            Z3A_DATA,
            Z3A_HORA,
            Z3A_IDSOL,
            Z3A_IDORG,
			ISNULL(
                CAST(
                    CAST(Z3A_ASSUNT AS VARBINARY(8000)) AS VARCHAR(8000)
                ),
                ''
            ) AS ASSUNTO,
            Z3A_OPERAT,
            Z3A_ULTATI,
            Z3A_ATRIBU,
            Z3A_TPATEN,
            Z3A_TECHLI,
            Z3A_GRUPO,
            Z3A_TPTECH,
            Z3A_TIPO,
            Z3A_INDISP,
            Z3A_PRIORI,
            Z3H_NOME,
            Z3A_SATISF,
            Z3F_NAME,
			Z3F_ID,
            (
                SELECT
                    TOP 1 Z3P_DATINT
                FROM
                    Z3P010
                WHERE
                    Z3P_IDTICK = Z3A.Z3A_ID
                    AND Z3P_CAMPO = 'Z3A_STATUS'
                    AND CAST(
                        CAST(Z3P_VALNOV AS VARBINARY(8000)) AS VARCHAR(8000)
                    ) LIKE '4%'
                ORDER BY Z3P_DATINT DESC, Z3P_HORINT DESC
            ) AS DATA_FECHAMENTO, 
            (
                SELECT
                    TOP 1 Z3P_HORINT
                FROM
                    Z3P010
                WHERE
                    Z3P_IDTICK = Z3A.Z3A_ID
                    AND Z3P_CAMPO = 'Z3A_STATUS'
                    AND CAST(
                        CAST(Z3P_VALNOV AS VARBINARY(8000)) AS VARCHAR(8000)
                    ) LIKE '4%'
                ORDER BY Z3P_DATINT DESC, Z3P_HORINT DESC
            ) AS HORA_FECHAMENTO, 
            (
                SELECT
                    TOP 1 CC2_MUN
                FROM
                    CC2010
                WHERE
                    CC2_CODMUN = Z3A.Z3A_LOCALI
                    AND D_E_L_E_T_ = ''
            ) AS NOME_LOCALIDADE,
            ISNULL(
                CAST(
                    CAST(Z3A_OCORRE AS VARBINARY(8000)) AS VARCHAR(8000)
                ),
                ''
            ) AS OCORRENCIAS,
            (
                SELECT
                    TOP 1 Z3F_NAME
                FROM
                    Z3F010
                WHERE
                    Z3F_ID = Z3A.Z3A_ATRIBU
            ) AS NOME_ATRIBUIDO,
            CASE
                WHEN Z3A_PRIORI = '1'
                AND Z3A_STATUS = '0' THEN Z3N_RPSBAI
                WHEN Z3A_PRIORI = '2'
                AND Z3A_STATUS = '0' THEN Z3N_RPSNOR
                WHEN Z3A_PRIORI = '3'
                AND Z3A_STATUS = '0' THEN Z3N_RPSALT
                WHEN Z3A_PRIORI = '4'
                AND Z3A_STATUS = '0' THEN Z3N_RPSURG
                WHEN Z3A_PRIORI = '1' THEN Z3N_RESBAI
                WHEN Z3A_PRIORI = '2' THEN Z3N_RESNOR
                WHEN Z3A_PRIORI = '3' THEN Z3N_RESALT
                WHEN Z3A_PRIORI = '4' THEN Z3N_RESURG
                ELSE NULL
            END AS TEMPO_SLA,
            (
                SELECT
                    TOP 1 ISNULL(
                        CAST(
                            CAST(Z3C_MENSAG AS VARBINARY(8000)) AS VARCHAR(8000)
                        ),
                        ''
                    )
                FROM
                    Z3C010
                WHERE
                    Z3C_IDTICK = Z3A.Z3A_ID
                ORDER BY
                    Z3C_ID DESC
            ) AS ULTIMA_MENSAGEM,
            Z3K_NOME NOME_GRUPO,
            (SELECT COUNT(Z3C_ID) FROM Z3C010 LEFT JOIN Z3F010 ON Z3F_EMAIL = Z3C_REMETE WHERE Z3C_IDTICK = Z3A.Z3A_ID AND Z3F_TYPE = '2') AS CONTAGEM_TOUCHS,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z3A010 Z3A
            LEFT JOIN Z3F010 Z3F ON Z3A_IDUSER = Z3F_ID
            AND Z3F.D_E_L_E_T_ = ''
            LEFT JOIN Z3H010 Z3H ON Z3F_ORGANI = Z3H_ID
            AND Z3H.D_E_L_E_T_ = ''
            LEFT JOIN Z3I010 Z3I ON Z3I_ID = Z3A_IDUSER
            AND Z3I.D_E_L_E_T_ = ''
            LEFT JOIN Z3O010 Z3O ON Z3O_ORGID = Z3H_ID
            AND Z3O.D_E_L_E_T_ = ''
            LEFT JOIN Z3N010 Z3N ON Z3N_ID = Z3O_SLAID
            AND Z3N.D_E_L_E_T_ = ''
            LEFT JOIN Z3K010 ON Z3K_ID = Z3A_GRUPO
        WHERE
            Z3A.D_E_L_E_T_ = ''
            AND (
                %Exp:cQueueWhere%
                OR (
                    (
                        %Exp:cFilter% = ''
                        OR UPPER(Z3A_ASSUNT) LIKE UPPER('%' || %Exp:cFilter% || '%')
                    )
                    AND (
                        %Exp:cRequesterId% = ''
                        OR Z3F_ID = %Exp:cRequesterId%
                    )
                    AND (
                        %Exp:cQueueId% = ''
                        OR UPPER(Z3A_IDFILA) LIKE UPPER('%' || %Exp:cQueueId% || '%')
                    )
                    AND (
                        %Exp:cOrganizationId% = ''
                        OR UPPER(Z3H_ID) LIKE UPPER('%' || %Exp:cOrganizationId% || '%')
                    )
                    AND (
                        %Exp:cAssigned% = ''
                        OR UPPER(Z3A_ATRIBU) LIKE UPPER('%' || %Exp:cAssigned% || '%')
                    )
					AND (
                        %Exp:cFollower% = ''
                        OR UPPER(Z3A_SEGUID) LIKE UPPER('%' || %Exp:cFollower% || '%')
                    )
                    AND (
                        %Exp:cInitialDate% = ''
                        OR Z3A_DATA > %Exp:cInitialDate%
                    )
                    AND (
                        %Exp:cEndDate% = ''
                        OR Z3A_DATA < %Exp:cEndDate%
                    )
                )
            )
        ORDER BY
            Z3A_ID OFFSET %Exp:offset% ROWS FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total']   := SQL_TICKETS->TOTAL
	oResponse['hasNext'] := SQL_TICKETS->TOTAL > page * pageSize

	// Itera sobre os registros
	While !SQL_TICKETS->(EoF())
		If Z3F->(MsSeek(xFilial("Z3F")+SQL_TICKETS->Z3F_ID) )
			RecLock("Z3F", .F.)
				oItem[ 'requesterPhoto' ] := Alltrim(Z3F->Z3F_PHOTO)
			Z3F->(MsUnlock())
		EndIf
		Z3F->(DbCloseArea())

		oItem[ 'id' ]               := Alltrim(SQL_TICKETS->Z3A_ID)
		oItem[ 'status' ]           := Alltrim(SQL_TICKETS->Z3A_STATUS)
		oItem[ 'priority' ]         := Alltrim(SQL_TICKETS->Z3A_PRIORI)
		oItem[ 'criticality' ]      := Alltrim(SQL_TICKETS->Z3A_CRITIC)
		oItem[ 'date' ]             := Year2Str(stod(SQL_TICKETS->Z3A_DATA)) + "-" + Month2Str(stod(SQL_TICKETS->Z3A_DATA)) + "-" + Day2Str(stod(SQL_TICKETS->Z3A_DATA))
		oItem[ 'hour' ]             := SQL_TICKETS->Z3A_HORA
		oItem[ 'closingDate' ]      := IIF(EMPTY(SQL_TICKETS->DATA_FECHAMENTO), '' , Day2Str(stod(SQL_TICKETS->DATA_FECHAMENTO)) + "/" + Month2Str(stod(SQL_TICKETS->DATA_FECHAMENTO)) + "/" + Year2Str(stod(SQL_TICKETS->DATA_FECHAMENTO)))
		oItem[ 'closingHour' ]      := SQL_TICKETS->HORA_FECHAMENTO
		oItem[ 'requesterId' ]      := Alltrim(SQL_TICKETS->Z3A_IDSOL)
		oItem[ 'originId' ]         := Alltrim(SQL_TICKETS->Z3A_IDORG)
		oItem[ 'subject' ]          := Alltrim(SQL_TICKETS->ASSUNTO)
		oItem[ 'operator' ]         := Alltrim(SQL_TICKETS->Z3A_OPERAT)
		oItem[ 'lastActivity' ]     := Alltrim(SQL_TICKETS->Z3A_ULTATI)
		oItem[ 'assignedName' ]     := Alltrim(SQL_TICKETS->NOME_ATRIBUIDO)
		oItem[ 'assigned' ]         := Alltrim(SQL_TICKETS->Z3A_ATRIBU)
		oItem[ 'serviceType' ]      := Alltrim(SQL_TICKETS->Z3A_TPATEN)
		oItem[ 'group' ]            := Alltrim(SQL_TICKETS->Z3A_GRUPO)
		oItem[ 'groupName' ]        := Alltrim(SQL_TICKETS->NOME_GRUPO)
		oItem[ 'technologyType' ]   := Alltrim(SQL_TICKETS->Z3A_TPTECH)
		oItem[ 'type' ]             := Alltrim(SQL_TICKETS->Z3A_TIPO)
		oItem[ 'downtime' ]         := Alltrim(SQL_TICKETS->Z3A_INDISP)
		oItem[ 'requesterName' ]    := Alltrim(SQL_TICKETS->Z3F_NAME)
		oItem[ 'localizationName' ] := Alltrim(SQL_TICKETS->NOME_LOCALIDADE)
		oItem[ 'organizationName' ] := Alltrim(SQL_TICKETS->Z3H_NOME)
		oItem[ 'satisfaction' ]     := Alltrim(SQL_TICKETS->Z3A_SATISF)
		oItem[ 'slaMetric' ]        := SQL_TICKETS->TEMPO_SLA / 60
		oItem[ 'touchs' ]           := SQL_TICKETS->CONTAGEM_TOUCHS
		oItem[ 'timeToFinish' ]     := IIF(Empty(SQL_TICKETS->DATA_FECHAMENTO), 0, (SubtHoras(stod(SQL_TICKETS->Z3A_DATA), LEFT(SQL_TICKETS->Z3A_HORA, 5), stod(SQL_TICKETS->DATA_FECHAMENTO), LEFT(SQL_TICKETS->HORA_FECHAMENTO, 5), .T.) * 60) - getTempoPausado(oItem[ 'id' ]))
		oItem[ 'violatedTime' ]     := IIF(oItem[ 'timeToFinish' ] - oItem[ 'slaMetric' ] <= 0, '' , oItem[ 'timeToFinish' ] - oItem[ 'slaMetric' ])
		oItem[ 'lastMessage' ]      := Alltrim(SQL_TICKETS->ULTIMA_MENSAGEM)

		If Alltrim(SQL_TICKETS->OCORRENCIAS) != ''
			aOccurrences := StrTokArr(Alltrim(SQL_TICKETS->OCORRENCIAS), ';')

			oItem[ 'occurrences' ] := aOccurrences
		EndIf


		cTempoFormatado := "No Prazo"

		If SQL_TICKETS->Z3A_STATUS != '2' .AND. SQL_TICKETS->Z3A_STATUS != '4' .AND. SQL_TICKETS->Z3A_STATUS != '5'//Encerrado
			// Calcula tempo restante do SLA
			nSLAEmSegundos                         := SQL_TICKETS->TEMPO_SLA
			nTempoDecorridoDesdeAbertura           := SubtHoras(stod(SQL_TICKETS->Z3A_DATA), LEFT(SQL_TICKETS->Z3A_HORA, 5), Date(), Time(), .T.)
			nTempoDecorridoDesdeAberturaEmSegundos := nTempoDecorridoDesdeAbertura * 3600
			nTempoPausado                          := getTempoPausado(oItem[ 'id' ])
			nTempoExtrapolado                      := (nTempoDecorridoDesdeAberturaEmSegundos - nTempoPausado) - nSLAEmSegundos

			If nTempoExtrapolado >= 0
				If nTempoExtrapolado < 60
					cTempoFormatado := AllTrim(Str(Int(nTempoExtrapolado))) + " s"
				ElseIf nTempoExtrapolado < 3600
					cTempoFormatado := AllTrim(Str(Int(nTempoExtrapolado / 60))) + " m"
				ElseIf nTempoExtrapolado < 86400
					cTempoFormatado := AllTrim(Str(Int(nTempoExtrapolado / 3600))) + " h"
				Else
					cTempoFormatado := AllTrim(Str(Int(nTempoExtrapolado / 86400))) + " d"
				EndIf
			EndIf
		EndIf


		oItem['sla'] := cTempoFormatado

		aAdd(aItems, oItem)
		oItem := JsonObject():New()
		SQL_TICKETS->(DbSkip())
	EndDo

	SQL_TICKETS->(DbCloseArea())
	oResponse['items'] := aItems

Return oResponse

method GetSlaTickets(cSlaId, cInitialDate, cEndDate) class ArgusModel
	local oResponse := JsonObject():New()
	local nIndex := 1
	local nJIndex := 1
	local aOrganizations := {}

	oResponse['tickets'] := {}
	oResponse['backlog'] := {}
	oResponse['updates'] := {}

	aOrganizations := StrTokArr(Alltrim(cSlaId), ';')


	While nIndex <= len(aOrganizations) .OR. (len(aOrganizations) == 0 .AND. nIndex == 1)

		cOrganizationId := IIF(len(aOrganizations) == 0, '', aOrganizations[nIndex])

		aTickets := ::GetTickets(1, 9999, '', '', '', cOrganizationId, '', cInitialDate, cEndDate)['items']
		aBacklog := ::GetBacklogData(cOrganizationId, cInitialDate, cEndDate)
		aUpdates := ::getAgentsUpdates(cOrganizationId, cInitialDate, cEndDate)

		If len(aTickets) > 0
			For nJIndex := 1 to len(aTickets)
				aadd(oResponse['tickets'], aTickets[nJIndex])
			Next
		EndIf

		If len(aBacklog) > 0
			For nJIndex := 1 to len(aBacklog)
				aadd(oResponse['backlog'], aBacklog[nJIndex])
			Next
		EndIf

		If len(aUpdates) > 0
			For nJIndex := 1 to len(aUpdates)
				aadd(oResponse['updates'], aUpdates[nJIndex])
			Next
		EndIf

		nIndex++
	EndDo

Return oResponse

method GetBacklogData(cOrganizationId, cInitialDate, cEndDate) class ArgusModel
	local aItems := {}
	local oItem  := JsonObject():New()

	BeginSql alias "SQL_BACKLOG"
        SELECT
            COALESCE(StatusAtual.Status, Z3A.Z3A_STATUS) AS StatusFinal,
            COALESCE(MAX(Z3P.Z3P_DATINT), MAX(Z3A.Z3A_DATA)) AS MaxData,
            MAX(Z3A_GRUPO) AS GRUPO,
            MAX(Z3K_NOME) AS NOME_GRUPO,
            MAX(Z3P.Z3P_HORINT) AS MaxHora
        FROM
            Z3A010 Z3A
        LEFT JOIN Z3F010 Z3F ON Z3F.Z3F_ID = Z3A.Z3A_IDSOL
        LEFT JOIN Z3K010 Z3K ON Z3K.Z3K_ID = Z3A.Z3A_GRUPO
        LEFT JOIN Z3P010 Z3P ON Z3P.Z3P_IDTICK = Z3A.Z3A_ID
                            AND Z3P.D_E_L_E_T_ = ''
        OUTER APPLY (
            SELECT TOP 1 
                CAST(CAST(CASE 
                            WHEN Z3PSub.Z3P_DATINT <= GETDATE() 
                                THEN Z3PSub.Z3P_VALNOV 
                            ELSE Z3PSub.Z3P_VALANT 
                        END AS VARBINARY(8000)) AS VARCHAR(8000)) AS Status
            FROM Z3P010 Z3PSub
            WHERE Z3PSub.Z3P_IDTICK = Z3A.Z3A_ID
            AND Z3PSub.Z3P_CAMPO = 'Z3A_STATUS'
            AND Z3PSub.D_E_L_E_T_ = ''
            ORDER BY 
                CASE WHEN Z3PSub.Z3P_DATINT <= GETDATE() THEN Z3PSub.Z3P_DATINT END DESC,
                CASE WHEN Z3PSub.Z3P_DATINT > GETDATE() THEN Z3PSub.Z3P_DATINT END ASC
        ) StatusAtual
        WHERE
            Z3A.D_E_L_E_T_ = ''
			AND (
				%Exp:cOrganizationId% = ''
				OR UPPER(Z3F_ORGANI) LIKE UPPER('%' || %Exp:cOrganizationId% || '%')
			)
            AND (
                %Exp:cInitialDate% = ''
                OR Z3A_DATA > %Exp:cInitialDate%
            )
            AND (
                %Exp:cEndDate% = ''
                OR Z3A_DATA < %Exp:cEndDate%
            )
        GROUP BY 
            Z3A.Z3A_ID,
            COALESCE(StatusAtual.Status, Z3A.Z3A_STATUS)
        ORDER BY 
            MaxData DESC, MaxHora DESC
	EndSql

	While !SQL_BACKLOG->(Eof())

		oItem['date'] := SQL_BACKLOG->MaxData
		oItem['group'] := Alltrim(SQL_BACKLOG->GRUPO)
		oItem['groupName'] := Alltrim(SQL_BACKLOG->NOME_GRUPO)
		oItem['status'] := alltrim(SQL_BACKLOG->StatusFinal)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_BACKLOG->(DbSkip())
	EndDo
	SQL_BACKLOG->(DbCloseArea())

return aItems

method getAgentsUpdates(cOrganizationId, cInitialDate, cEndDate) class ArgusModel
	local aItems := {}
	local oItem := JsonObject():New()

	BeginSql ALIAS "SQL_UPDATES"
        SELECT
            Z3C_ID,
            Z3C_PRIVAD,
            Z3C_DATA,
            Z3C_IDTICK
        FROM
            Z3C010
        WHERE
            D_E_L_E_T_ = ''
	EndSql

	While !SQL_UPDATES->(Eof())

		oItem[ 'id' ]        := SQL_UPDATES->Z3C_ID
		oItem[ 'isPrivate' ] := Alltrim(SQL_UPDATES->Z3C_PRIVAD)
		oItem[ 'ticketId' ]  := Alltrim(SQL_UPDATES->Z3C_IDTICK)
		oItem[ 'date' ]      := Year2Str(stod(SQL_UPDATES->Z3C_DATA)) + "-" + Month2Str(stod(SQL_UPDATES->Z3C_DATA)) + "-" + Day2Str(stod(SQL_UPDATES->Z3C_DATA))

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_UPDATES->(DbSkip())
	EndDo
	SQL_UPDATES->(DbCloseArea())

return aItems

static function getTempoPausado(cIdTicket)
	local nTempoPausado := 0
	local dInicio := nil
	local cHoraInicio := ""

	BeginSql alias "SQL_Z3P"
        SELECT
            Z3P_DATINT,
            Z3P_HORINT,
            ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS VALOR_ANTIGO,
            ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS VALOR_NOVO
        FROM
            Z3P010
        WHERE
            Z3P_IDTICK = %Exp:cIdTicket%
        AND
            Z3P_CAMPO = 'Z3A_STATUS'
        AND
            D_E_L_E_T_ = ''
        ORDER BY 
            Z3P_DATINT, 
            Z3P_HORINT
	EndSql

	While !SQL_Z3P->(EoF())
		// Se entrou no status 4, registra início
		If Alltrim(SQL_Z3P->VALOR_NOVO) == '2' .OR. Alltrim(SQL_Z3P->VALOR_NOVO) == '4' .OR. Alltrim(SQL_Z3P->VALOR_NOVO) == '5'
			dInicio := stod(SQL_Z3P->Z3P_DATINT)
			cHoraInicio := LEFT(SQL_Z3P->Z3P_HORINT, 5)
		EndIf

		// Se saiu do status 4, calcula diferença e soma
		If !Empty(dInicio) .and. (Alltrim(SQL_Z3P->VALOR_ANTIGO) == '2' .OR. Alltrim(SQL_Z3P->VALOR_ANTIGO) == '4' .OR. Alltrim(SQL_Z3P->VALOR_ANTIGO) == '5')
			nTempoPausado += SubtHoras(dInicio, cHoraInicio, stod(SQL_Z3P->Z3P_DATINT), LEFT(SQL_Z3P->Z3P_HORINT, 5), .T.) * 3600
			dInicio := nil
		EndIf

		SQL_Z3P->(DbSkip())
	EndDo
	SQL_Z3P->(DbCloseArea())

	// Se o último status ainda estiver em 4, calcula até agora
	If !Empty(dInicio)
		nTempoPausado += SubtHoras(dInicio, cHoraInicio, Date(), Time(), .T.) * 3600
	EndIf

Return nTempoPausado

method DoLogin(oLoginCredentials) class ArgusModel
	local oResponse := JsonObject():New()
	local cEmail := oLoginCredentials['email']
	local cPassword := oLoginCredentials['password']
	local oUserInfo := JsonObject():New()

	BeginSql Alias "SQL_LOGIN"
        SELECT
            Z3F_ID,
            Z3F_EMAIL,
            Z3F_NAME
        FROM
            Z3F010
        WHERE
            Z3F_Email = %Exp:cEmail%
        AND
            Z3F_PASS = %Exp:cPassword%
        AND 
            Z3F_STATUS = '1'
        AND
            D_E_L_E_T_ = ''
	EndSql

	If !SQL_LOGIN->(EoF())
		If Z3F->(MsSeek(xFilial("Z3F")+SQL_LOGIN->Z3F_ID) )
			RecLock("Z3F", .F.)
				oUserInfo[ 'photo' ] := Alltrim(Z3F->Z3F_PHOTO)
			Z3F->(MsUnlock())
		EndIf
		Z3F->(DbCloseArea())

		oUserInfo['id'] := Alltrim(SQL_LOGIN->Z3F_ID)
		oUserInfo['name'] := Alltrim(SQL_LOGIN->Z3F_NAME)
		oUserInfo['email'] := Alltrim(SQL_LOGIN->Z3F_EMAIL)

		oResponse['code'] := 200
		oResponse['message'] := "Usuario logado com sucesso!"
		oResponse['userInfo'] := oUserInfo
	Else
		oResponse['code'] := 404
		oResponse['message'] := "Email ou senha Incorretos"
	EndIf
	SQL_LOGIN->(DbCloseArea())

return oResponse

method DoAgentLogin(oLoginCredentials) class ArgusModel
	local oResponse := JsonObject():New()
	local cEmail := oLoginCredentials['email']
	local cPassword := oLoginCredentials['password']
	local oUserInfo := JsonObject():New()

	BeginSql Alias "SQL_LOGIN"
        SELECT
            Z3I_ID,
            Z3I_EMAIL,
            Z3I_NAME,
            Z3I_ACCESS,
            Z3I_GRUPO,
            ISNULL(CAST(CAST(Z3I_PHOTO AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS FOTO
        FROM
            Z3I010
        WHERE
            Z3I_Email = %Exp:cEmail%
        AND
            Z3I_PASS = %Exp:cPassword%
        AND
            D_E_L_E_T_ = ''
	EndSql

	If !SQL_LOGIN->(EoF())
		oUserInfo[ 'id' ]     := Alltrim(SQL_LOGIN->Z3I_ID)
		oUserInfo[ 'name' ]   := Alltrim(SQL_LOGIN->Z3I_NAME)
		oUserInfo[ 'email' ]  := Alltrim(SQL_LOGIN->Z3I_EMAIL)
		oUserInfo[ 'access' ] := Alltrim(SQL_LOGIN->Z3I_ACCESS)
		oUserInfo[ 'group' ]  := Alltrim(SQL_LOGIN->Z3I_GRUPO)
		oUserInfo[ 'photo' ]  := Alltrim(SQL_LOGIN->FOTO)

		oResponse['code'] := 200
		oResponse['message'] := "Usuario logado com sucesso!"
		oResponse['userInfo'] := oUserInfo
	Else
		oResponse['code'] := 404
		oResponse['message'] := "Email ou senha Incorretos"
	EndIf
	SQL_LOGIN->(DbCloseArea())

return oResponse

method GetAgentInfo(cAgentId) class ArgusModel
	local oResponse := JsonObject():New()
	local oUserInfo := JsonObject():New()

	BeginSql Alias "SQL_LOGIN"
        SELECT
            Z3I_ID,
            Z3I_EMAIL,
            Z3I_NAME,
            Z3I_ACCESS,
            Z3I_GRUPO,
            ISNULL(CAST(CAST(Z3I_PHOTO AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS FOTO
        FROM
            Z3I010
        WHERE
            Z3I_ID = %Exp:cAgentId%
        AND 
            D_E_L_E_T_ = ''
	EndSql

	If !SQL_LOGIN->(EoF())
		oUserInfo[ 'id' ]     := Alltrim(SQL_LOGIN->Z3I_ID)
		oUserInfo[ 'name' ]   := Alltrim(SQL_LOGIN->Z3I_NAME)
		oUserInfo[ 'email' ]  := Alltrim(SQL_LOGIN->Z3I_EMAIL)
		oUserInfo[ 'access' ] := Alltrim(SQL_LOGIN->Z3I_ACCESS)
		oUserInfo[ 'group' ]  := Alltrim(SQL_LOGIN->Z3I_GRUPO)
		oUserInfo[ 'photo' ]  := Alltrim(SQL_LOGIN->FOTO)

		oResponse['code'] := 200
		oResponse['message'] := "Usuario logado com sucesso!"
		oResponse['userInfo'] := oUserInfo
	Else
		oResponse['code'] := 404
		oResponse['message'] := "Id Incorreto"
	EndIf
	SQL_LOGIN->(DbCloseArea())

return oResponse

method GetUser(cId) class ArgusModel
	local oResponse      := JsonObject():New()
	local oUserInfo      := JsonObject():New()
	local aTags          := ""
	local aOrganizations := ""
	local aSubItems      := {}
	local oSubItem       := JsonObject():New()
	local nIndex         := 1

	BeginSql Alias "SQL_LOGIN"
        SELECT
            Z3F_ID,
            Z3F_NAME,
            Z3F_EMAIL,
            Z3F_TELEFO,
            Z3F_TYPE,
            Z3F_ACCESS,
            Z3F_ORGANI,
            Z3F_STATUS,
            Z3F_GRUPO,
            ISNULL(CAST(CAST(Z3F_DETAIL AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS DETALHES,
            ISNULL(CAST(CAST(Z3F_OBSERV AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS OBSERVACOES,
            ISNULL(CAST(CAST(Z3F_TAGS AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS TAGS
        FROM
            Z3F010
        WHERE
            Z3F_ID = %Exp:cId%
        AND
            D_E_L_E_T_ = ''
	EndSql

	If !SQL_LOGIN->(EoF())
		If Z3F->(MsSeek(xFilial("Z3F")+SQL_LOGIN->Z3F_ID) )
			RecLock("Z3F", .F.)
				oUserInfo[ 'signature' ] := Alltrim(Z3F->Z3F_ASSINA)
				oUserInfo[ 'photo' ] := Alltrim(Z3F->Z3F_PHOTO)
			Z3F->(MsUnlock())
		EndIf
		Z3F->(DbCloseArea())

		oUserInfo[ 'id' ]           := Alltrim(SQL_LOGIN->Z3F_ID)
		oUserInfo[ 'name' ]         := Alltrim(SQL_LOGIN->Z3F_NAME)
		oUserInfo[ 'email' ]        := Alltrim(SQL_LOGIN->Z3F_EMAIL)
		oUserInfo[ 'phone' ]        := Alltrim(SQL_LOGIN->Z3F_TELEFO)
		oUserInfo[ 'details' ]      := Alltrim(SQL_LOGIN->DETALHES)
		oUserInfo[ 'type' ]         := Alltrim(SQL_LOGIN->Z3F_TYPE)
		//oUserInfo[ 'organization' ] := Alltrim(SQL_LOGIN->Z3F_ORGANI)
		oUserInfo[ 'access' ]       := Alltrim(SQL_LOGIN->Z3F_ACCESS)
		oUserInfo[ 'observations' ] := Alltrim(SQL_LOGIN->OBSERVACOES)
		oUserInfo[ 'status' ]       := Alltrim(SQL_LOGIN->Z3F_STATUS)
		oUserInfo[ 'group' ]        := Alltrim(SQL_LOGIN->Z3F_GRUPO)
		oUserInfo[ 'contacts' ]     := ::GetUserContacts(SQL_LOGIN->Z3F_ID)

		aSubItems := {}
		If Alltrim(SQL_LOGIN->TAGS) != ''
			aTags := StrTokArr(SQL_LOGIN->TAGS, ';')
			For nIndex := 1 to len(aTags)
				oSubItem['id'] := aTags[nIndex]

				aadd(aSubItems, oSubItem)
				oSubItem := JsonObject():New()
			Next
			oUserInfo[ 'tags' ] := aSubItems
		EndIf

		aSubItems := {}
		If Alltrim(SQL_LOGIN->Z3F_ORGANI) != ''
			aOrganizations := StrTokArr(SQL_LOGIN->Z3F_ORGANI, ';')
			For nIndex := 1 to len(aOrganizations)
				oSubItem['id'] := aOrganizations[nIndex]

				aadd(aSubItems, oSubItem)
				oSubItem := JsonObject():New()
			Next
			oUserInfo[ 'organization' ] := aSubItems
		EndIf

		oResponse['code'] := 200
		oResponse['userInfo'] := oUserInfo
	Else
		oResponse['code'] := 404
		oResponse['message'] := "Usuario ou senha Incorretos"
	EndIf
	SQL_LOGIN->(DbCloseArea())

return oResponse

method GetUserContacts(cUserId) class ArgusModel
	local oContact  := JsonObject():New()
	local aContacts  := {}

	BeginSql Alias "SQL_CONTACTS"
        SELECT
            Z3Z_ID,
            Z3Z_CONTAT
        FROM
            Z3Z010
        WHERE
            Z3Z_IDUSUA = %Exp:cUserId%
        AND
            D_E_L_E_T_ = ''
	EndSql

	While !SQL_CONTACTS->(EoF())
		oContact[ 'id' ]      := Alltrim(SQL_CONTACTS->Z3Z_ID)
		oContact[ 'contact' ] := Alltrim(SQL_CONTACTS->Z3Z_CONTAT)

		aadd(aContacts, oContact)
		oContact := JsonObject():New()
		SQL_CONTACTS->(DbSkip())
	EndDo
	SQL_CONTACTS->(DbCloseArea())

return aContacts

method createUserContact(oUserData, cUserId) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z3Z", .T.)
		Z3Z->Z3Z_FILIAL := xFilial("Z3Z")
		Z3Z->Z3Z_ID     := NextNumero("Z3Z", 1, "Z3Z_ID", .T.)
		Z3Z->Z3Z_IDUSUA := cUserId
		Z3Z->Z3Z_CONTAT := getFieldData(Z3Z->Z3Z_CONTAT, oUserData[ 'contact' ])
	Z3Z->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse


method updateUserContact(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3Z->(DbSetOrder(1))
	If Z3Z->(MsSeek(xFilial("Z3Z")+oUserData['id']) )
		RecLock("Z3Z", .F.)
		Z3Z->Z3Z_CONTAT := oUserData[ 'contact' ]
		Z3Z->(MsUnlock())
	EndIf
	Z3Z->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method deleteUserContact(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3Z->(DbSetOrder(1))
	If Z3Z->(MsSeek(xFilial("Z3Z")+oUserData['id']) )
		RecLock("Z3Z", .F.)
		DbDelete()
		Z3Z->(MsUnlock())
	EndIf
	Z3Z->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method GetUsers(cId, page, pageSize, cFilter, cOrganizationId) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''
	Default cOrganizationId   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_USERS"
        SELECT
            Z3F_ID,
            Z3F_NAME,
            Z3F_EMAIL,
            Z3F_TELEFO,
            Z3F_REGDAT,
            Z3F_ACCESS,
            Z3F_ORGANI,
            Z3H_NOME,
            ISNULL(CAST(CAST(Z3F_OBSERV AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS OBSERVACOES,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z3F010 Z3F
        LEFT JOIN
            Z3H010 ON Z3H_ID = Z3F_ORGANI
        WHERE
            Z3F.D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z3F_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
                OR UPPER(Z3F_NAME) LIKE UPPER('%' + %Exp:cFilter% + '%')
                OR UPPER(Z3F_EMAIL) LIKE UPPER('%' + %Exp:cFilter% + '%')
                OR UPPER(Z3H_NOME) LIKE UPPER('%' + %Exp:cFilter% + '%')
            ) 
            AND (
                %Exp:cOrganizationId% = ''
                OR UPPER(Z3F_ORGANI) LIKE UPPER('%' + %Exp:cOrganizationId% + '%')
            )
        ORDER BY
            Z3F_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_USERS->TOTAL
	oResponse['hasNext'] := SQL_USERS->TOTAL > page * pageSize

	While !SQL_USERS->(EoF())
		If Z3F->(MsSeek(xFilial("Z3F")+SQL_USERS->Z3F_ID) )
			RecLock("Z3F", .F.)
				oItem[ 'photo' ] := Alltrim(Z3F->Z3F_PHOTO)
			Z3F->(MsUnlock())
		EndIf
		Z3F->(DbCloseArea())

		oItem[ 'id' ]           := Alltrim(SQL_USERS->Z3F_ID)
		oItem[ 'name' ]         := Alltrim(SQL_USERS->Z3F_NAME)
		oItem[ 'email' ]        := Alltrim(SQL_USERS->Z3F_EMAIL)
		oItem[ 'phone' ]        := Alltrim(SQL_USERS->Z3F_TELEFO)
		oItem[ 'registerDate' ] := year2Str(stod(SQL_USERS->Z3F_REGDAT)) + "-" + Month2Str(stod(SQL_USERS->Z3F_REGDAT)) + "-" + Day2Str(stod(SQL_USERS->Z3F_REGDAT))
		oItem[ 'access' ]       := Alltrim(SQL_USERS->Z3F_ACCESS)
		oItem[ 'organization' ] := Alltrim(SQL_USERS->Z3F_ORGANI)
		oItem[ 'observations' ] := Alltrim(SQL_USERS->OBSERVACOES)

		If SQL_USERS->Z3H_NOME == ''
			oItem[ 'organizationName' ] := "Sem Organização"
		Else
			oItem[ 'organizationName' ] := Alltrim(SQL_USERS->Z3H_NOME)
		EndIf

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_USERS->(DbSkip())
	EndDo
	SQL_USERS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetAgents(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_AGENTS"
        SELECT
            Z3F_ID,
            Z3F_NAME,
            Z3F_EMAIL,
            Z3F_TELEFO,
            Z3F_ACCESS,
            Z3F_TYPE,
            Z3F_GRUPO,
            Z3K_NOME,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z3F010 Z3F
        LEFT JOIN
            Z3K010 ON Z3K_ID = Z3F_GRUPO
        WHERE
            Z3F.D_E_L_E_T_ = ''
            AND Z3F_TYPE = '2'
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z3F_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
        ORDER BY
            Z3F_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_AGENTS->TOTAL
	oResponse['hasNext'] := SQL_AGENTS->TOTAL > page * pageSize

	While !SQL_AGENTS->(EoF())
		If Z3F->(MsSeek(xFilial("Z3F")+SQL_AGENTS->Z3F_ID) )
			RecLock("Z3F", .F.)
				oItem[ 'signature' ] := Alltrim(Z3F->Z3F_ASSINA)
				oItem[ 'photo' ] := Alltrim(Z3F->Z3F_PHOTO)
			Z3F->(MsUnlock())
		EndIf
		Z3F->(DbCloseArea())

		oItem[ 'id' ]            := Alltrim(SQL_AGENTS->Z3F_ID)
		oItem[ 'name' ]          := Alltrim(SQL_AGENTS->Z3F_NAME)
		oItem[ 'email' ]         := Alltrim(SQL_AGENTS->Z3F_EMAIL)
		oItem[ 'phone' ]         := Alltrim(SQL_AGENTS->Z3F_TELEFO)
		oItem[ 'type' ]        := Alltrim(SQL_AGENTS->Z3F_TYPE)
		oItem[ 'access' ]        := Alltrim(SQL_AGENTS->Z3F_ACCESS)
		oItem[ 'group' ]         := Alltrim(SQL_AGENTS->Z3F_GRUPO)
		oItem[ 'groupName' ]     := Alltrim(SQL_AGENTS->Z3K_NOME)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_AGENTS->(DbSkip())
	EndDo
	SQL_AGENTS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetOrg(cId) class ArgusModel
	local oResponse   := JsonObject():New()
	local oItem       := JsonObject():New()
	local aSubItems   := {}
	local oSubItem    := JsonObject():New()
	local nIndex      := 1
	local aTags       := {}

	BeginSql Alias "SQL_ORGANIZATION"
        SELECT
            Z3H_ID,
            Z3H_NOME,
            Z3H_GROUP,
            ISNULL(CAST(CAST(Z3H_OBSERV AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS OBSERVACOES,
            ISNULL(CAST(CAST(Z3H_DETAIL AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS DETALHES,
            Z3H_CGCCPF,
            Z3H_CONTRA,
            ISNULL(CAST(CAST(Z3H_CONNOT AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS NOTA_CONTRATO,
            Z3H_SERFOR,
            Z3H_ACCOUN,
            Z3H_PROJEC,
            Z3H_GROUP,
            Z3H_TECHLE,
            Z3H_CONTCO,
            Z3H_VALDAT,
            Z3H_OPERAT,
            Z3H_RESIDE,
            ISNULL(CAST(CAST(Z3H_PRODUC AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS PRODUTOS,
            ISNULL(CAST(CAST(Z3H_EQUIPM AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS EQUIPAMENTOS,
            ISNULL(CAST(CAST(Z3H_TAGS AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS TAGS,
            ISNULL(CAST(CAST(Z3H_DOMAIN AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS DOMAIN
        FROM
            Z3H010 Z3H
        WHERE
            Z3H.D_E_L_E_T_ = ''
        AND
            Z3H_ID = %Exp:cId%
        ORDER BY
            Z3H_ID DESC
	EndSql

	If !SQL_ORGANIZATION->(EoF())
		oItem[ 'id' ]               := Alltrim(SQL_ORGANIZATION->Z3H_ID)
		oItem[ 'name' ]             := Alltrim(SQL_ORGANIZATION->Z3H_NOME)
		oItem[ 'observations' ]     := Alltrim(SQL_ORGANIZATION->OBSERVACOES)
		oItem[ 'details' ]          := Alltrim(SQL_ORGANIZATION->DETALHES)
		oItem[ 'resolverGroup' ]    := Alltrim(SQL_ORGANIZATION->Z3H_GROUP)
		oItem[ 'cnpjCpf' ]          := Alltrim(SQL_ORGANIZATION->Z3H_CGCCPF)
		oItem[ 'contractNumber' ]   := Alltrim(SQL_ORGANIZATION->Z3H_CONTRA)
		oItem[ 'contractNotes' ]    := Alltrim(SQL_ORGANIZATION->NOTA_CONTRATO)
		oItem[ 'projectManager' ]   := Alltrim(SQL_ORGANIZATION->Z3H_PROJEC)
		oItem[ 'account' ]          := Alltrim(SQL_ORGANIZATION->Z3H_ACCOUN)
		oItem[ 'serviceFormat' ]    := Alltrim(SQL_ORGANIZATION->Z3H_SERFOR)
		oItem[ 'techLeader' ]       := Alltrim(SQL_ORGANIZATION->Z3H_TECHLE)
		oItem[ 'contractCoverage' ] := StrTokArr2(Alltrim(SQL_ORGANIZATION->Z3H_CONTCO), ';' )
		oItem[ 'operator' ]         := Alltrim(SQL_ORGANIZATION->Z3H_OPERAT)
		oItem[ 'resident' ]         := Alltrim(SQL_ORGANIZATION->Z3H_RESIDE)
		oItem[ 'domain' ]           := Alltrim(SQL_ORGANIZATION->DOMAIN)
		oItem[ 'equipments' ]       := Alltrim(SQL_ORGANIZATION->EQUIPAMENTOS)
		oItem[ 'products' ]         := Alltrim(SQL_ORGANIZATION->PRODUTOS)
		oItem[ 'validityDate' ]     := IIF(Empty(SQL_ORGANIZATION->Z3H_VALDAT), '', year2Str(stod(SQL_ORGANIZATION->Z3H_VALDAT)) + "-" + Month2Str(stod(SQL_ORGANIZATION->Z3H_VALDAT)) + "-" + Day2Str(stod(SQL_ORGANIZATION->Z3H_VALDAT)))
		oItem[ 'attachments' ]      := ::GetOrgXAttachments(SQL_ORGANIZATION->Z3H_ID)[ 'items' ]

		aSubItems := {}
		If Alltrim(SQL_ORGANIZATION->TAGS) != ''
			aTags := StrTokArr(SQL_ORGANIZATION->TAGS, ';')
			For nIndex := 1 to len(aTags)
				oSubItem['id'] := aTags[nIndex]

				aadd(aSubItems, oSubItem)
				oSubItem := JsonObject():New()
			Next
			oItem[ 'tags' ] := aSubItems
		EndIf

		oResponse['code'] := 200
		oResponse['organizationInfo'] := oItem
	Else
		oResponse['code'] := 404
		oResponse['message'] := "Organização nao encontrada"
	EndIf
	SQL_ORGANIZATION->(DbCloseArea())

return oResponse

method GetOrganizations(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_ORGANIZATIONS"
        SELECT
            Z3H_ID,
            Z3H_NOME,
            ISNULL(CAST(CAST(Z3H_OBSERV AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS OBSERVACOES,
            Z3H_CREATI,
            Z3H_ATUALI,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z3H010 Z3H
        WHERE
            Z3H.D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z3H_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
                OR UPPER(Z3H_NOME) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
        ORDER BY
            Z3H_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_ORGANIZATIONS->TOTAL
	oResponse['hasNext'] := SQL_ORGANIZATIONS->TOTAL > page * pageSize

	While !SQL_ORGANIZATIONS->(EoF())
		oItem[ 'id' ]              := Alltrim(SQL_ORGANIZATIONS->Z3H_ID)
		oItem[ 'name' ]            := Alltrim(SQL_ORGANIZATIONS->Z3H_NOME)
		oItem[ 'observations' ]    := Alltrim(SQL_ORGANIZATIONS->OBSERVACOES)
		oItem[ 'registerDate' ]    := year2Str(stod(SQL_ORGANIZATIONS->Z3H_CREATI)) + "-" + Month2Str(stod(SQL_ORGANIZATIONS->Z3H_CREATI)) + "-" + Day2Str(stod(SQL_ORGANIZATIONS->Z3H_CREATI))
		oItem[ 'lastUpdatedDate' ] := year2Str(stod(SQL_ORGANIZATIONS->Z3H_ATUALI)) + "-" + Month2Str(stod(SQL_ORGANIZATIONS->Z3H_ATUALI)) + "-" + Day2Str(stod(SQL_ORGANIZATIONS->Z3H_ATUALI))

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_ORGANIZATIONS->(DbSkip())
	EndDo
	SQL_ORGANIZATIONS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse


method GetSLAs(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_SLAS"
        SELECT
            Z3N_ID,
            Z3N_NOME,
            Z3N_DESCRI,
            Z3N_RPSBAI,
            Z3N_RPSNOR,
            Z3N_RPSALT,
            Z3N_RPSURG,
            Z3N_RPSBAF,
            Z3N_RPSNOF,
            Z3N_RPSALF,
            Z3N_RPSURF,
            Z3N_RESBAI,
            Z3N_RESNOR,
            Z3N_RESALT,
            Z3N_RESURG,
            Z3N_RESBAF,
            Z3N_RESNOF,
            Z3N_RESALF,
            Z3N_RESURF,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z3N010 Z3N
        WHERE
            Z3N.D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z3N_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
                OR UPPER(Z3N_NOME) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
        ORDER BY
            Z3N_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_SLAS->TOTAL
	oResponse['hasNext'] := SQL_SLAS->TOTAL > page * pageSize

	While !SQL_SLAS->(EoF())
		oItem[ 'id' ]            := Alltrim(SQL_SLAS->Z3N_ID)
		oItem[ 'name' ]          := Alltrim(SQL_SLAS->Z3N_NOME)
		oItem[ 'description' ]   := Alltrim(SQL_SLAS->Z3N_DESCRI)
		oItem[ 'organizations' ] := ::getSlaxOrgs(SQL_SLAS->Z3N_ID)['items']

		// ======================================================
		// Tempo da Primeira Resposta (em segundos) + formato
		// ======================================================
		oItem['firstResponseLow']       := SQL_SLAS->Z3N_RPSBAI
		oItem['firstResponseLowFormat'] := Alltrim(SQL_SLAS->Z3N_RPSBAF)
		oItem['firstResponseMedium']    := SQL_SLAS->Z3N_RPSNOR
		oItem['firstResponseMediumFormat'] := Alltrim(SQL_SLAS->Z3N_RPSNOF)
		oItem['firstResponseHigh']      := SQL_SLAS->Z3N_RPSALT
		oItem['firstResponseHighFormat']:= Alltrim(SQL_SLAS->Z3N_RPSALF)
		oItem['firstResponseUrgent']    := SQL_SLAS->Z3N_RPSURG
		oItem['firstResponseUrgentFormat'] := Alltrim(SQL_SLAS->Z3N_RPSURF)

		// ======================================================
		// Tempo para Concluir o Ticket / Resolução + formato
		// ======================================================
		oItem['resolutionLow']       := SQL_SLAS->Z3N_RESBAI
		oItem['resolutionLowFormat'] := Alltrim(SQL_SLAS->Z3N_RESBAF)
		oItem['resolutionMedium']    := SQL_SLAS->Z3N_RESNOR
		oItem['resolutionMediumFormat'] := Alltrim(SQL_SLAS->Z3N_RESNOF)
		oItem['resolutionHigh']      := SQL_SLAS->Z3N_RESALT
		oItem['resolutionHighFormat']:= Alltrim(SQL_SLAS->Z3N_RESALF)
		oItem['resolutionUrgent']    := SQL_SLAS->Z3N_RESURG
		oItem['resolutionUrgentFormat'] := Alltrim(SQL_SLAS->Z3N_RESURF)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_SLAS->(DbSkip())
	EndDo
	SQL_SLAS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse


method GetHistory(cTicketId) class ArgusModel
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	local nPos := 0
	local aFields    := { ;
		{"Z3A_STATUS", "Status"}, ;
		{"Z3A_ATRIBU", "Atribuido"}, ;
		{"Z3A_TIPO"  , "Tipo"}, ;
		{"Z3A_TPATEN", "Tipo De Serviço"}, ;
		{"Z3A_CRITIC", "Criticidade"}, ;
		{"Z3A_PRIORI", "Prioridade"}, ;
		{"Z3A_INDISP", "Indisponibilidade"}, ;
		{"Z3A_EQUIP" , "Equipamento"}, ;
		{"Z3A_CLASSI", "Classificação"}, ;
		{"Z3A_TECHLI", "Tecnico lider"}, ;
		{"Z3A_GRUPO" , "Grupo Solucionador"}, ;
		{"Z3A_IDFILA", "Fila"}, ;
		{"Z3A_PROTOC", "Protocolo Do Cliente"}, ;
		{"Z3A_TEMIND", "Tempo De Indisponibilidade"}, ;
		{"Z3A_DTVENC", "Data De Vencimento"}, ;
		{"Z3A_LOCALI", "Localidade"}, ;
		{"Z3A_ASSUNT", "Assunto"}, ;
		{"Z3A_IDSOL", "Solicitante"}, ;
		{"Z3A_TAGS", "Tags"}, ;
		{"Z3A_SEGUID", "Seguidores"}, ;
		{"Z3A_TPTECH", "Tipo De Tecnologia"} ;
		}

	BeginSql Alias "SQL_Z3P"
        SELECT
            Z3P_ID,
            Z3P_CAMPO,
            Z3P_IDOPER,
            CASE 
                WHEN Z3P_CAMPO = 'Z3A_STATUS' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '0' THEN 'Novo'
                        WHEN '1' THEN 'Aberto'
                        WHEN '2' THEN 'Pendente'
                        WHEN '3' THEN 'Em Espera'
                        WHEN '4' THEN 'Resolvido'
                        WHEN '5' THEN 'Fechado'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_TIPO' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Pergunta'
                        WHEN '2' THEN 'Incidente'
                        WHEN '3' THEN 'Problema'
                        WHEN '4' THEN 'Tarefa'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_TPATEN' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Remoto'
                        WHEN '2' THEN 'Presencial'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_CRITIC' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Consulta'
                        WHEN '2' THEN 'Baixa'
                        WHEN '3' THEN 'Média'
                        WHEN '4' THEN 'Alta'
                        WHEN '5' THEN 'Crítica'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_PRIORI' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Baixa'
                        WHEN '2' THEN 'Media'
                        WHEN '3' THEN 'Alta'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_INDISP' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'N/A'
                        WHEN '2' THEN 'Parcial'
                        WHEN '3' THEN 'Total'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_CLASSI' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Ordem De Serviço'
                        WHEN '2' THEN 'Preventiva'
                        WHEN '3' THEN 'Implantação'
                        WHEN '4' THEN 'Field'
                        WHEN '5' THEN 'Rotina Diaria'
                        WHEN '6' THEN 'Check-List'
                        WHEN '7' THEN 'N/A'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_TPTECH' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Telefonia (Voz)'
                        WHEN '2' THEN 'N/A'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_ATRIBU' THEN 
                    (SELECT TOP 1 Z3F_NAME
                    FROM Z3F010
                    WHERE Z3F_ID = ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_EQUIP' THEN 
                    (SELECT TOP 1 B1_DESC
                    FROM SB1010
                    WHERE B1_COD = ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(30)) AS VARCHAR(30)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_TECHLI' THEN 
                    (SELECT TOP 1 Z3F_NAME
                    FROM Z3F010
                    WHERE Z3F_ID = ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_GRUPO' THEN 
                    (SELECT TOP 1 Z3K_NOME
                    FROM Z3K010
                    WHERE Z3K_ID = ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_IDFILA' THEN 
                    (SELECT TOP 1 Z3L_NOME
                    FROM Z3L010
                    WHERE Z3L_ID = ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_LOCALI' THEN 
                    (SELECT TOP 1 CC2_MUN
                    FROM CC2010
                    WHERE CC2_CODMUN = ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                ELSE ISNULL(CAST(CAST(Z3P_VALANT AS VARBINARY(8000)) AS VARCHAR(8000)),'')
            END AS VALOR_ANTIGO,
            
            CASE 
                WHEN Z3P_CAMPO = 'Z3A_STATUS' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '0' THEN 'Novo'
                        WHEN '1' THEN 'Aberto'
                        WHEN '2' THEN 'Pendente'
                        WHEN '3' THEN 'Em Espera'
                        WHEN '4' THEN 'Resolvido'
                        WHEN '5' THEN 'Fechado'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_TIPO' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Pergunta'
                        WHEN '2' THEN 'Incidente'
                        WHEN '3' THEN 'Problema'
                        WHEN '4' THEN 'Tarefa'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_TPATEN' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Remoto'
                        WHEN '2' THEN 'Presencial'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_CRITIC' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Consulta'
                        WHEN '2' THEN 'Baixa'
                        WHEN '3' THEN 'Média'
                        WHEN '4' THEN 'Alta'
                        WHEN '5' THEN 'Crítica'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_PRIORI' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Baixa'
                        WHEN '2' THEN 'Media'
                        WHEN '3' THEN 'Alta'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_INDISP' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'N/A'
                        WHEN '2' THEN 'Parcial'
                        WHEN '3' THEN 'Total'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_CLASSI' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Ordem De Serviço'
                        WHEN '2' THEN 'Preventiva'
                        WHEN '3' THEN 'Implantação'
                        WHEN '4' THEN 'Field'
                        WHEN '5' THEN 'Rotina Diaria'
                        WHEN '6' THEN 'Check-List'
                        WHEN '7' THEN 'N/A'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_TPTECH' THEN 
                    CASE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(1)) AS VARCHAR(1)),'')
                        WHEN '1' THEN 'Telefonia (Voz)'
                        WHEN '2' THEN 'N/A'
                        ELSE ''
                    END
                WHEN Z3P_CAMPO = 'Z3A_ATRIBU' THEN 
                    (SELECT TOP 1 Z3F_NAME
                    FROM Z3F010
                    WHERE Z3F_ID = ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_EQUIP' THEN 
                    (SELECT TOP 1 B1_DESC
                    FROM SB1010
                    WHERE B1_COD = ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(30)) AS VARCHAR(30)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_TECHLI' THEN 
                    (SELECT TOP 1 Z3F_NAME
                    FROM Z3F010
                    WHERE Z3F_ID = ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_GRUPO' THEN 
                    (SELECT TOP 1 Z3K_NOME
                    FROM Z3K010
                    WHERE Z3K_ID = ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_IDFILA' THEN 
                    (SELECT TOP 1 Z3L_NOME
                    FROM Z3L010
                    WHERE Z3L_ID = ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                WHEN Z3P_CAMPO = 'Z3A_LOCALI' THEN 
                    (SELECT TOP 1 CC2_MUN
                    FROM CC2010
                    WHERE CC2_CODMUN = ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(6)) AS VARCHAR(6)),'')
                    AND D_E_L_E_T_ = '')
                ELSE ISNULL(CAST(CAST(Z3P_VALNOV AS VARBINARY(8000)) AS VARCHAR(8000)),'')
            END AS VALOR_NOVO,
            Z3P_DATINT,
            Z3P_HORINT,
            Z3F_NAME
        FROM
            Z3P010 Z3P
        LEFT JOIN
            Z3F010 Z3F ON Z3F_ID = Z3P_IDOPER AND Z3F.D_E_L_E_T_ = ''
        WHERE
            Z3P.D_E_L_E_T_ = ''
            AND Z3P_IDTICK = %Exp:cTicketId%
        ORDER BY
            Z3P_DATINT,
            Z3P_HORINT
	EndSql

	While !SQL_Z3P->(EoF())
		nPos := aScan(aFields, {|x| x[1] == Alltrim(SQL_Z3P->Z3P_CAMPO)})

		oItem[ 'id' ]             := Alltrim(SQL_Z3P->Z3P_ID)
		oItem[ 'field' ]          := EncodeUTF8(Alltrim(aFields[nPos][2]))
		oItem[ 'operatorId' ]     := Alltrim(SQL_Z3P->Z3P_IDOPER)
		oItem[ 'operatorName' ]   := Alltrim(SQL_Z3P->Z3F_NAME)
		oItem[ 'oldValue' ]       := Alltrim(SQL_Z3P->VALOR_ANTIGO)
		oItem[ 'newValue' ]       := Alltrim(SQL_Z3P->VALOR_NOVO)
		oItem[ 'interationDate' ] := year2Str(stod(SQL_Z3P->Z3P_DATINT)) + "-" + Month2Str(stod(SQL_Z3P->Z3P_DATINT)) + "-" + Day2Str(stod(SQL_Z3P->Z3P_DATINT))
		oItem[ 'interationHour' ] := Alltrim(SQL_Z3P->Z3P_HORINT)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_Z3P->(DbSkip())
	EndDo
	SQL_Z3P->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse


method GetQueues(cId, page, pageSize, cFilter, cGroupId) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter  := ''
	Default cGroupId := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_QUEUES"
        SELECT
            Z3L.Z3L_ID,
            Z3L.Z3L_NOME,
            Z3L.Z3L_ICONE,
			Z3L.Z3L_ORDEM,
			Z3L.Z3L_COLUNA,
            ISNULL(
                CAST(
                    CAST(Z3L_GRUPOS AS VARBINARY(8000)) AS VARCHAR(8000)
                ),
                ''
            ) AS Z3L_GRUPOS,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z3L010 Z3L
            LEFT JOIN Z3A010 Z3A ON Z3A.Z3A_IDFILA = Z3L.Z3L_ID
            AND Z3A.D_E_L_E_T_ = ''
        WHERE
            Z3L.D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z3L.Z3L_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
            AND (
                %Exp:cId% = ''
                OR UPPER(Z3L.Z3L_ID) LIKE UPPER('%' + %Exp:cId% + '%')
            )
            AND (
                %Exp:cGroupId% = ''
                OR UPPER(
                    ISNULL(
                        CAST(
                            CAST(Z3L_GRUPOS AS VARBINARY(8000)) AS VARCHAR(8000)
                        ),
                        ''
                    )
                ) LIKE UPPER('%' + %Exp:cGroupId% + '%')
            )
        GROUP BY
            Z3L.Z3L_ID,
            Z3L.Z3L_NOME,
            Z3L.Z3L_ICONE,
            Z3L.Z3L_GRUPOS,
			Z3L.Z3L_ORDEM,
			Z3L.Z3L_COLUNA
        ORDER BY
            Z3L.Z3L_ORDEM ASC 
		OFFSET %Exp:offset% ROWS FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_QUEUES->TOTAL
	oResponse['hasNext'] := SQL_QUEUES->TOTAL > page * pageSize

	While !SQL_QUEUES->(EoF())
		oItem[ 'id' ]   := Alltrim(SQL_QUEUES->Z3L_ID)
		oItem[ 'name' ] := Alltrim(SQL_QUEUES->Z3L_NOME)
		oItem[ 'icon' ] := Alltrim(SQL_QUEUES->Z3L_ICONE)
		oItem[ 'allConditions' ] := ::getQueuesXConditions(SQL_QUEUES->Z3L_ID, '1')['items']
		oItem[ 'anyConditions' ] := ::getQueuesXConditions(SQL_QUEUES->Z3L_ID, '2')['items']
		oItem[ 'availableTo' ] := StrTokArr2(Alltrim(SQL_QUEUES->Z3L_GRUPOS), ";", .T. )
		oItem[ 'count' ] := len(::GetTickets(page, pageSize, cFilter, '', SQL_QUEUES->Z3L_ID)['items'])
		oItem[ 'columns' ] := StrTokArr(Alltrim(SQL_QUEUES->Z3L_COLUNA), ';')

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_QUEUES->(DbSkip())
	EndDo
	SQL_QUEUES->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method getQueuesXConditions(cQueueId, cMatch) class ArgusModel
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	local oCondition := JsonObject():New()
	local nPos       := 0
	local aFields    := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		}

	BeginSql Alias "SQL_QUEUESXCONDITIONS"
        SELECT
            Z3U_ID,
            Z3U_IDFILA,
            Z3U_CAMPO,
            Z3U_OPERAD,
            Z3U_VALOR,
            Z3U_MATCH
        FROM
            Z3U010 Z3U
        WHERE
            Z3U.D_E_L_E_T_ = ''
            AND Z3U_IDFILA = %Exp:cQueueId%
            AND Z3U_MATCH = %Exp:cMatch%
        ORDER BY
            Z3U_ID DESC
	EndSql

	While !SQL_QUEUESXCONDITIONS->(EoF())
		nPos := aScan(aFields, {|x| x[1] == Alltrim(SQL_QUEUESXCONDITIONS->Z3U_CAMPO)})

		oCondition[ 'value' ] := Alltrim(SQL_QUEUESXCONDITIONS->Z3U_VALOR)

		oItem[ 'id' ]       := Alltrim(SQL_QUEUESXCONDITIONS->Z3U_ID)
		oItem[ 'field' ]    := aFields[nPos][2]
		oItem[ 'operator' ] := Alltrim(SQL_QUEUESXCONDITIONS->Z3U_OPERAD)
		oItem[ 'value' ]    := oCondition

		aadd(aItems, oItem)
		oItem := JsonObject():New()
		oCondition := JsonObject():New()

		SQL_QUEUESXCONDITIONS->(DbSkip())
	EndDo
	SQL_QUEUESXCONDITIONS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse


method getTriXConditions(cQueueId, cMatch) class ArgusModel
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	local oCondition := JsonObject():New()
	local nPos       := 0
	local aFields    := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		{"Z3A_IDFILA" , "queue"}, ;
		{"Z3A_TIPO" , "category"}, ;
		{"Z3A_ATRIBU" , "assigned"}, ;
		{"Z3A_GRUPO" , "group"}, ;
		{"Z3A_CRITIC" , "criticality"}, ;
		}

	BeginSql Alias "SQL_TRIGGERSXCONDITIONS"
        SELECT
            Z3W_ID,
            Z3W_IDGATI,
            Z3W_CAMPO,
            Z3W_OPERAD,
            Z3W_VALOR,
            Z3W_MATCH
        FROM
            Z3W010 Z3W
        WHERE
            Z3W.D_E_L_E_T_ = ''
            AND Z3W_IDGATI = %Exp:cQueueId%
            AND Z3W_MATCH = %Exp:cMatch%
        ORDER BY
            Z3W_ID DESC
	EndSql

	While !SQL_TRIGGERSXCONDITIONS->(EoF())
		nPos := aScan(aFields, {|x| x[1] == Alltrim(SQL_TRIGGERSXCONDITIONS->Z3W_CAMPO)})

		oCondition[ 'value' ] := Alltrim(SQL_TRIGGERSXCONDITIONS->Z3W_VALOR)

		oItem[ 'id' ]       := Alltrim(SQL_TRIGGERSXCONDITIONS->Z3W_ID)
		oItem[ 'field' ]    := aFields[nPos][2]
		oItem[ 'operator' ] := Alltrim(SQL_TRIGGERSXCONDITIONS->Z3W_OPERAD)
		oItem[ 'value' ]    := oCondition

		aadd(aItems, oItem)
		oItem := JsonObject():New()
		oCondition := JsonObject():New()

		SQL_TRIGGERSXCONDITIONS->(DbSkip())
	EndDo
	SQL_TRIGGERSXCONDITIONS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse


method getAutXConditions(cQueueId, cMatch) class ArgusModel
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	local oCondition := JsonObject():New()
	local cField     := ""
	local nPos       := 0
	local aFields    := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		{"Z3A_IDFILA" , "queue"}, ;
		{"Z3A_TIPO" , "category"}, ;
		{"Z3A_ATRIBU" , "assigned"}, ;
		{"Z3A_GRUPO" , "group"}, ;
		{"Z3A_CRITIC" , "criticality"}, ;
		}

	BeginSql Alias "SQL_TRIGGERSXCONDITIONS"
        SELECT
            Z3X_ID,
            Z3X_IDAUTO,
            Z3X_CAMPO,
            Z3X_OPERAD,
            Z3X_VALOR,
            Z3X_MATCH
        FROM
            Z3X010 Z3X
        WHERE
            Z3X.D_E_L_E_T_ = ''
            AND Z3X_IDAUTO = %Exp:cQueueId%
            AND Z3X_MATCH = %Exp:cMatch%
        ORDER BY
            Z3X_ID DESC
	EndSql

	While !SQL_TRIGGERSXCONDITIONS->(EoF())
		If !(Alltrim(SQL_TRIGGERSXCONDITIONS->Z3X_CAMPO) $ "sts001;sts002;sts003;sts004;sts005;sts006")
			nPos := aScan(aFields, {|x| x[1] == Alltrim(SQL_TRIGGERSXCONDITIONS->Z3X_CAMPO)})
			cField := aFields[nPos][2]
		Else
			cField := Alltrim(SQL_TRIGGERSXCONDITIONS->Z3X_CAMPO)
		EndIf

		oCondition[ 'value' ] := Alltrim(SQL_TRIGGERSXCONDITIONS->Z3X_VALOR)

		oItem[ 'id' ]       := Alltrim(SQL_TRIGGERSXCONDITIONS->Z3X_ID)
		oItem[ 'field' ]    := cField
		oItem[ 'operator' ] := Alltrim(SQL_TRIGGERSXCONDITIONS->Z3X_OPERAD)
		oItem[ 'value' ]    := oCondition

		aadd(aItems, oItem)
		oItem := JsonObject():New()
		oCondition := JsonObject():New()

		SQL_TRIGGERSXCONDITIONS->(DbSkip())
	EndDo
	SQL_TRIGGERSXCONDITIONS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetMacros(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_MACROS"
        SELECT
            Z3M_ID,
            Z3M_NOME,
            Z3M_DATREG,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z3M010 Z3M
        WHERE
            Z3M.D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z3M_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
        ORDER BY
            Z3M_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_MACROS->TOTAL
	oResponse['hasNext'] := SQL_MACROS->TOTAL > page * pageSize

	While !SQL_MACROS->(EoF())
		If Z3M->(MsSeek(xFilial("Z3M")+SQL_MACROS->Z3M_ID) )
			RecLock("Z3M", .F.)
			oItem[ 'content' ] := Alltrim(Z3M_CONTEU)
			Z3M->(MsUnlock())
		EndIf
		Z3M->(DbCloseArea())

		oItem[ 'id' ]             := Alltrim(SQL_MACROS->Z3M_ID)
		oItem[ 'name' ]           := Alltrim(SQL_MACROS->Z3M_NOME)
		oItem[ 'dateOfRegister' ] := year2Str(stod(SQL_MACROS->Z3M_DATREG)) + "-" + Month2Str(stod(SQL_MACROS->Z3M_DATREG)) + "-" + Day2Str(stod(SQL_MACROS->Z3M_DATREG))

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_MACROS->(DbSkip())
	EndDo
	SQL_MACROS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse


method PostMacro(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z3M", .T.)
	Z3M->Z3M_FILIAL := xFilial("Z3M")
	Z3M->Z3M_ID     := NextNumero("Z3M", 1, "Z3M_ID", .T.)
	Z3M->Z3M_NOME   := getFieldData(Z3M->Z3M_NOME, oUserData[ 'name' ])
	Z3M->Z3M_DATREG := Date()
	Z3M->Z3M_CONTEU := getFieldData(Z3M->Z3M_CONTEU, oUserData[ 'content' ])
	Z3M->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PutMacro(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3M->(DbSetOrder(1))
	If Z3M->(MsSeek(xFilial("Z3M")+oUserData['id']) )
		RecLock("Z3M", .F.)
		Z3M->Z3M_NOME   := getFieldData(Z3M->Z3M_NOME, oUserData[ 'name' ])
		Z3M->Z3M_CONTEU := getFieldData(Z3M->Z3M_CONTEU, oUserData[ 'content' ])
		Z3M->(MsUnlock())
	EndIf
	Z3M->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method DeleteMacro(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3M->(DbSetOrder(1))
	If Z3M->(MsSeek(xFilial("Z3M")+oUserData['id']) )
		RecLock("Z3M", .F.)
		DBDelete()
		Z3M->(MsUnlock())
	EndIf
	Z3M->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method GetTags(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_TAGS"
        SELECT
            Z3J_ID,
            Z3J_NOME,
            (
                SELECT COUNT(Z3F_ID)
                FROM Z3F010
                WHERE Z3F010.D_E_L_E_T_ = ''
                AND (
                        Z3F_TAGS = Z3J.Z3J_ID
                        OR Z3F_TAGS LIKE Z3J.Z3J_ID + ';%'
                        OR Z3F_TAGS LIKE '%;' + Z3J.Z3J_ID
                        OR Z3F_TAGS LIKE '%;' + Z3J.Z3J_ID + ';%'
                    )
            ) AS QTDE_USUARIOS_USANDO,
            (
                SELECT COUNT(Z3H_ID)
                FROM Z3H010
                WHERE Z3H010.D_E_L_E_T_ = ''
                AND (
                        ISNULL(CAST(CAST(Z3H_TAGS AS VARBINARY(8000)) AS VARCHAR(8000)),'') = Z3J.Z3J_ID
                        OR ISNULL(CAST(CAST(Z3H_TAGS AS VARBINARY(8000)) AS VARCHAR(8000)),'') LIKE Z3J.Z3J_ID + ';%'
                        OR ISNULL(CAST(CAST(Z3H_TAGS AS VARBINARY(8000)) AS VARCHAR(8000)),'') LIKE '%;' + Z3J.Z3J_ID
                        OR ISNULL(CAST(CAST(Z3H_TAGS AS VARBINARY(8000)) AS VARCHAR(8000)),'') LIKE '%;' + Z3J.Z3J_ID + ';%'
                    )
            ) AS QTDE_ORGANIZACOES_USANDO,
            COUNT(*) OVER() AS TOTAL
        FROM Z3J010 Z3J
        WHERE Z3J.D_E_L_E_T_ = ''
        AND (
            %Exp:cFilter% = ''
            OR UPPER(Z3J_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
        )
        ORDER BY Z3J_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_TAGS->TOTAL
	oResponse['hasNext'] := SQL_TAGS->TOTAL > page * pageSize

	While !SQL_TAGS->(EoF())
		oItem[ 'id' ]                         := Alltrim(SQL_TAGS->Z3J_ID)
		oItem[ 'name' ]                       := Alltrim(SQL_TAGS->Z3J_NOME)
		oItem[ 'amountOfUsersUsing' ]         := SQL_TAGS->QTDE_USUARIOS_USANDO
		oItem[ 'amountOfOrganizationsUsing' ] := SQL_TAGS->QTDE_ORGANIZACOES_USANDO

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_TAGS->(DbSkip())
	EndDo
	SQL_TAGS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetArticles(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_ARTIGOS"
        SELECT
            Z3E_ID,
            Z3E_NAME,
            COUNT(*) OVER() AS TOTAL
        FROM Z3E010 Z3E
        WHERE Z3E.D_E_L_E_T_ = ''
        AND (
            %Exp:cFilter% = ''
            OR UPPER(Z3E_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
        )
        ORDER BY Z3E_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_ARTIGOS->TOTAL
	oResponse['hasNext'] := SQL_ARTIGOS->TOTAL > page * pageSize

	While !SQL_ARTIGOS->(EoF())
		If Z3E->(MsSeek(xFilial("Z3E")+SQL_ARTIGOS->Z3E_ID) )
			RecLock("Z3E", .F.)
				oItem[ 'content' ] := Alltrim(Z3E->Z3E_CONTEN)
			Z3E->(MsUnlock())
		EndIf
		Z3E->(DbCloseArea())

		oItem[ 'id' ]      := Alltrim(SQL_ARTIGOS->Z3E_ID)
		oItem[ 'name' ]    := Alltrim(SQL_ARTIGOS->Z3E_NAME)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_ARTIGOS->(DbSkip())
	EndDo
	SQL_ARTIGOS->(DbCloseArea())

	oResponse['items'] := aItems

	return oResponse

method GetAutomations(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_TRIGGERS"
        SELECT
            Z3R_ID,
            Z3R_NOME,
            Z3R_DATUAT,
            COUNT(*) OVER() AS TOTAL
        FROM 
            Z3R010 Z3R
        WHERE 
            Z3R.D_E_L_E_T_ = ''
        AND (
            %Exp:cFilter% = ''
            OR UPPER(Z3R_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
        )
        ORDER BY Z3R_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_TRIGGERS->TOTAL
	oResponse['hasNext'] := SQL_TRIGGERS->TOTAL > page * pageSize

	While !SQL_TRIGGERS->(EoF())
		oItem[ 'id' ]            := Alltrim(SQL_TRIGGERS->Z3R_ID)
		oItem[ 'name' ]          := Alltrim(SQL_TRIGGERS->Z3R_NOME)
		oItem[ 'allConditions' ] := ::getAutXConditions(SQL_TRIGGERS->Z3R_ID, '1' )[ 'items' ]
		oItem[ 'anyConditions' ] := ::getAutXConditions(SQL_TRIGGERS->Z3R_ID, '2' )[ 'items' ]
		oItem[ 'actions' ]       := ::GetActXAutomations(SQL_TRIGGERS->Z3R_ID)[ 'items' ]
		oItem[ 'lastUpdate' ]    := year2Str(stod(SQL_TRIGGERS->Z3R_DATUAT)) + "-" + Month2Str(stod(SQL_TRIGGERS->Z3R_DATUAT)) + "-" + Day2Str(stod(SQL_TRIGGERS->Z3R_DATUAT))

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_TRIGGERS->(DbSkip())
	EndDo
	SQL_TRIGGERS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse
method GetTriggers(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_TRIGGERS"
        SELECT
            Z3S_ID,
            Z3S_NOME,
            ISNULL(CAST(CAST(Z3S_DESCRI AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS DESCRICAO,
            Z3S_CATEGO,
            Z3S_DATUAT,
            COUNT(*) OVER() AS TOTAL
        FROM 
            Z3S010 Z3S
        WHERE 
            Z3S.D_E_L_E_T_ = ''
        AND (
            %Exp:cFilter% = ''
            OR UPPER(Z3S_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
        )
        ORDER BY Z3S_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_TRIGGERS->TOTAL
	oResponse['hasNext'] := SQL_TRIGGERS->TOTAL > page * pageSize

	While !SQL_TRIGGERS->(EoF())
		oItem[ 'id' ]            := Alltrim(SQL_TRIGGERS->Z3S_ID)
		oItem[ 'name' ]          := Alltrim(SQL_TRIGGERS->Z3S_NOME)
		oItem[ 'description' ]   := Alltrim(SQL_TRIGGERS->DESCRICAO)
		oItem[ 'category' ]      := Alltrim(SQL_TRIGGERS->Z3S_CATEGO)
		oItem[ 'allConditions' ] := ::getTriXConditions(SQL_TRIGGERS->Z3S_ID, '1' )[ 'items' ]
		oItem[ 'anyConditions' ] := ::getTriXConditions(SQL_TRIGGERS->Z3S_ID, '2' )[ 'items' ]
		oItem[ 'actions' ]       := ::GetActionsXTriggers(SQL_TRIGGERS->Z3S_ID)[ 'items' ]
		oItem[ 'lastUpdate' ]    := year2Str(stod(SQL_TRIGGERS->Z3S_DATUAT)) + "-" + Month2Str(stod(SQL_TRIGGERS->Z3S_DATUAT)) + "-" + Day2Str(stod(SQL_TRIGGERS->Z3S_DATUAT))

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_TRIGGERS->(DbSkip())
	EndDo
	SQL_TRIGGERS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetActionsXTriggers(cTriggerId) class ArgusModel
	local oResponse := JsonObject():New()
	local oEmail    := JsonObject():New()
	local oTicket   := JsonObject():New()
	local oItem     := JsonObject():New()
	local aItems    := {}
	local nPos                   := 1
	local aFields                := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		{"Z3A_IDFILA" , "queue"}, ;
		{"Z3A_TIPO" , "type"}, ;
		{"Z3A_PRIORI" , "priority"}, ;
		{"Z3A_TPATEN" , "serviceType"}, ;
		{"Z3A_CRITIC" , "criticality"}, ;
		{"Z3A_CLASSI" , "classification"}, ;
		{"Z3A_GRUPO" , "resolverGroup"};
		}

	BeginSql Alias "SQL_ACTIONSXCONDITIONS"
        SELECT
            Z3Y_ID,
            Z3Y_IDGATI,
            Z3Y_TIPO,
            Z3Y_VALOR,
            Z3Y_ASSUNT,
            Z3Y_CATDES,
            Z3Y_DESTIN,
            ISNULL(CAST(CAST(Z3Y_CONEMA AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS CONTEUDO,
            Z3Y_CAMPO
        FROM
            Z3Y010 Z3Y
        WHERE
            Z3Y.D_E_L_E_T_ = ''
            AND Z3Y_IDGATI = %Exp:cTriggerId%
        ORDER BY
            Z3Y_ID DESC
	EndSql

	While !SQL_ACTIONSXCONDITIONS->(EoF())
		nPos := aScan(aFields, {|x| x[1] == Alltrim(SQL_ACTIONSXCONDITIONS->Z3Y_CAMPO)})

		oItem[ 'id' ]   := Alltrim(SQL_ACTIONSXCONDITIONS->Z3Y_ID)
		oItem[ 'type' ] := Alltrim(SQL_ACTIONSXCONDITIONS->Z3Y_TIPO)

		If Alltrim(SQL_ACTIONSXCONDITIONS->Z3Y_TIPO) == '1'
			oEmail[ 'category' ]  := Alltrim(SQL_ACTIONSXCONDITIONS->Z3Y_CATDES)
			oEmail[ 'recipient' ] := SQL_ACTIONSXCONDITIONS->Z3Y_DESTIN
			oEmail[ 'subject' ]   := Alltrim(SQL_ACTIONSXCONDITIONS->Z3Y_ASSUNT)
			oEmail[ 'body' ]      := Alltrim(SQL_ACTIONSXCONDITIONS->CONTEUDO)

			oItem[ 'email' ] := oEmail
		Else
			oTicket['field'] := aFields[nPos][2]
			oTicket['value'] := Alltrim(SQL_ACTIONSXCONDITIONS->Z3Y_VALOR)

			oItem[ 'ticket' ] := oTicket
		EndIf

		aadd(aItems, oItem)
		oItem := JsonObject():New()
		oTicket := JsonObject():New()
		oEmail := JsonObject():New()

		SQL_ACTIONSXCONDITIONS->(DbSkip())
	EndDo
	SQL_ACTIONSXCONDITIONS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method GetActXAutomations(cTriggerId) class ArgusModel
	local oResponse := JsonObject():New()
	local oEmail    := JsonObject():New()
	local oTicket   := JsonObject():New()
	local oItem     := JsonObject():New()
	local aItems    := {}
	local nPos                   := 1
	local aFields                := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		{"Z3A_IDFILA" , "queue"}, ;
		{"Z3A_TIPO" , "type"}, ;
		{"Z3A_PRIORI" , "priority"}, ;
		{"Z3A_TPATEN" , "serviceType"}, ;
		{"Z3A_CRITIC" , "criticality"}, ;
		{"Z3A_CLASSI" , "classification"}, ;
		{"Z3A_GRUPO" , "resolverGroup"};
		}

	BeginSql Alias "SQL_ACTIONSXCONDITIONS"
        SELECT
            Z31_ID,
            Z31_IDAUTO,
            Z31_TIPO,
            Z31_VALOR,
            Z31_ASSUNT,
            Z31_CATDES,
            Z31_DESTIN,
            ISNULL(CAST(CAST(Z31_CONEMA AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS CONTEUDO,
            Z31_CAMPO
        FROM
            Z31010 Z31
        WHERE
            Z31.D_E_L_E_T_ = ''
            AND Z31_IDAUTO = %Exp:cTriggerId%
        ORDER BY
            Z31_ID DESC
	EndSql

	While !SQL_ACTIONSXCONDITIONS->(EoF())
		nPos := aScan(aFields, {|x| x[1] == Alltrim(SQL_ACTIONSXCONDITIONS->Z31_CAMPO)})

		oItem[ 'id' ]   := Alltrim(SQL_ACTIONSXCONDITIONS->Z31_ID)
		oItem[ 'type' ] := Alltrim(SQL_ACTIONSXCONDITIONS->Z31_TIPO)

		If Alltrim(SQL_ACTIONSXCONDITIONS->Z31_TIPO) == '1'
			oEmail[ 'category' ]  := Alltrim(SQL_ACTIONSXCONDITIONS->Z31_CATDES)
			oEmail[ 'recipient' ] := SQL_ACTIONSXCONDITIONS->Z31_DESTIN
			oEmail[ 'subject' ]   := Alltrim(SQL_ACTIONSXCONDITIONS->Z31_ASSUNT)
			oEmail[ 'body' ]      := Alltrim(SQL_ACTIONSXCONDITIONS->CONTEUDO)

			oItem[ 'email' ] := oEmail
		Else
			oTicket['field'] := aFields[nPos][2]
			oTicket['value'] := Alltrim(SQL_ACTIONSXCONDITIONS->Z31_VALOR)

			oItem[ 'ticket' ] := oTicket
		EndIf

		aadd(aItems, oItem)
		oItem := JsonObject():New()
		oTicket := JsonObject():New()
		oEmail := JsonObject():New()

		SQL_ACTIONSXCONDITIONS->(DbSkip())
	EndDo
	SQL_ACTIONSXCONDITIONS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse


method GetGroups(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_GROUPS"
        SELECT
            Z3K_ID,
            Z3K_NOME,
            Z3K_DESC,
            (SELECT COUNT(Z3F_ID) FROM Z3F010 Z3F WHERE Z3F.D_E_L_E_T_ = '' AND Z3F_GRUPO LIKE '%' + Z3K.Z3K_ID + '%') AS CONTAGEM_MEMBROS_USANDO,
            COUNT(*) OVER() AS TOTAL
        FROM
            Z3K010 Z3K
        WHERE
            Z3K.D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR UPPER(Z3K_ID) LIKE UPPER('%' + %Exp:cFilter% + '%')
            )
        ORDER BY
            Z3K_ID DESC
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_GROUPS->TOTAL
	oResponse['hasNext'] := SQL_GROUPS->TOTAL > page * pageSize

	While !SQL_GROUPS->(EoF())
		oItem[ 'id' ]   := Alltrim(SQL_GROUPS->Z3K_ID)
		oItem[ 'name' ] := Alltrim(SQL_GROUPS->Z3K_NOME)
		oItem[ 'description' ] := Alltrim(SQL_GROUPS->Z3K_DESC)
		oItem[ 'amountOfAgentsUsing' ] := SQL_GROUPS->CONTAGEM_MEMBROS_USANDO

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_GROUPS->(DbSkip())
	EndDo
	SQL_GROUPS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method PutUser(oUserData) class ArgusModel
	local oResponse := JsonObject():New()
	local cSubItems := ""
	local nIndex := 1

	Z3F->(DbSetOrder(1))
	If Z3F->(MsSeek(xFilial("Z3F")+oUserData['id']) )
		RecLock("Z3F", .F.)
		Z3F->Z3F_PASS   := getFieldData(Z3F->Z3F_PASS, oUserData[ 'password' ])
		Z3F->Z3F_PHOTO  := getFieldData(Z3F->Z3F_PHOTO, oUserData[ 'photo' ])
		Z3F->Z3F_NAME   := getFieldData(Z3F->Z3F_NAME, oUserData[ 'name' ])
		Z3F->Z3F_EMAIL  := getFieldData(Z3F->Z3F_EMAIL, oUserData[ 'email' ])
		Z3F->Z3F_TELEFO  := getFieldData(Z3F->Z3F_TELEFO, oUserData[ 'phone' ])
		Z3F->Z3F_TYPE   := getFieldData(Z3F->Z3F_TYPE, oUserData[ 'type' ])
		//Z3F->Z3F_ORGANI := getFieldData(Z3F->Z3F_ORGANI, oUserData[ 'organization' ])
		Z3F->Z3F_ACCESS := getFieldData(Z3F->Z3F_ACCESS, oUserData[ 'access' ])
		Z3F->Z3F_TIMEZO := getFieldData(Z3F->Z3F_TIMEZO, oUserData[ 'timezone' ])
		Z3F->Z3F_DETAIL := getFieldData(Z3F->Z3F_DETAIL, oUserData[ 'details' ])
		Z3F->Z3F_OBSERV := getFieldData(Z3F->Z3F_OBSERV, oUserData[ 'observations' ])
		Z3F->Z3F_GRUPO  := getFieldData(Z3F->Z3F_GRUPO, oUserData[ 'group' ])
		Z3F->Z3F_STATUS  := getFieldData(Z3F->Z3F_STATUS, oUserData[ 'status' ])
		Z3F->Z3F_ASSINA := getFieldData(Z3F->Z3F_ASSINA, oUserData[ 'signature' ])

		cSubItems := ""
		If oUserData[ 'tags' ] != nil
			For nIndex := 1 to Len(oUserData['tags'])
				cSubItems += oUserData['tags'][nIndex]['id']
				If nIndex < Len(oUserData['tags'])
					cSubItems += ";"
				EndIf
			Next

			Z3F->Z3F_TAGS := getFieldData(Z3F->Z3F_TAGS, cSubItems)             // ?? não existe o campo
		EndIf

		cSubItems := ""
		If oUserData[ 'organization' ] != nil
			For nIndex := 1 to Len(oUserData['organization'])
				cSubItems += oUserData['organization'][nIndex]['id']
				If nIndex < Len(oUserData['organization'])
					cSubItems += ";"
				EndIf
			Next

			Z3F->Z3F_ORGANI := getFieldData(Z3F->Z3F_ORGANI, cSubItems)             // ?? não existe o campo
		EndIf

		Z3F->(MsUnlock())

		If !Empty(oUserData['contacts'])
			For nIndex := 1 to len(oUserData['contacts'])
				If oUserData['contacts'][nIndex]['id'] == nil
					::createUserContact(oUserData['contacts'][nIndex], oUserData['id'])
				ElseIf oUserData['contacts'][nIndex]['id'] != nil .AND. oUserData['contacts'][nIndex]['removed'] == .F.
					::updateUserContact(oUserData['contacts'][nIndex])
				Else
					::deleteUserContact(oUserData['contacts'][nIndex])
				EndIf
			Next
		EndIf

		oResponse['code'] := 200
		oResponse['message'] := "item had been changed"
	Else
		//Cliente Nao localizado
	EndIf
	Z3F->(DbCloseArea())

return oResponse

method PutOrganization(oOrganizationData) class ArgusModel
	local oResponse := JsonObject():New()
	local nIndex := 1
	local cSubItems := ""

	Z3H->(DbSetOrder(1))
	If Z3H->(MsSeek(xFilial("Z3H")+oOrganizationData['id']) )
		RecLock("Z3H", .F.)
		Z3H->Z3H_OBSERV := getFieldData(Z3H->Z3H_OBSERV, oOrganizationData[ 'observations' ])
		Z3H->Z3H_DETAIL := getFieldData(Z3H->Z3H_DETAIL, oOrganizationData[ 'details' ])
		Z3H->Z3H_CGCCPF := getFieldData(Z3H->Z3H_CGCCPF, oOrganizationData[ 'cnpjCpf' ])
		Z3H->Z3H_CONNOT := getFieldData(Z3H->Z3H_CONNOT, oOrganizationData[ 'contractNotes' ])
		Z3H->Z3H_CONTRA := getFieldData(Z3H->Z3H_CONTRA, oOrganizationData[ 'contractNumber' ])
		Z3H->Z3H_PROJEC := getFieldData(Z3H->Z3H_PROJEC, oOrganizationData[ 'projectManager' ])
		Z3H->Z3H_ACCOUN := getFieldData(Z3H->Z3H_ACCOUN, oOrganizationData[ 'account' ])
		Z3H->Z3H_SERFOR := getFieldData(Z3H->Z3H_SERFOR, IIF(oOrganizationData[ 'serviceFormat' ] == nil, nil , oOrganizationData[ 'serviceFormat' ][ 'id' ]))
		Z3H->Z3H_GROUP  := getFieldData(Z3H->Z3H_GROUP, IIF(oOrganizationData[ 'resolverGroup' ] == nil, nil , oOrganizationData[ 'resolverGroup' ][ 'id' ]))
		Z3H->Z3H_TECHLE := getFieldData(Z3H->Z3H_TECHLE, oOrganizationData[ 'techLeader' ])
		Z3H->Z3H_OPERAT := getFieldData(Z3H->Z3H_OPERAT, oOrganizationData[ 'operator' ])
		Z3H->Z3H_RESIDE := getFieldData(Z3H->Z3H_RESIDE, oOrganizationData[ 'resident' ])
		Z3H->Z3H_DOMAIN := getFieldData(Z3H->Z3H_DOMAIN, oOrganizationData[ 'domain' ])
		Z3H->Z3H_PRODUC := getFieldData(Z3H->Z3H_PRODUC, oOrganizationData[ 'products' ])
		Z3H->Z3H_EQUIPM := getFieldData(Z3H->Z3H_EQUIPM, oOrganizationData[ 'equipments' ])
		//Z3H->Z3H_STATUS := getFieldData(Z3H->Z3H_STATUS, oOrganizationData[ 'status' ])
		Z3H->Z3H_ATUALI := Date()
		Z3H->Z3H_VALDAT := getFieldData(Z3H->Z3H_VALDAT, IIF(oOrganizationData[ 'validityDate' ] == nil, nil, stod(strTran(Left(oOrganizationData[ 'validityDate' ], 10), '-' ))))

		cSubItems := ""
		If oOrganizationData[ 'tags' ] != nil
			For nIndex := 1 to Len(oOrganizationData['tags'])
				cSubItems += oOrganizationData['tags'][nIndex]['id']
				If nIndex < Len(oOrganizationData['tags'])
					cSubItems += ";"
				EndIf
			Next

			Z3H->Z3H_TAGS := getFieldData(Z3H->Z3H_EQUIPM, cSubItems)             // ?? não existe o campo
		EndIf

		cSubItems := ""
		If oOrganizationData[ 'contractCoverage' ] != nil
			For nIndex := 1 to Len(oOrganizationData['contractCoverage'])
				cSubItems += oOrganizationData['contractCoverage'][nIndex]['id']
				If nIndex < Len(oOrganizationData['contractCoverage'])
					cSubItems += ";"
				EndIf
			Next

			Z3H->Z3H_CONTCO := getFieldData(Z3H->Z3H_CONTCO, cSubItems)             // ?? não existe o campo
		EndIf

		Z3H->(MsUnlock())

		oResponse['code'] := 200
		oResponse['message'] := "item had been changed"
	Else
		//Cliente Nao localizado
	EndIf
	Z3H->(DbCloseArea())

return oResponse

method PutAgent(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3I->(DbSetOrder(1))
	If Z3I->(MsSeek(xFilial("Z3I")+oUserData['id']) )
		RecLock("Z3I", .F.)
		Z3I->Z3I_FILIAL := xFilial("Z3I")
		Z3I->Z3I_NAME   := getFieldData(Z3I->Z3I_NAME, oUserData[ 'name' ])
		Z3I->Z3I_ACCESS := getFieldData(Z3I->Z3I_ACCESS, oUserData[ 'access' ])
		Z3I->Z3I_EMAIL := getFieldData(Z3I->Z3I_EMAIL, oUserData[ 'email' ])
		Z3I->Z3I_EMAIL := getFieldData(Z3I->Z3I_EMAIL, oUserData[ 'phone' ])
		Z3I->Z3I_GRUPO := getFieldData(Z3I->Z3I_GRUPO, IIF(oUserData[ 'group' ] == nil, nil , oUserData[ 'group' ][ 'id' ]))
		Z3I->Z3I_PHOTO  := getFieldData(Z3I->Z3I_PHOTO, oUserData[ 'photo' ])
		Z3I->Z3I_PASS  := getFieldData(Z3I->Z3I_PASS, oUserData[ 'password' ])
		Z3I->(MsUnlock())

		oResponse['code'] := 200
		oResponse['message'] := "item had been changed"
	Else
		//Cliente Nao localizado
	EndIf
	Z3I->(DbCloseArea())

return oResponse

method PostAgent(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z3I", .T.)
		Z3I->Z3I_FILIAL := xFilial("Z3I")
		Z3I->Z3I_ID     := NextNumero("Z3I", 1, "Z3I_ID", .T.)
		Z3I->Z3I_NAME   := getFieldData(Z3I->Z3I_NAME, oUserData[ 'name' ])
		Z3I->Z3I_ACCESS := getFieldData(Z3I->Z3I_ACCESS, oUserData[ 'access' ])
		Z3I->Z3I_EMAIL  := getFieldData(Z3I->Z3I_EMAIL, oUserData[ 'email' ])
		Z3I->Z3I_GRUPO := getFieldData(Z3I->Z3I_GRUPO, IIF(oUserData[ 'group' ] == nil, nil , oUserData[ 'group' ][ 'id' ]))
		Z3I->Z3I_PHOTO  := getFieldData(Z3I->Z3I_PHOTO, oUserData[ 'photo' ])
		Z3I->Z3I_PASS   := "123"
	Z3I->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method DeleteAgent(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3F->(DbSetOrder(1))
	If Z3F->(MsSeek(xFilial("Z3F")+oUserData['id']) )
		RecLock("Z3F", .F.)
		DbDelete()
		Z3F->(MsUnlock())

		oResponse['code'] := 200
		oResponse['message'] := "Agente Excluido"
	Else
		oResponse['code'] := 400
		oResponse['message'] := "Houve um erro na exclusao"
	EndIf
	Z3F->(DbCloseArea())

return oResponse

method DeleteOrganization(oBody) class ArgusModel
	local oResponse := JsonObject():New()

	Z3H->(DbSetOrder(1))
	If Z3H->(MsSeek(xFilial("Z3H")+oBody['id']) )
		RecLock("Z3H", .F.)
		DbDelete()
		Z3H->(MsUnlock())

		oResponse['code'] := 200
		oResponse['message'] := "item had been deleted"
	Else
		oResponse['code'] := 400
		oResponse['message'] := "Houve um erro na exclusao"
	EndIf
	Z3H->(DbCloseArea())

return oResponse

method PostUser(oUserData) class ArgusModel
	local oResponse := JsonObject():New()
	local cEmail := oUserData['email']
	local nIndex := 1

	BeginSql Alias "SQL_USERS"
        SELECT
            Z3F_ID
        FROM
            Z3F010
        WHERE
            Z3F_EMAIL = %Exp:cEmail%
        AND
            D_E_L_E_T_ = ''
	EndSql

	If SQL_USERS->(EoF())
		RecLock("Z3F", .T.)
			Z3F->Z3F_FILIAL := xFilial("Z3F")
			Z3F->Z3F_ID     := NextNumero("Z3F", 1, "Z3F_ID", .T.)
			Z3F->Z3F_PASS   := getFieldData(Z3F->Z3F_PASS, oUserData[ 'password' ])
			Z3F->Z3F_NAME   := getFieldData(Z3F->Z3F_NAME, oUserData[ 'name' ])
			Z3F->Z3F_TELEFO  := getFieldData(Z3F->Z3F_TELEFO, oUserData[ 'phone' ])
			Z3F->Z3F_EMAIL  := getFieldData(Z3F->Z3F_EMAIL, oUserData[ 'email' ])
			Z3F->Z3F_REGDAT := Date()
			Z3F->Z3F_ORGANI := getFieldData(Z3F->Z3F_ORGANI, oUserData[ 'organization' ])
			Z3F->Z3F_TYPE   := getFieldData(Z3F->Z3F_TYPE, oUserData[ 'type' ])
			Z3F->Z3F_ACCESS := getFieldData(Z3F->Z3F_ACCESS, oUserData[ 'access' ])
			Z3F->Z3F_GRUPO := getFieldData(Z3F->Z3F_GRUPO, oUserData[ 'group' ])
			Z3F->Z3F_ASSINA := getFieldData(Z3F->Z3F_ASSINA, oUserData[ 'signature' ])
			Z3F->Z3F_STATUS := '1'
		Z3F->(MsUnlock())

		If !Empty(oUserData['contacts'])
			For nIndex := 1 to len(oUserData['contacts'])
				If oUserData['contacts'][nIndex]['id'] == nil
					::createUserContact(oUserData['contacts'][nIndex], Z3F->Z3F_ID)
				EndIf
			Next
		EndIf

		oResponse['code'] := 200
		oResponse['message'] := "Usuario Criado!"
	Else
		oResponse['code'] := 400
		oResponse['message'] := "Esse email ja esta cadastrado!"
	EndIf
	SQL_USERS->(DbCloseArea())

return oResponse

method PostOrganization(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z3H", .T.)
	Z3H->Z3H_FILIAL := xFilial("Z3H")
	Z3H->Z3H_ID     := NextNumero("Z3H", 1, "Z3H_ID", .T.)
	Z3H->Z3H_CREATI := Date()
	Z3H->Z3H_ATUALI := Date()
	Z3H->Z3H_NOME   := getFieldData(Z3H->Z3H_NOME, oUserData[ 'name' ])
	Z3H->Z3H_DOMAIN := getFieldData(Z3H->Z3H_DOMAIN, oUserData[ 'domain' ])
	Z3H->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PostOccurrence(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z32", .T.)
	Z32->Z32_FILIAL := xFilial("Z32")
	Z32->Z32_ID     := NextNumero("Z32", 1, "Z32_ID", .T.)
	Z32->Z32_DESCRI := getFieldData(Z32->Z32_DESCRI, oUserData[ 'description' ])
	Z32->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PutOccurrence(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z32->(DbSetOrder(1))
	If Z32->(MsSeek(xFilial("Z32")+oUserData['id']) )
		RecLock("Z32", .F.)
		Z32->Z32_DESCRI  := getFieldData(Z32->Z32_DESCRI, oUserData[ 'description' ])
		Z32->(MsUnlock())
	EndIf
	Z32->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method DeleteOccurrence(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z32->(DbSetOrder(1))
	If Z32->(MsSeek(xFilial("Z32")+oUserData['id']) )
		RecLock("Z32", .F.)
		DbDelete()
		Z32->(MsUnlock())
	EndIf
	Z32->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse


method getSlaxOrgs(cSlaId) class ArgusModel
	local oResponse     := JsonObject():New()
	local oItem         := JsonObject():New()
	local aItems        := {}
	local oOrganization := JsonObject():New()

	BeginSql Alias "SQL_ORGANIZATIONS"
        SELECT
            Z3O_ID,
            Z3O_ORGID,
            Z3H_NOME
        FROM
            Z3O010 Z3O
        LEFT JOIN
            Z3H010 Z3H ON Z3H_ID = Z3O_ORGID AND Z3H.D_E_L_E_T_ = ''
        WHERE
            Z3O.D_E_L_E_T_ = ''
            AND Z3O_SLAID = %Exp:cSlaId%
        ORDER BY
            Z3O_ID DESC
	EndSql

	While !SQL_ORGANIZATIONS->(EoF())
		oOrganization[ 'id' ]   := Alltrim(SQL_ORGANIZATIONS->Z3O_ORGID)
		oOrganization[ 'name' ] := Alltrim(SQL_ORGANIZATIONS->Z3H_NOME)

		oItem[ 'id' ]           := Alltrim(SQL_ORGANIZATIONS->Z3O_ID)
		oItem[ 'organization' ] := oOrganization

		aadd(aItems, oItem)
		oItem := JsonObject():New()
		oOrganization := JsonObject():New()

		SQL_ORGANIZATIONS->(DbSkip())
	EndDo
	SQL_ORGANIZATIONS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method PostSLA(oUserData) class ArgusModel
	local oResponse                 := JsonObject():New()
	local nlenAmountOfOrganizations := 0
	local nIndex                    := 1

	RecLock("Z3N", .T.)
	Z3N->Z3N_FILIAL := xFilial("Z3N")
	Z3N->Z3N_ID     := NextNumero("Z3N", 1, "Z3N_ID", .T.)
	Z3N->Z3N_NOME   := getFieldData(Z3N->Z3N_NOME, oUserData[ 'name' ])
	Z3N->Z3N_DESCRI := getFieldData(Z3N->Z3N_DESCRI, oUserData[ 'description' ])

	//SLA De primeira resposta
	Z3N->Z3N_RPSBAI  := getFieldData(Z3N->Z3N_RPSBAI, oUserData[ 'firstResponse' ][1]['seconds'])
	Z3N->Z3N_RPSNOR  := getFieldData(Z3N->Z3N_RPSNOR, oUserData[ 'firstResponse' ][2]['seconds'])
	Z3N->Z3N_RPSALT  := getFieldData(Z3N->Z3N_RPSALT, oUserData[ 'firstResponse' ][3]['seconds'])
	Z3N->Z3N_RPSURG  := getFieldData(Z3N->Z3N_RPSURG, oUserData[ 'firstResponse' ][4]['seconds'])

	//Formato Do primeira resposta
	Z3N->Z3N_RPSBAF  := getFieldData(Z3N->Z3N_RPSBAF, oUserData[ 'firstResponse' ][1]['format'])
	Z3N->Z3N_RPSNOF  := getFieldData(Z3N->Z3N_RPSNOF, oUserData[ 'firstResponse' ][2]['format'])
	Z3N->Z3N_RPSALF  := getFieldData(Z3N->Z3N_RPSALF, oUserData[ 'firstResponse' ][3]['format'])
	Z3N->Z3N_RPSURF  := getFieldData(Z3N->Z3N_RPSURF, oUserData[ 'firstResponse' ][4]['format'])

	//SLA De conclusão
	Z3N->Z3N_RESBAI := getFieldData(Z3N->Z3N_RESBAI, oUserData[ 'resolution' ][1][ 'seconds' ])
	Z3N->Z3N_RESNOR := getFieldData(Z3N->Z3N_RESNOR, oUserData[ 'resolution' ][2][ 'seconds' ])
	Z3N->Z3N_RESALT := getFieldData(Z3N->Z3N_RESALT, oUserData[ 'resolution' ][3][ 'seconds' ])
	Z3N->Z3N_RESURG := getFieldData(Z3N->Z3N_RESURG, oUserData[ 'resolution' ][4][ 'seconds' ])

	//Formato Do primeira resposta
	Z3N->Z3N_RESBAF := getFieldData(Z3N->Z3N_RESBAF, oUserData[ 'resolution' ][1][ 'format' ])
	Z3N->Z3N_RESNOF := getFieldData(Z3N->Z3N_RESNOF, oUserData[ 'resolution' ][2][ 'format' ])
	Z3N->Z3N_RESALF := getFieldData(Z3N->Z3N_RESALF, oUserData[ 'resolution' ][3][ 'format' ])
	Z3N->Z3N_RESURF := getFieldData(Z3N->Z3N_RESURF, oUserData[ 'resolution' ][4][ 'format' ])
	Z3N->(MsUnlock())


	If !Empty(oUserData[ 'organizations' ])
		nlenAmountOfOrganizations := len(oUserData['organizations'])

		For nIndex := 1 To nlenAmountOfOrganizations
			RecLock("Z3O", .T.)
			Z3O->Z3O_FILIAL := xFilial("Z3O")
			Z3O->Z3O_ID     := NextNumero("Z3O", 1, "Z3O_ID", .T.)
			Z3O->Z3O_SLAID  := Z3N->Z3N_ID
			Z3O->Z3O_ORGID  := getFieldData(Z3O->Z3O_ORGID, oUserData[ 'organizations' ][nIndex]['organization'][ 'id' ])
			Z3O->(MsUnlock())
		Next
	EndIf

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PutSLA(oUserData) class ArgusModel
	local oResponse := JsonObject():New()
	local cSlaId    := ""
	local nIndex    := 1

	// --- Captura o ID do SLA recebido ---
	cSlaId := oUserData['id']

	// === Atualiza cabeçalho do SLA (Z3N) ===
	Z3N->(DbSetOrder(1))
	If !Z3N->(MsSeek(xFilial("Z3N") + cSlaId))
		oResponse['code']    := 404
		oResponse['message'] := "SLA não encontrado"
		Return oResponse
	EndIf

	RecLock("Z3N", .F.)
	Z3N->Z3N_NOME   := getFieldData(Z3N->Z3N_NOME, oUserData['name'])
	Z3N->Z3N_DESCRI := getFieldData(Z3N->Z3N_DESCRI, oUserData['description'])

	//SLA De primeira resposta
	Z3N->Z3N_RPSBAI  := getFieldData(Z3N->Z3N_RPSBAI, oUserData[ 'firstResponse' ][1]['seconds'])
	Z3N->Z3N_RPSNOR  := getFieldData(Z3N->Z3N_RPSNOR, oUserData[ 'firstResponse' ][2]['seconds'])
	Z3N->Z3N_RPSALT  := getFieldData(Z3N->Z3N_RPSALT, oUserData[ 'firstResponse' ][3]['seconds'])
	Z3N->Z3N_RPSURG  := getFieldData(Z3N->Z3N_RPSURG, oUserData[ 'firstResponse' ][4]['seconds'])

	//Formato Do primeira resposta
	Z3N->Z3N_RPSBAF  := getFieldData(Z3N->Z3N_RPSBAF, oUserData[ 'firstResponse' ][1]['format'])
	Z3N->Z3N_RPSNOF  := getFieldData(Z3N->Z3N_RPSNOF, oUserData[ 'firstResponse' ][2]['format'])
	Z3N->Z3N_RPSALF  := getFieldData(Z3N->Z3N_RPSALF, oUserData[ 'firstResponse' ][3]['format'])
	Z3N->Z3N_RPSURF  := getFieldData(Z3N->Z3N_RPSURF, oUserData[ 'firstResponse' ][4]['format'])

	//SLA De conclusão
	Z3N->Z3N_RESBAI := getFieldData(Z3N->Z3N_RESBAI, oUserData[ 'resolution' ][1][ 'seconds' ])
	Z3N->Z3N_RESNOR := getFieldData(Z3N->Z3N_RESNOR, oUserData[ 'resolution' ][2][ 'seconds' ])
	Z3N->Z3N_RESALT := getFieldData(Z3N->Z3N_RESALT, oUserData[ 'resolution' ][3][ 'seconds' ])
	Z3N->Z3N_RESURG := getFieldData(Z3N->Z3N_RESURG, oUserData[ 'resolution' ][4][ 'seconds' ])

	//Formato Do primeira resposta
	Z3N->Z3N_RESBAF := getFieldData(Z3N->Z3N_RESBAF, oUserData[ 'resolution' ][1][ 'format' ])
	Z3N->Z3N_RESNOF := getFieldData(Z3N->Z3N_RESNOF, oUserData[ 'resolution' ][2][ 'format' ])
	Z3N->Z3N_RESALF := getFieldData(Z3N->Z3N_RESALF, oUserData[ 'resolution' ][3][ 'format' ])
	Z3N->Z3N_RESURF := getFieldData(Z3N->Z3N_RESURF, oUserData[ 'resolution' ][4][ 'format' ])
	Z3N->(MsUnlock())

	// === Atualiza itens do SLA (Z3O) ===
	Z3O->(DbSetOrder(1))
	For nIndex := 1 To len(oUserData['organizations'])
		If oUserData[ 'organizations' ][nIndex][ 'status' ] == 'deleted'
			If Z3O->(MsSeek(xFilial("Z3O")+oUserData['organizations'][nIndex]['id']) )
				RecLock("Z3O", .F.)
				DbDelete()
				Z3O->(MsUnlock())
			EndIf
		Else
			If Empty(oUserData['organizations'][nIndex]['id']) //Item nao tem ID Z3O_ID
				RecLock("Z3O", .T.)
				Z3O->Z3O_FILIAL := xFilial("Z3O")
				Z3O->Z3O_ID     := NextNumero("Z3O", 1, "Z3O_ID", .T.)
				Z3O->Z3O_SLAID  := cSlaId
				Z3O->Z3O_ORGID  := getFieldData(Z3O->Z3O_ORGID, oUserData[ 'organizations' ][nIndex]['organization'][ 'id' ])
				Z3O->(MsUnlock())
			Else
				If Z3O->(MsSeek(xFilial("Z3O")+oUserData['organizations'][nIndex]['id']) )//Item tem ID Z3O_ID
					RecLock("Z3O", .F.)
					Z3O->Z3O_ORGID  := getFieldData(Z3O->Z3O_ORGID, oUserData[ 'organizations' ][nIndex]['organization'][ 'id' ])
					Z3O->(MsUnlock())
				EndIf
			EndIf
		EndIf
	Next
	Z3O->(DbCloseArea())

	oResponse['code']    := 200
	oResponse['message'] := "Cabeçalho atualizado e itens excluídos"

Return oResponse

method DeleteSLA(oUserData) class ArgusModel
	local oResponse                 := JsonObject():New()
	local nlenAmountOfOrganizations := 0
	local nIndex                    := 1

	Z3N->(DbSetOrder(1))
	If Z3N->(MsSeek(xFilial("Z3N")+oUserData['id']) )
		RecLock("Z3N", .F.)
		DbDelete()
		Z3N->(MsUnlock())

		nlenAmountOfOrganizations := len(oUserData['organizations'])

		For nIndex := 1 To nlenAmountOfOrganizations
			Z3O->(DbSetOrder(1))
			If Z3O->(MsSeek(xFilial("Z3O")+oUserData['organizations'][nIndex]['id']) )
				RecLock("Z3O", .F.)
				DbDelete()
				Z3O->(MsUnlock())
			EndIf
		Next
		Z3O->(DbCloseArea())

		oResponse['code'] := 200
		oResponse['message'] := "item had been deleted"
	EndIf

return oResponse

method PostQueue(oUserData) class ArgusModel
	local oResponse := JsonObject():New()
	local nIndex := 1
	local cSubItems := ""
	local nLenAmountOfConditions := 0
	local aFields        := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG", "organization"}, ;
		}

	RecLock("Z3L", .T.)
		Z3L->Z3L_FILIAL := xFilial("Z3L")
		Z3L->Z3L_ID     := NextNumero("Z3L", 1, "Z3L_ID", .T.)
		Z3L->Z3L_NOME   := getFieldData(Z3L->Z3L_NOME, oUserData[ 'name' ])
		Z3L->Z3L_ICONE  := getFieldData(Z3L->Z3L_ICONE, oUserData[ 'icon' ])

	cSubItems := ""
	If oUserData[ 'columns' ] != nil
		For nIndex := 1 to Len(oUserData['columns'])
			cSubItems += oUserData['columns'][nIndex]
			If nIndex < Len(oUserData['columns'])
				cSubItems += ";"
			EndIf
		Next

		Z3L->Z3L_COLUNA := getFieldData(Z3L->Z3L_COLUNA, cSubItems)
	EndIf

	cSubItems := ""
	If oUserData[ 'availableTo' ] != nil
		For nIndex := 1 to Len(oUserData['availableTo'])
			cSubItems += oUserData['availableTo'][nIndex]['id']
			If nIndex < Len(oUserData['availableTo'])
				cSubItems += ";"
			EndIf
		Next

		Z3L->Z3L_GRUPOS := getFieldData(Z3L->Z3L_GRUPOS, cSubItems)             // ?? não existe o campo
	EndIf
	Z3L->(MsUnlock())

	If !Empty(oUserData['allConditions'])
		nLenAmountOfConditions := len(oUserData['allConditions'])

		For nIndex := 1 to nLenAmountOfConditions
			nPos := aScan(aFields, {|x| x[2] == oUserData['allConditions'][nIndex]['field']})

			RecLock("Z3U", .T.)
			Z3U->Z3U_FILIAL := xFilial("Z3U")
			Z3U->Z3U_ID := NextNumero("Z3U", 1, "Z3U_ID", .T.)
			Z3U->Z3U_IDFILA := Z3L->Z3L_ID
			Z3U->Z3U_CAMPO := aFields[nPos][1]
			Z3U->Z3U_MATCH := '1'
			Z3U->Z3U_OPERAD := oUserData['allConditions'][nIndex]['operator']
			Z3U->Z3U_VALOR := oUserData['allConditions'][nIndex]['value']
			Z3U->(MsUnlock())
		Next
	EndIf

	If !Empty(oUserData['anyConditions'])
		nLenAmountOfConditions := len(oUserData['anyConditions'])

		For nIndex := 1 to nLenAmountOfConditions
			nPos := aScan(aFields, {|x| x[2] == oUserData['anyConditions'][nIndex]['field']})

			RecLock("Z3U", .T.)
			Z3U->Z3U_FILIAL := xFilial("Z3U")
			Z3U->Z3U_ID := NextNumero("Z3U", 1, "Z3U_ID", .T.)
			Z3U->Z3U_IDFILA := Z3L->Z3L_ID
			Z3U->Z3U_CAMPO := aFields[nPos][1]
			Z3U->Z3U_MATCH := '2'
			Z3U->Z3U_OPERAD := oUserData['anyConditions'][nIndex]['operator']
			Z3U->Z3U_VALOR := oUserData['anyConditions'][nIndex]['value']
			Z3U->(MsUnlock())
		Next
	EndIf

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PostTag(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z3J", .T.)
	Z3J->Z3J_FILIAL := xFilial("Z3J")
	Z3J->Z3J_ID     := NextNumero("Z3J", 1, "Z3J_ID", .T.)
	Z3J->Z3J_NOME   := getFieldData(Z3J->Z3J_NOME, oUserData[ 'name' ])
	Z3J->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PostArticle(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z3E", .T.)
		Z3E->Z3E_FILIAL := xFilial("Z3E")
		Z3E->Z3E_ID     := NextNumero("Z3E", 1, "Z3E_ID", .T.)
		Z3E->Z3E_NAME   := getFieldData(Z3E->Z3E_NAME, oUserData[ 'name' ])
		Z3E->Z3E_CONTEN   := getFieldData(Z3E->Z3E_CONTEN, oUserData[ 'content' ])
	Z3E->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PostOrgAttachment(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z3V", .T.)
		Z3V->Z3V_FILIAL := xFilial("Z3V")
		Z3V->Z3V_ID     := NextNumero("Z3V", 1, "Z3V_ID", .T.)
		Z3V->Z3V_IDORGA := getFieldData(Z3V->Z3V_IDORGA, oUserData[ 'organizationId' ])
		Z3V->Z3V_NOME   := getFieldData(Z3V->Z3V_NOME, oUserData[ 'name' ])
		Z3V->Z3V_ANEXO  := getFieldData(Z3V->Z3V_ANEXO, oUserData[ 'base64' ])
	Z3V->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method DelOrgAttachment(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3V->(DbSetOrder(1))
	If Z3V->(MsSeek(xFilial("Z3V")+oUserData['id']) )
		RecLock("Z3V", .F.)
		DBDelete()
		Z3V->(MsUnlock())
	EndIf
	Z3V->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PostTrigger(oUserData) class ArgusModel
	local oResponse              := JsonObject():New()
	local cActionType            := ""
	local cReceiverCategory      := ""
	local cRecipientId           := ""
	local cSubject               := ""
	local cEmailContent          := ""
	local cField                 := ""
	local cValue                 := ""
	local nLenConditions         := 0
	local nIndex                 := 1
	local nPos                   := 1
	local aFields                := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		{"Z3A_IDFILA" , "queue"}, ;
		{"Z3A_TIPO" , "type"}, ;
		{"Z3A_PRIORI" , "priority"}, ;
		{"Z3A_TPATEN" , "serviceType"}, ;
		{"Z3A_CRITIC" , "criticality"}, ;
		{"Z3A_CLASSI" , "classification"}, ;
		{"Z3A_GRUPO" , "resolverGroup"},;
		{"Z3A_ATRIBU" , "assigned"};
		}

	// GRAVA O GATILHO
	RecLock("Z3S", .T.)
	Z3S->Z3S_FILIAL := xFilial("Z3S")
	Z3S->Z3S_ID     := NextNumero("Z3S", 1, "Z3S_ID", .T.)
	Z3S->Z3S_NOME   := getFieldData(Z3S->Z3S_NOME, oUserData['name'])
	Z3S->Z3S_DESCRI := getFieldData(Z3S->Z3S_DESCRI, oUserData['description'])
	Z3S->Z3S_CATEGO := getFieldData(Z3S->Z3S_CATEGO, oUserData['category'])
	Z3S->Z3S_DATUAT := Date()
	Z3S->(MsUnlock())

	// GRAVA CONDIÇÕES ALL (AND)
	If !Empty(oUserData['allConditions'])
		nLenConditions := len(oUserData['allConditions'])

		For nIndex := 1 to nLenConditions
			nPos := aScan(aFields, {|x| x[2] == oUserData['allConditions'][nIndex]['field']})
			RecLock("Z3W", .T.)
			Z3W->Z3W_FILIAL := xFilial("Z3W")
			Z3W->Z3W_ID     := NextNumero("Z3W", 1, "Z3W_ID", .T.)
			Z3W->Z3W_IDGATI := Z3S->Z3S_ID
			Z3W->Z3W_CAMPO  := aFields[nPos][1]
			Z3W->Z3W_MATCH  := '1'
			Z3W->Z3W_OPERAD := oUserData['allConditions'][nIndex]['operator']
			Z3W->Z3W_VALOR  := oUserData['allConditions'][nIndex]['value']
			Z3W->(MsUnlock())
		Next
	EndIf

	// GRAVA CONDIÇÕES ANY (OR)
	If !Empty(oUserData['anyConditions'])
		nLenConditions := len(oUserData['anyConditions'])

		For nIndex := 1 to nLenConditions
			nPos := aScan(aFields, {|x| x[2] == oUserData['anyConditions'][nIndex]['field']})
			RecLock("Z3W", .T.)
			Z3W->Z3W_FILIAL := xFilial("Z3W")
			Z3W->Z3W_ID     := NextNumero("Z3W", 1, "Z3W_ID", .T.)
			Z3W->Z3W_IDGATI := Z3S->Z3S_ID
			Z3W->Z3W_CAMPO  := aFields[nPos][1]
			Z3W->Z3W_MATCH  := '2'
			Z3W->Z3W_OPERAD := oUserData['anyConditions'][nIndex]['operator']
			Z3W->Z3W_VALOR  := oUserData['anyConditions'][nIndex]['value']
			Z3W->(MsUnlock())
		Next
	EndIf

	// GRAVA AÇÕES
	If !Empty(oUserData['actions'])
		For nIndex := 1 to len(oUserData['actions'])
			action := oUserData['actions'][nIndex]

			If action['type'] == 'email'
				cActionType       := '1'
				cReceiverCategory := action['email']['category']
				cSubject          := action['email']['subject']
				cEmailContent     := DecodeUtf8(action['email']['body'])
				cRecipientId      := action['email']['recipient']
				cField            := ""
				cValue            := ""
			Else
				nPos := aScan(aFields, {|x| x[2] == action['ticket']['field']})
				cActionType       := '2'
				cField            := aFields[nPos][1]
				cValue            := action['ticket']['value']
				cReceiverCategory := ""
				cRecipientId      := ""
				cSubject          := ""
				cEmailContent     := ""
			EndIf

			RecLock("Z3Y", .T.)
			Z3Y->Z3Y_FILIAL := xFilial("Z3Y")
			Z3Y->Z3Y_ID     := NextNumero("Z3Y", 1, "Z3Y_ID", .T.)
			Z3Y->Z3Y_IDGATI := Z3S->Z3S_ID
			Z3Y->Z3Y_TIPO   := cActionType
			Z3Y->Z3Y_CATDES := cReceiverCategory
			Z3Y->Z3Y_DESTIN := cRecipientId
			Z3Y->Z3Y_ASSUNT := cSubject
			Z3Y->Z3Y_CONEMA := cEmailContent
			Z3Y->Z3Y_CAMPO  := cField
			Z3Y->Z3Y_VALOR  := cValue
			Z3Y->(MsUnlock())
		Next
	EndIf

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse


method PostAutomation(oUserData) class ArgusModel
	local oResponse              := JsonObject():New()
	local cActionType            := ""
	local cReceiverCategory      := ""
	local cRecipientId           := ""
	local cSubject               := ""
	local cEmailContent          := ""
	local cField                 := ""
	local cValue                 := ""
	local nLenConditions         := 0
	local nIndex                 := 1
	local nPos                   := 1
	local aFields                := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		{"Z3A_IDFILA" , "queue"}, ;
		{"Z3A_TIPO" , "type"}, ;
		{"Z3A_PRIORI" , "priority"}, ;
		{"Z3A_TPATEN" , "serviceType"}, ;
		{"Z3A_CRITIC" , "criticality"}, ;
		{"Z3A_CLASSI" , "classification"}, ;
		{"Z3A_GRUPO" , "resolverGroup"},;
		{"Z3A_ATRIBU" , "assigned"};
		}

	// GRAVA O GATILHO
	RecLock("Z3R", .T.)
	Z3R->Z3R_FILIAL := xFilial("Z3R")
	Z3R->Z3R_ID     := NextNumero("Z3R", 1, "Z3R_ID", .T.)
	Z3R->Z3R_NOME   := getFieldData(Z3R->Z3R_NOME, oUserData['name'])
	Z3R->Z3R_DATUAT := Date()
	Z3R->(MsUnlock())

	// GRAVA CONDIÇÕES ALL (AND)
	If !Empty(oUserData['allConditions'])
		nLenConditions := len(oUserData['allConditions'])

		For nIndex := 1 to nLenConditions
			If !(oUserData['allConditions'][nIndex]['field'] $ 'sts001;sts002;sts003;sts004;sts005;sts006')
				nPos := aScan(aFields, {|x| x[2] == oUserData['allConditions'][nIndex]['field']})
				cField := aFields[nPos][1]
			Else
				cField := oUserData['allConditions'][nIndex]['field']
			EndIf

			RecLock("Z3X", .T.)
			Z3X->Z3X_FILIAL := xFilial("Z3X")
			Z3X->Z3X_ID     := NextNumero("Z3X", 1, "Z3X_ID", .T.)
			Z3X->Z3X_IDAUTO := Z3R->Z3R_ID
			Z3X->Z3X_CAMPO  := cField
			Z3X->Z3X_MATCH  := '1'
			Z3X->Z3X_OPERAD := oUserData['allConditions'][nIndex]['operator']
			Z3X->Z3X_VALOR  := oUserData['allConditions'][nIndex]['value']
			Z3X->(MsUnlock())
		Next
	EndIf

	cField := ""

	// GRAVA CONDIÇÕES ANY (OR)
	If !Empty(oUserData['anyConditions'])
		nLenConditions := len(oUserData['anyConditions'])

		For nIndex := 1 to nLenConditions
			nPos := aScan(aFields, {|x| x[2] == oUserData['anyConditions'][nIndex]['field']})
			RecLock("Z3X", .T.)
			Z3X->Z3X_FILIAL := xFilial("Z3X")
			Z3X->Z3X_ID     := NextNumero("Z3X", 1, "Z3X_ID", .T.)
			Z3X->Z3X_IDAUTO := Z3R->Z3R_ID
			Z3X->Z3X_CAMPO  := aFields[nPos][1]
			Z3X->Z3X_MATCH  := '2'
			Z3X->Z3X_OPERAD := oUserData['anyConditions'][nIndex]['operator']
			Z3X->Z3X_VALOR  := oUserData['anyConditions'][nIndex]['value']
			Z3X->(MsUnlock())
		Next
	EndIf

	// GRAVA AÇÕES
	If !Empty(oUserData['actions'])
		For nIndex := 1 to len(oUserData['actions'])
			action := oUserData['actions'][nIndex]

			If action['type'] == 'email'
				cActionType       := '1'
				cReceiverCategory := action['email']['category']
				cSubject          := action['email']['subject']
				cEmailContent     := action['email']['body']
				cRecipientId      := action['email']['recipient']
				cField            := ""
				cValue            := ""
			Else
				nPos := aScan(aFields, {|x| x[2] == action['ticket']['field']})
				cActionType       := '2'
				cField            := aFields[nPos][1]
				cValue            := action['ticket']['value']
				cReceiverCategory := ""
				cRecipientId      := ""
				cSubject          := ""
				cEmailContent     := ""
			EndIf

			RecLock("Z31", .T.)
			Z31->Z31_FILIAL := xFilial("Z31")
			Z31->Z31_ID     := NextNumero("Z31", 1, "Z31_ID", .T.)
			Z31->Z31_IDAUTO := Z3R->Z3R_ID
			Z31->Z31_TIPO   := cActionType
			Z31->Z31_CATDES := cReceiverCategory
			Z31->Z31_DESTIN := cRecipientId
			Z31->Z31_ASSUNT := cSubject
			Z31->Z31_CONEMA := cEmailContent
			Z31->Z31_CAMPO  := cField
			Z31->Z31_VALOR  := cValue
			Z31->(MsUnlock())
		Next
	EndIf

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PostGroup(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("Z3K", .T.)
	Z3K->Z3K_FILIAL := xFilial("Z3K")
	Z3K->Z3K_ID     := NextNumero("Z3K", 1, "Z3K_ID", .T.)
	Z3K->Z3K_NOME   := getFieldData(Z3K->Z3K_NOME, oUserData[ 'name' ])
	Z3K->Z3K_DESC   := getFieldData(Z3K->Z3K_DESC, oUserData[ 'description' ])
	Z3K->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method GetTicket(cId, cCanGetPrivateMessages) class ArgusModel
	local oResponse   := JsonObject():New()
	local oTicketInfo := JsonObject():New()
	local oSubItem    := JsonObject():New()
	local aSubItems   := {}
	local nIndex      := 1
	local aTags       := {}
	local aFollowers  := {}
	local aOccurrences  := {}

	BeginSql Alias "SQL_TICKET"
        SELECT
            Z3A_ID,
            Z3A_CC,
            ISNULL(CAST(CAST(Z3A_ASSUNT AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS ASSUNTO,
            ISNULL(CAST(CAST(Z3A_CC AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS CC,
            Z3A_LOCALI,
            Z3A_TIPO,
            Z3A_STATUS,
            Z3A_CRITIC,
            Z3A_DATA,
            Z3A_HORA,
            Z3A_INDISP,
            Z3A_EQUIP,
            Z3A_PROTOC,
            Z3A_OPERAT,
            Z3A_IDUSER,
            Z3A_IDORG,
            Z3A_SLA,
            Z3A_CONTAT,
            Z3A_COMNAM,
            Z3A_ULTATI,
            Z3A_ATRIBU,
            Z3A_TPATEN,
            Z3A_TECHLI,
            Z3A_GRUPO,
            Z3A_TPTECH,
            Z3H_NOME,
            Z3H_ID,
            Z3A_IDFILA,
            Z3F_EMAIL,
			Z3F_ID,
            Z3F_TELEFO,
            Z3A_PRIORI,
            Z3A_LOCALI,
            CC2_MUN,
            B1_DESC,
            Z3A_DTVENC,
            ISNULL(CAST(CAST(Z3A_TEMIND AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS TEMPO_INDISPONIBILIDADE,
            ISNULL(CAST(CAST(Z3A_CLASSI AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS CLASSIFICAO,
            ISNULL(CAST(CAST(Z3A_TAGS AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS TAGS,
            ISNULL(CAST(CAST(Z3A_SEGUID AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS SEGUIDORES,
            ISNULL(CAST(CAST(Z3A_OCORRE AS VARBINARY(8000)) AS VARCHAR(8000)),'') AS OCORRENCIAS
        FROM
            Z3A010 Z3A
        LEFT JOIN
            Z3F010 ON Z3F_ID = Z3A_IDUSER
        LEFT JOIN
            Z3H010 ON Z3H_ID = Z3F_ORGANI
        LEFT JOIN
            CC2010 ON CC2_CODMUN = Z3A_LOCALI
        LEFT JOIN
            SB1010 ON B1_COD = Z3A_EQUIP
        WHERE
            Z3A_ID = %Exp:cId%
        AND
            Z3A.D_E_L_E_T_ = ''
	EndSql

	If !SQL_TICKET->(EoF())
		If Z3F->(MsSeek(xFilial("Z3F")+SQL_TICKET->Z3F_ID) )
			RecLock("Z3F", .F.)
				oTicketInfo[ 'requesterPhoto' ] := Alltrim(Z3F->Z3F_PHOTO)
			Z3F->(MsUnlock())
		EndIf
		Z3F->(DbCloseArea())

		oTicketInfo[ 'id' ]                    := Alltrim(SQL_TICKET->Z3A_ID)
		oTicketInfo[ 'requesterEmail' ]        := Alltrim(SQL_TICKET->Z3F_EMAIL)
		oTicketInfo[ 'requesterPhone' ]        := Alltrim(SQL_TICKET->Z3F_TELEFO)
		oTicketInfo[ 'cc' ]                    := Alltrim(SQL_TICKET->CC)
		oTicketInfo[ 'subject' ]               := Alltrim(SQL_TICKET->ASSUNTO)
		oTicketInfo[ 'locality' ]              := Alltrim(SQL_TICKET->Z3A_LOCALI)
		oTicketInfo[ 'localityName' ]          := Alltrim(SQL_TICKET->CC2_MUN)
		oTicketInfo[ 'type' ]                  := Alltrim(SQL_TICKET->Z3A_TIPO)
		oTicketInfo[ 'organization' ]          := Alltrim(SQL_TICKET->Z3H_NOME)
		oTicketInfo[ 'organizationId' ]        := Alltrim(SQL_TICKET->Z3H_ID)
		oTicketInfo[ 'status' ]                := Alltrim(SQL_TICKET->Z3A_STATUS)
		oTicketInfo[ 'criticality' ]           := Alltrim(SQL_TICKET->Z3A_CRITIC)
		oTicketInfo[ 'priority' ]              := Alltrim(SQL_TICKET->Z3A_PRIORI)
		oTicketInfo[ 'date' ]                  := IIF(Empty(SQL_TICKET->Z3A_DATA), '' , year2Str(stod(SQL_TICKET->Z3A_DATA)) + "-" + Month2Str(stod(SQL_TICKET->Z3A_DATA)) + "-" + Day2Str(stod(SQL_TICKET->Z3A_DATA)))
		oTicketInfo[ 'time' ]                  := Alltrim(SQL_TICKET->Z3A_HORA)
		oTicketInfo[ 'downTime' ]              := Alltrim(SQL_TICKET->Z3A_INDISP)
		oTicketInfo[ 'equipment' ]             := Alltrim(SQL_TICKET->Z3A_EQUIP)
		oTicketInfo[ 'equipmentName' ] := Alltrim(SQL_TICKET->B1_DESC)
		oTicketInfo[ 'customerProtocol' ]      := Alltrim(SQL_TICKET->Z3A_PROTOC)
		oTicketInfo[ 'operator' ]              := Alltrim(SQL_TICKET->Z3A_OPERAT)
		oTicketInfo[ 'requesterId' ]           := Alltrim(SQL_TICKET->Z3A_IDUSER)
		oTicketInfo[ 'originId' ]              := Alltrim(SQL_TICKET->Z3A_IDORG)
		oTicketInfo[ 'sla' ]                   := Alltrim(SQL_TICKET->Z3A_SLA)
		oTicketInfo[ 'contact' ]               := Alltrim(SQL_TICKET->Z3A_CONTAT)
		oTicketInfo[ 'completeName' ]          := Alltrim(SQL_TICKET->Z3A_COMNAM)
		oTicketInfo[ 'lastActivity' ]          := Alltrim(SQL_TICKET->Z3A_ULTATI)
		oTicketInfo[ 'assigned' ]              := Alltrim(SQL_TICKET->Z3A_ATRIBU)
		oTicketInfo[ 'serviceType' ]           := Alltrim(SQL_TICKET->Z3A_TPATEN)
		oTicketInfo[ 'techLeader' ]            := Alltrim(SQL_TICKET->Z3A_TECHLI)
		oTicketInfo[ 'resolverGroup' ]         := Alltrim(SQL_TICKET->Z3A_GRUPO)
		oTicketInfo[ 'technologyType' ]        := Alltrim(SQL_TICKET->Z3A_TPTECH)
		oTicketInfo[ 'queue' ]                 := Alltrim(SQL_TICKET->Z3A_IDFILA)
		oTicketInfo[ 'classification' ]        := Alltrim(SQL_TICKET->CLASSIFICAO)
		oTicketInfo[ 'dueDate' ]               := IIF(Empty(SQL_TICKET->Z3A_DTVENC), '' , year2Str(stod(SQL_TICKET->Z3A_DTVENC)) + "-" + Month2Str(stod(SQL_TICKET->Z3A_DTVENC)) + "-" + Day2Str(stod(SQL_TICKET->Z3A_DTVENC)))
		oTicketInfo[ 'unavailabilityTime' ]    := Alltrim(SQL_TICKET->TEMPO_INDISPONIBILIDADE)
		oTicketInfo[ 'messages' ]              := ::GetMessages(cId, 1, 100, "", cCanGetPrivateMessages)[ 'items' ]
		oTicketInfo[ 'attachments' ]           := ::GetAttachments(cId)[ 'items' ]

		If Alltrim(SQL_TICKET->TAGS) != ''
			aTags := StrTokArr(SQL_TICKET->TAGS, ';')
			For nIndex := 1 to len(aTags)
				oSubItem['id'] := aTags[nIndex]

				aadd(aSubItems, oSubItem)
				oSubItem := JsonObject():New()
			Next
			oTicketInfo[ 'tags' ] := aSubItems
		EndIf

		If Alltrim(SQL_TICKET->SEGUIDORES) != ''
			aSubItems := {}
			aFollowers := StrTokArr(SQL_TICKET->SEGUIDORES, ';')
			For nIndex := 1 to len(aFollowers)
				oSubItem['id'] := aFollowers[nIndex]

				aadd(aSubItems, oSubItem)
				oSubItem := JsonObject():New()
			Next

			oTicketInfo[ 'followers' ] := aSubItems
		EndIf

		If Alltrim(SQL_TICKET->OCORRENCIAS) != ''
			aSubItems := {}
			aOccurrences := StrTokArr(SQL_TICKET->OCORRENCIAS, ';')
			For nIndex := 1 to len(aOccurrences)
				oSubItem['id'] := aOccurrences[nIndex]

				aadd(aSubItems, oSubItem)
				oSubItem := JsonObject():New()
			Next

			oTicketInfo[ 'occurrences' ] := aSubItems
		EndIf

		oResponse['code']    := 200
		oResponse['message'] := "Usuario logado com sucesso!"
		oResponse['userInfo'] := oTicketInfo
	Else
		oResponse['code'] := 404
		oResponse['message'] := "Usuario ou senha Incorretos"
	EndIf
	SQL_TICKET->(DbCloseArea())


return oResponse

method PutTicket(oTicketData) class ArgusModel
	local oResponse := JsonObject():New()
	local oTriggersModel := JsonObject():New()
	local nIndex := 1
	local cSubItems := ""

	oTriggersModel := TriggersModel():New()

	// ==============================
	// Pré-normalização dos campos
	// ==============================
	oTicketData[ 'requesterId' ]   := IIF(oTicketData[ 'requesterId' ] == nil, nil, oTicketData[ 'requesterId' ][ 'id' ])
	oTicketData[ 'assigned' ]      := IIF(oTicketData[ 'assigned' ] == nil, nil, oTicketData[ 'assigned' ][ 'id' ])
	oTicketData[ 'equipment' ]     := IIF(oTicketData[ 'equipment' ] == nil, nil, oTicketData[ 'equipment' ][ 'value' ])
	oTicketData[ 'techLeader' ]    := IIF(oTicketData[ 'techLeader' ] == nil, nil, oTicketData[ 'techLeader' ][ 'id' ])
	oTicketData[ 'resolverGroup' ] := IIF(oTicketData[ 'resolverGroup' ] == nil, nil, oTicketData[ 'resolverGroup' ][ 'id' ])
	oTicketData[ 'queue' ]         := IIF(oTicketData[ 'queue' ] == nil, nil, oTicketData[ 'queue' ][ 'id' ])
	oTicketData[ 'locality' ]      := IIF(oTicketData[ 'locality' ] == nil, nil, oTicketData[ 'locality' ][ 'value' ])
	oTicketData[ 'title' ]         := IIF(oTicketData[ 'title' ] == nil, nil, oTicketData[ 'title' ])
	oTicketData[ 'dueDate' ]       := IIF(oTicketData[ 'dueDate' ] == nil, nil, ;
		stod(strTran(Left(oTicketData[ 'dueDate' ], 10), '-' )))

	// tags (transformar em string separada por ;)
	If oTicketData['tags'] != nil
		cSubItems := ""
		For nIndex := 1 to Len(oTicketData['tags'])
			cSubItems += oTicketData['tags'][nIndex]['id']
			If nIndex < Len(oTicketData['tags'])
				cSubItems += ";"
			EndIf
		Next
		oTicketData['tags'] := cSubItems
	EndIf

	// followers
	If oTicketData['followers'] != nil
		cSubItems := ""
		For nIndex := 1 to Len(oTicketData['followers'])
			cSubItems += oTicketData['followers'][nIndex]['id']
			If nIndex < Len(oTicketData['followers'])
				cSubItems += ";"
			EndIf
		Next
		oTicketData['followers'] := cSubItems
	EndIf

	// occurrences
	If oTicketData['occurrences'] != nil
		cSubItems := ""
		For nIndex := 1 to Len(oTicketData['occurrences'])
			cSubItems += oTicketData['occurrences'][nIndex]['id']

			If nIndex < Len(oTicketData['occurrences'])
				cSubItems += ";"
			EndIf
		Next
		oTicketData['occurrences'] := cSubItems
	EndIf

	// =====================================
	// Agora sim podemos salvar histórico
	// =====================================
	::PostInterationsInTicket(oTicketData)

	// =====================================
	// Update na tabela
	// =====================================
	Z3A->(DbSetOrder(1))
	If Z3A->(MsSeek(xFilial("Z3A") + oTicketData['id']))
		RecLock("Z3A", .F.)
		Z3A->Z3A_IDSOL  := getFieldData(Z3A->Z3A_IDSOL, oTicketData[ 'requesterId' ])
		Z3A->Z3A_STATUS := getFieldData(Z3A->Z3A_STATUS, oTicketData[ 'status' ])
		Z3A->Z3A_ATRIBU := getFieldData(Z3A->Z3A_ATRIBU, oTicketData[ 'assigned' ])
		Z3A->Z3A_TIPO   := getFieldData(Z3A->Z3A_TIPO, oTicketData[ 'type' ])
		Z3A->Z3A_TPATEN := getFieldData(Z3A->Z3A_TPATEN, oTicketData[ 'serviceType' ])
		Z3A->Z3A_CRITIC := getFieldData(Z3A->Z3A_CRITIC, oTicketData[ 'criticality' ])
		Z3A->Z3A_PRIORI := getFieldData(Z3A->Z3A_PRIORI, oTicketData[ 'priority' ])
		Z3A->Z3A_INDISP := getFieldData(Z3A->Z3A_INDISP, oTicketData[ 'downTime' ])
		Z3A->Z3A_EQUIP  := getFieldData(Z3A->Z3A_EQUIP, oTicketData[ 'equipment' ])
		Z3A->Z3A_CLASSI := getFieldData(Z3A->Z3A_CLASSI, oTicketData[ 'classification' ])
		Z3A->Z3A_TECHLI := getFieldData(Z3A->Z3A_TECHLI, oTicketData[ 'techLeader' ])
		Z3A->Z3A_GRUPO  := getFieldData(Z3A->Z3A_GRUPO, oTicketData[ 'resolverGroup' ])
		Z3A->Z3A_IDFILA := getFieldData(Z3A->Z3A_IDFILA, oTicketData[ 'queue' ])
		Z3A->Z3A_PROTOC := getFieldData(Z3A->Z3A_PROTOC, oTicketData[ 'customerProtocol' ])
		Z3A->Z3A_TEMIND := getFieldData(Z3A->Z3A_TEMIND, oTicketData[ 'unavailabilityTime' ])
		Z3A->Z3A_DTVENC := getFieldData(Z3A->Z3A_DTVENC, oTicketData[ 'dueDate' ])
		Z3A->Z3A_LOCALI := getFieldData(Z3A->Z3A_LOCALI, oTicketData[ 'locality' ])
		Z3A->Z3A_TPTECH := getFieldData(Z3A->Z3A_TPTECH, oTicketData[ 'technologyType' ])
		Z3A->Z3A_TAGS   := getFieldData(Z3A->Z3A_TAGS, oTicketData[ 'tags' ])
		Z3A->Z3A_OCORRE := getFieldData(Z3A->Z3A_OCORRE, oTicketData[ 'occurrences' ])
		Z3A->Z3A_SEGUID := getFieldData(Z3A->Z3A_SEGUID, oTicketData[ 'followers' ])
		Z3A->Z3A_ASSUNT := getFieldData(Z3A->Z3A_ASSUNT, oTicketData[ 'title' ])
		Z3A->(MsUnlock())

		::CheckTriggers(Z3A->Z3A_ID)

		oResponse['code']    := 200
		oResponse['message'] := "item had been changed"
	Else
		// Cliente não localizado
	EndIf

	Z3A->(DbCloseArea())
return oResponse


method PutQueue(oUserData) class ArgusModel
	local oResponse := JsonObject():New()
	local nIndex    := 1
	local cSubItems := ""
	local nPos      := 0
	local aFields   := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		}

	Z3L->(DbSetOrder(1))
	If Z3L->(MsSeek(xFilial("Z3L")+oUserData['id']) )
		RecLock("Z3L", .F.)
		Z3L->Z3L_NOME  := getFieldData(Z3L->Z3L_NOME, oUserData[ 'name' ])
		Z3L->Z3L_ICONE  := getFieldData(Z3L->Z3L_ICONE, oUserData[ 'icon' ])
		Z3L->Z3L_ORDEM  := getFieldData(Z3L->Z3L_ORDEM, oUserData[ 'order' ])

		cSubItems := ""
		If oUserData[ 'columns' ] != nil
			For nIndex := 1 to Len(oUserData['columns'])
				cSubItems += oUserData['columns'][nIndex]
				If nIndex < Len(oUserData['columns'])
					cSubItems += ";"
				EndIf
			Next

			Z3L->Z3L_COLUNA := getFieldData(Z3L->Z3L_COLUNA, cSubItems)
		EndIf

		cSubItems := ""
		If oUserData[ 'availableTo' ] != nil
			For nIndex := 1 to Len(oUserData['availableTo'])
				cSubItems += oUserData['availableTo'][nIndex]['id']
				If nIndex < Len(oUserData['availableTo'])
					cSubItems += ";"
				EndIf
			Next

			Z3L->Z3L_GRUPOS := getFieldData(Z3L->Z3L_GRUPOS, cSubItems)
		EndIf
		Z3L->(MsUnlock())
	EndIf
	Z3L->(DbCloseArea())

	// === Atualiza itens do SLA (Z3O) ===
	If oUserData[ 'deletedConditions' ] != nil
		Z3U->(DbSetOrder(1))
		For nIndex := 1 To len(oUserData['deletedConditions'])
			If Z3U->(MsSeek(xFilial("Z3U")+oUserData['deletedConditions'][nIndex]['id']) )
				RecLock("Z3U", .F.)
				DbDelete()
				Z3U->(MsUnlock())
			EndIf
		Next
	EndIf

	If oUserData[ 'allConditions' ] != nil
		For nIndex := 1 To len(oUserData['allConditions'])
			nPos := aScan(aFields, {|x| x[2] == oUserData['allConditions'][nIndex]['field']})

			If Z3U->(MsSeek(xFilial("Z3U")+oUserData['allConditions'][nIndex]['id']) )
				RecLock("Z3U", .F.)
				Z3U->Z3U_CAMPO := aFields[nPos][1]
				Z3U->Z3U_MATCH := '1'
				Z3U->Z3U_OPERAD := oUserData['allConditions'][nIndex]['operator']
				Z3U->Z3U_VALOR := oUserData['allConditions'][nIndex]['value']
				Z3U->(MsUnlock())
			Else
				RecLock("Z3U", .T.)
				Z3U->Z3U_FILIAL := xFilial("Z3U")
				Z3U->Z3U_ID := NextNumero("Z3U", 1, "Z3U_ID", .T.)
				Z3U->Z3U_IDFILA := Z3L->Z3L_ID
				Z3U->Z3U_CAMPO := aFields[nPos][1]
				Z3U->Z3U_MATCH := '1'
				Z3U->Z3U_OPERAD := oUserData['allConditions'][nIndex]['operator']
				Z3U->Z3U_VALOR := oUserData['allConditions'][nIndex]['value']
				Z3U->(MsUnlock())
			EndIf
		Next
	EndIf

	If oUserData[ 'anyConditions' ] != nil
		For nIndex := 1 To len(oUserData['anyConditions'])
			nPos := aScan(aFields, {|x| x[2] == oUserData['anyConditions'][nIndex]['field']})

			If Z3U->(MsSeek(xFilial("Z3U")+oUserData['anyConditions'][nIndex]['id']) )
				RecLock("Z3U", .F.)
				Z3U->Z3U_CAMPO := aFields[nPos][1]
				Z3U->Z3U_MATCH := '2'
				Z3U->Z3U_OPERAD := oUserData['anyConditions'][nIndex]['operator']
				Z3U->Z3U_VALOR := oUserData['anyConditions'][nIndex]['value']
				Z3U->(MsUnlock())
			Else
				RecLock("Z3U", .T.)
				Z3U->Z3U_FILIAL := xFilial("Z3U")
				Z3U->Z3U_ID := NextNumero("Z3U", 1, "Z3U_ID", .T.)
				Z3U->Z3U_IDFILA := Z3L->Z3L_ID
				Z3U->Z3U_CAMPO := aFields[nPos][1]
				Z3U->Z3U_MATCH := '2'
				Z3U->Z3U_OPERAD := oUserData['anyConditions'][nIndex]['operator']
				Z3U->Z3U_VALOR := oUserData['anyConditions'][nIndex]['value']
				Z3U->(MsUnlock())
			EndIf
		Next
		Z3U->(DbCloseArea())
	EndIf

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse

method DeleteQueue(oUserData) class ArgusModel
	local oResponse := JsonObject():New()
	local nIndex := 1

	Z3L->(DbSetOrder(1))
	If Z3L->(MsSeek(xFilial("Z3L")+oUserData['id']) )
		RecLock("Z3L", .F.)
		DBDelete()
		Z3L->(MsUnlock())
	EndIf
	Z3L->(DbCloseArea())

	For nIndex := 1 to len(oUserData['allConditions'])
		Z3U->(DbSetOrder(1))
		If Z3U->(MsSeek(xFilial("Z3U")+oUserData['allConditions'][nIndex]['id']) )
			RecLock("Z3U", .F.)
			DBDelete()
			Z3U->(MsUnlock())
		EndIf
		Z3U->(DbCloseArea())
	Next

	For nIndex := 1 to len(oUserData['anyConditions'])
		Z3U->(DbSetOrder(1))
		If Z3U->(MsSeek(xFilial("Z3U")+oUserData['anyConditions'][nIndex]['id']) )
			RecLock("Z3U", .F.)
			DBDelete()
			Z3U->(MsUnlock())
		EndIf
		Z3U->(DbCloseArea())
	Next

	oResponse['code'] := 200
	oResponse['message'] := "item had been deleted"

return oResponse

method PutTag(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3J->(DbSetOrder(1))
	If Z3J->(MsSeek(xFilial("Z3J")+oUserData['id']) )
		RecLock("Z3J", .F.)
		Z3J->Z3J_NOME  := getFieldData(Z3J->Z3J_NOME, oUserData[ 'name' ])
		Z3J->(MsUnlock())
	EndIf
	Z3J->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse


method PutArticle(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3E->(DbSetOrder(1))
	If Z3E->(MsSeek(xFilial("Z3E")+oUserData['id']) )
		RecLock("Z3E", .F.)
			Z3E->Z3E_NAME  := getFieldData(Z3E->Z3E_NAME, oUserData[ 'name' ])
			Z3E->Z3E_CONTEN  := getFieldData(Z3E->Z3E_CONTEN, oUserData[ 'content' ])
		Z3E->(MsUnlock())
	EndIf
	Z3E->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse

method PutTrigger(oUserData) class ArgusModel
	local oResponse              := JsonObject():New()
	local nIndex                 := 1
	local nPos := 1
	local aFields                := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		{"Z3A_IDFILA" , "queue"}, ;
		{"Z3A_TIPO" , "type"}, ;
		{"Z3A_PRIORI" , "priority"}, ;
		{"Z3A_TPATEN" , "serviceType"}, ;
		{"Z3A_CRITIC" , "criticality"}, ;
		{"Z3A_CLASSI" , "classification"}, ;
		{"Z3A_GRUPO" , "resolverGroup"},;
		{"Z3A_ATRIBU" , "assigned"};
		}

	Z3S->(DbSetOrder(1))
	If Z3S->(MsSeek(xFilial("Z3S")+oUserData['id']) )
		RecLock("Z3S", .F.)
		Z3S->Z3S_NOME   := getFieldData(Z3S->Z3S_NOME, oUserData[ 'name' ])
		Z3S->Z3S_DESCRI := getFieldData(Z3S->Z3S_DESCRI, oUserData[ 'description' ])
		Z3S->Z3S_CATEGO := getFieldData(Z3S->Z3S_CATEGO, oUserData[ 'category' ])
		Z3S->Z3S_DATUAT := Date()
		Z3S->(MsUnlock())
	EndIf

	For nIndex := 1 To len(oUserData['deletedConditions'])
		If Z3W->(MsSeek(xFilial("Z3W")+oUserData['deletedConditions'][nIndex]['id']) )
			RecLock("Z3W", .F.)
			DbDelete()
			Z3W->(MsUnlock())
		EndIf
	Next

	For nIndex := 1 To len(oUserData['allConditions'])
		nPos := aScan(aFields, {|x| x[2] == oUserData['allConditions'][nIndex]['field']})

		If oUserData['allConditions'][nIndex]['id'] == nil
			oUserData['allConditions'][nIndex]['id'] := ''
		EndIf

		If Z3W->(MsSeek(xFilial("Z3W")+oUserData['allConditions'][nIndex]['id']) .AND. oUserData['allConditions'][nIndex]['id'] != '')
			RecLock("Z3W", .F.)
			Z3W->Z3W_CAMPO := aFields[nPos][1]
			Z3W->Z3W_MATCH := '1'
			Z3W->Z3W_OPERAD := oUserData['allConditions'][nIndex]['operator']
			Z3W->Z3W_VALOR := oUserData['allConditions'][nIndex]['value']
			Z3W->(MsUnlock())
		Else
			RecLock("Z3W", .T.)
			Z3W->Z3W_FILIAL := xFilial("Z3W")
			Z3W->Z3W_ID := NextNumero("Z3W", 1, "Z3W_ID", .T.)
			Z3W->Z3W_IDGATI := oUserData['id']
			Z3W->Z3W_CAMPO := aFields[nPos][1]
			Z3W->Z3W_MATCH := '1'
			Z3W->Z3W_OPERAD := oUserData['allConditions'][nIndex]['operator']
			Z3W->Z3W_VALOR := oUserData['allConditions'][nIndex]['value']
			Z3W->(MsUnlock())
		EndIf
	Next

	For nIndex := 1 To len(oUserData['anyConditions'])
		nPos := aScan(aFields, {|x| x[2] == oUserData['anyConditions'][nIndex]['field']})

		If oUserData['anyConditions'][nIndex]['id'] == nil
			oUserData['anyConditions'][nIndex]['id'] := ''
		EndIf

		If Z3W->(MsSeek(xFilial("Z3W")+oUserData['anyConditions'][nIndex]['id']) .AND. oUserData['anyConditions'][nIndex]['id'] != '')
			RecLock("Z3W", .F.)
			Z3W->Z3W_CAMPO := aFields[nPos][1]
			Z3W->Z3W_MATCH := '2'
			Z3W->Z3W_OPERAD := oUserData['anyConditions'][nIndex]['operator']
			Z3W->Z3W_VALOR := oUserData['anyConditions'][nIndex]['value']
			Z3W->(MsUnlock())
		Else
			RecLock("Z3W", .T.)
			Z3W->Z3W_FILIAL := xFilial("Z3W")
			Z3W->Z3W_ID := NextNumero("Z3W", 1, "Z3W_ID", .T.)
			Z3W->Z3W_IDGATI := oUserData['id']
			Z3W->Z3W_CAMPO := aFields[nPos][1]
			Z3W->Z3W_MATCH := '2'
			Z3W->Z3W_OPERAD := oUserData['anyConditions'][nIndex]['operator']
			Z3W->Z3W_VALOR := oUserData['anyConditions'][nIndex]['value']
			Z3W->(MsUnlock())
		EndIf
	Next

	For nIndex := 1 To len(oUserData['actions'])
		action := oUserData['actions'][nIndex]

		If action['type'] == 'email'
			cActionType       := '1'
			cReceiverCategory := action['email']['category']
			cSubject          := action['email']['subject']
			cEmailContent     := action['email']['body']
			cRecipientId      := action['email']['recipient']
			cField            := ""
			cValue            := ""
		Else
			nPos := aScan(aFields, {|x| x[2] == action['ticket']['field']})
			cActionType       := '2'
			cField            := aFields[nPos][1]
			cValue            := action['ticket']['value']
			cReceiverCategory := ""
			cRecipientId      := ""
			cSubject          := ""
			cEmailContent     := ""
		EndIf

		If action['id'] == nil
			action['id'] := ''
		EndIf

		If action['status'] == 'deleted'
			If Z3Y->(MsSeek(xFilial("Z3Y")+action['id']) )
				RecLock("Z3Y", .F.)
				DbDelete()
				Z3Y->(MsUnlock())
			EndIf
		ElseIf Z3Y->(MsSeek(xFilial("Z3Y")+action['id']) ) .AND. action['id'] != ''
			RecLock("Z3Y", .F.)
			Z3Y->Z3Y_TIPO   := cActionType
			Z3Y->Z3Y_CATDES := cReceiverCategory
			Z3Y->Z3Y_DESTIN := cRecipientId
			Z3Y->Z3Y_ASSUNT := cSubject
			Z3Y->Z3Y_CONEMA := cEmailContent
			Z3Y->Z3Y_CAMPO  := cField
			Z3Y->Z3Y_VALOR  := cValue
			Z3Y->(MsUnlock())
		Else
			RecLock("Z3Y", .T.)
			Z3Y->Z3Y_FILIAL := xFilial("Z3Y")
			Z3Y->Z3Y_ID     := NextNumero("Z3Y", 1, "Z3Y_ID", .T.)
			Z3Y->Z3Y_IDGATI := oUserData['id']
			Z3Y->Z3Y_TIPO   := cActionType
			Z3Y->Z3Y_CATDES := cReceiverCategory
			Z3Y->Z3Y_DESTIN := cRecipientId
			Z3Y->Z3Y_ASSUNT := cSubject
			Z3Y->Z3Y_CONEMA := cEmailContent
			Z3Y->Z3Y_CAMPO  := cField
			Z3Y->Z3Y_VALOR  := cValue
			Z3Y->(MsUnlock())
		EndIf
		Z3S->(DbCloseArea())
	Next

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse

Method CheckTriggers(cTicketId) Class ArgusModel
	local oTriggersModel := JsonObject():New()

	oTriggersModel := TriggersModel():New()

	oTriggersModel:CheckTriggers(cTicketId)

Return .T.

method PutAutomation(oUserData) class ArgusModel
	local oResponse              := JsonObject():New()
	local nIndex  := 1
	local nPos    := 1
	local cField  := ""
	local aFields := { ;
		{"Z3A_STATUS", "status"}, ;
		{"Z3A_IDORG" , "organization"}, ;
		{"Z3A_IDFILA", "queue"}, ;
		{"Z3A_TIPO"  , "type"}, ;
		{"Z3A_PRIORI", "priority"}, ;
		{"Z3A_TPATEN", "serviceType"}, ;
		{"Z3A_CRITIC", "criticality"}, ;
		{"Z3A_CLASSI", "classification"}, ;
		{"Z3A_GRUPO" , "resolverGroup"},;
		{"Z3A_ATRIBU", "assigned"};
		}

	Z3R->(DbSetOrder(1))
	If Z3R->(MsSeek(xFilial("Z3R")+oUserData['id']) )
		RecLock("Z3R", .F.)
		Z3R->Z3R_NOME   := getFieldData(Z3R->Z3R_NOME, oUserData[ 'name' ])
		Z3R->Z3R_DATUAT := Date()
		Z3R->(MsUnlock())
	EndIf

	For nIndex := 1 To len(oUserData['deletedConditions'])
		If Z3X->(MsSeek(xFilial("Z3X")+oUserData['deletedConditions'][nIndex]['id']) )
			RecLock("Z3X", .F.)
			DbDelete()
			Z3X->(MsUnlock())
		EndIf
	Next

	For nIndex := 1 To len(oUserData['allConditions'])
		If !(oUserData['allConditions'][nIndex]['field'] $ 'sts001;sts002;sts003;sts004;sts005;sts006')
			nPos := aScan(aFields, {|x| x[2] == oUserData['allConditions'][nIndex]['field']})
			cField := aFields[nPos][1]
		Else
			cField := oUserData['allConditions'][nIndex]['field']
		EndIf

		If oUserData['allConditions'][nIndex]['id'] == nil
			oUserData['allConditions'][nIndex]['id'] := ''
		EndIf

		If Z3X->(MsSeek(xFilial("Z3X")+oUserData['allConditions'][nIndex]['id']) .AND. oUserData['allConditions'][nIndex]['id'] != '')
			RecLock("Z3X", .F.)
			Z3X->Z3X_CAMPO := cField
			Z3X->Z3X_MATCH := '1'
			Z3X->Z3X_OPERAD := oUserData['allConditions'][nIndex]['operator']
			Z3X->Z3X_VALOR := oUserData['allConditions'][nIndex]['value']
			Z3X->(MsUnlock())
		Else
			RecLock("Z3X", .T.)
			Z3X->Z3X_FILIAL := xFilial("Z3X")
			Z3X->Z3X_ID := NextNumero("Z3X", 1, "Z3X_ID", .T.)
			Z3X->Z3X_IDAUTO := oUserData['id']
			Z3X->Z3X_CAMPO := cField
			Z3X->Z3X_MATCH := '1'
			Z3X->Z3X_OPERAD := oUserData['allConditions'][nIndex]['operator']
			Z3X->Z3X_VALOR := oUserData['allConditions'][nIndex]['value']
			Z3X->(MsUnlock())
		EndIf
	Next

	For nIndex := 1 To len(oUserData['anyConditions'])
		If !(oUserData['anyConditions'][nIndex]['field'] $ 'sts001;sts002;sts003;sts004;sts005;sts006')
			nPos := aScan(aFields, {|x| x[2] == oUserData['anyConditions'][nIndex]['field']})
			cField := aFields[nPos][1]
		Else
			cField := oUserData['anyConditions'][nIndex]['field']
		EndIf

		If oUserData['anyConditions'][nIndex]['id'] == nil
			oUserData['anyConditions'][nIndex]['id'] := ''
		EndIf

		If Z3X->(MsSeek(xFilial("Z3X")+oUserData['anyConditions'][nIndex]['id']) .AND. oUserData['anyConditions'][nIndex]['id'] != '')
			RecLock("Z3X", .F.)
			Z3X->Z3X_CAMPO := cField
			Z3X->Z3X_MATCH := '2'
			Z3X->Z3X_OPERAD := oUserData['anyConditions'][nIndex]['operator']
			Z3X->Z3X_VALOR := oUserData['anyConditions'][nIndex]['value']
			Z3X->(MsUnlock())
		Else
			RecLock("Z3X", .T.)
			Z3X->Z3X_FILIAL := xFilial("Z3X")
			Z3X->Z3X_ID := NextNumero("Z3X", 1, "Z3X_ID", .T.)
			Z3X->Z3X_IDAUTO := oUserData['id']
			Z3X->Z3X_CAMPO := cField
			Z3X->Z3X_MATCH := '2'
			Z3X->Z3X_OPERAD := oUserData['allConditions'][nIndex]['operator']
			Z3X->Z3X_VALOR := oUserData['allConditions'][nIndex]['value']
			Z3X->(MsUnlock())
		EndIf
	Next

	For nIndex := 1 To len(oUserData['actions'])
		action := oUserData['actions'][nIndex]

		If action['type'] == 'email'
			cActionType       := '1'
			cReceiverCategory := action['email']['category']
			cSubject          := action['email']['subject']
			cEmailContent     := action['email']['body']
			cRecipientId      := action['email']['recipient']
			cField            := ""
			cValue            := ""
		Else
			nPos := aScan(aFields, {|x| x[2] == action['ticket']['field']})
			cActionType       := '2'
			cField            := aFields[nPos][1]
			cValue            := action['ticket']['value']
			cReceiverCategory := ""
			cRecipientId      := ""
			cSubject          := ""
			cEmailContent     := ""
		EndIf

		If action['id'] == nil
			action['id'] := ''
		EndIf

		If action['status'] == 'deleted'
			If Z31->(MsSeek(xFilial("Z31")+action['id']) )
				RecLock("Z31", .F.)
				DbDelete()
				Z31->(MsUnlock())
			EndIf
		ElseIf Z31->(MsSeek(xFilial("Z31")+action['id']) ) .AND. action['id'] != ''
			RecLock("Z31", .F.)
			Z31->Z31_TIPO   := cActionType
			Z31->Z31_CATDES := cReceiverCategory
			Z31->Z31_DESTIN := cRecipientId
			Z31->Z31_ASSUNT := cSubject
			Z31->Z31_CONEMA := cEmailContent
			Z31->Z31_CAMPO  := cField
			Z31->Z31_VALOR  := cValue
			Z31->(MsUnlock())
		Else
			RecLock("Z31", .T.)
			Z31->Z31_FILIAL := xFilial("Z31")
			Z31->Z31_ID     := NextNumero("Z31", 1, "Z31_ID", .T.)
			Z31->Z31_IDGATI := oUserData['id']
			Z31->Z31_TIPO   := cActionType
			Z31->Z31_CATDES := cReceiverCategory
			Z31->Z31_DESTIN := cRecipientId
			Z31->Z31_ASSUNT := cSubject
			Z31->Z31_CONEMA := cEmailContent
			Z31->Z31_CAMPO  := cField
			Z31->Z31_VALOR  := cValue
			Z31->(MsUnlock())
		EndIf
		Z3S->(DbCloseArea())
	Next

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse

method DeleteTag(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3J->(DbSetOrder(1))
	If Z3J->(MsSeek(xFilial("Z3J")+oUserData['id']) )
		RecLock("Z3J", .F.)
		DBDelete()
		Z3J->(MsUnlock())
	EndIf
	Z3J->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been deleted"

return oResponse

method DeleteArticle(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3E->(DbSetOrder(1))
	If Z3E->(MsSeek(xFilial("Z3E")+oUserData['id']) )
		RecLock("Z3E", .F.)
		DBDelete()
		Z3E->(MsUnlock())
	EndIf
	Z3E->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been deleted"

return oResponse

method DeleteTrigger(oUserData) class ArgusModel
	local oResponse := JsonObject():New()
	local nIndex    := 1

	Z3S->(DbSetOrder(1))
	If Z3S->(MsSeek(xFilial("Z3S")+oUserData['id']) )
		RecLock("Z3S", .F.)
		DBDelete()
		Z3S->(MsUnlock())
	EndIf
	Z3S->(DbCloseArea())

	For nIndex := 1 to len(oUserData['allConditions'])
		Z3W->(DbSetOrder(1))
		If Z3W->(MsSeek(xFilial("Z3W")+oUserData['allConditions'][nIndex]['id']) )
			RecLock("Z3W", .F.)
			DBDelete()
			Z3W->(MsUnlock())
		EndIf
		Z3W->(DbCloseArea())
	Next

	For nIndex := 1 to len(oUserData['anyConditions'])
		Z3W->(DbSetOrder(1))
		If Z3W->(MsSeek(xFilial("Z3W")+oUserData['anyConditions'][nIndex]['id']) )
			RecLock("Z3W", .F.)
			DBDelete()
			Z3W->(MsUnlock())
		EndIf
		Z3W->(DbCloseArea())
	Next

	For nIndex := 1 to len(oUserData['actions'])
		Z3Y->(DbSetOrder(1))
		If Z3Y->(MsSeek(xFilial("Z3Y")+oUserData['actions'][nIndex]['id']) )
			RecLock("Z3Y", .F.)
			DBDelete()
			Z3Y->(MsUnlock())
		EndIf
		Z3Y->(DbCloseArea())
	Next

	oResponse['code'] := 200
	oResponse['message'] := "item had been deleted"

return oResponse

method DeleteAutomation(oUserData) class ArgusModel
	local oResponse := JsonObject():New()
	local nIndex    := 1

	Z3R->(DbSetOrder(1))
	If Z3R->(MsSeek(xFilial("Z3R")+oUserData['id']) )
		RecLock("Z3R", .F.)
		DBDelete()
		Z3R->(MsUnlock())
	EndIf
	Z3R->(DbCloseArea())

	For nIndex := 1 to len(oUserData['allConditions'])
		Z3X->(DbSetOrder(1))
		If Z3X->(MsSeek(xFilial("Z3X")+oUserData['allConditions'][nIndex]['id']) )
			RecLock("Z3X", .F.)
			DBDelete()
			Z3X->(MsUnlock())
		EndIf
		Z3X->(DbCloseArea())
	Next

	For nIndex := 1 to len(oUserData['anyConditions'])
		Z3X->(DbSetOrder(1))
		If Z3X->(MsSeek(xFilial("Z3X")+oUserData['anyConditions'][nIndex]['id']) )
			RecLock("Z3X", .F.)
			DBDelete()
			Z3X->(MsUnlock())
		EndIf
		Z3X->(DbCloseArea())
	Next

	For nIndex := 1 to len(oUserData['actions'])
		Z31->(DbSetOrder(1))
		If Z31->(MsSeek(xFilial("Z31")+oUserData['actions'][nIndex]['id']) )
			RecLock("Z31", .F.)
			DBDelete()
			Z31->(MsUnlock())
		EndIf
		Z31->(DbCloseArea())
	Next

	oResponse['code'] := 200
	oResponse['message'] := "item had been deleted"

return oResponse

method PutGroup(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3K->(DbSetOrder(1))
	If Z3K->(MsSeek(xFilial("Z3K")+oUserData['id']) )
		RecLock("Z3K", .F.)
		Z3K->Z3K_NOME  := getFieldData(Z3K->Z3K_NOME, oUserData[ 'name' ])
		Z3K->Z3K_DESC  := getFieldData(Z3K->Z3K_DESC, oUserData[ 'description' ])
		Z3K->(MsUnlock())
	EndIf
	Z3K->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse


method DeleteGroup(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3K->(DbSetOrder(1))
	If Z3K->(MsSeek(xFilial("Z3K")+oUserData['id']) )
		RecLock("Z3K", .F.)
		DBDelete()
		Z3K->(MsUnlock())
	EndIf
	Z3K->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse

method PostInterationsInTicket(oTicket) class ArgusModel
	local oResponse      := JsonObject():New()
	local nIndex         := 1
	local aNames         := {}
	local nPos           := 0
	local cOldFieldValue := ""
	local aFields        := { ;
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
		{"Z3A_IDSOL", "requesterId"}, ;
		{"Z3A_TAGS", "tags"}, ;
		{"Z3A_SEGUID", "followers"}, ;
		{"Z3A_OCORRE", "occurrences"}, ;
		{"Z3A_ASSUNT", "title"} ;
		}


	aNames := oTicket:getNames()

	For nIndex := 1 to len(aNames)
		If aNames[nIndex] != 'id' .AND. aNames[nIndex] != 'operatorId' .AND. oTicket[aNames[nIndex]] != Nil .AND. oTicket[aNames[nIndex]] != ''
			nPos := aScan(aFields, {|x| x[2] == aNames[nIndex]})

			Z3A->(DbSetOrder(1))
			If Z3A->(MsSeek(xFilial("Z3A")+oTicket['id']) )
				RecLock("Z3A", .F.)
				cOldFieldValue := Z3A->&(aFields[nPos][1])
				Z3A->(MsUnlock())
			EndIf

			If cOldFieldValue != oTicket[aNames[nIndex]]
				RecLock("Z3P", .T.)
				Z3P->Z3P_FILIAL := xFilial("Z3P")
				Z3P->Z3P_ID     := NextNumero("Z3P", 1, "Z3P_ID", .T.)
				Z3P->Z3P_IDOPER := oTicket['operatorId']
				Z3P->Z3P_DATINT := Date()
				Z3P->Z3P_HORINT := Time()
				Z3P->Z3P_CAMPO  := aFields[nPos][1]
				Z3P->Z3P_VALANT := cOldFieldValue
				Z3P->Z3P_VALNOV := oTicket[aNames[nIndex]]
				Z3P->Z3P_IDTICK := oTicket[ 'id' ]
				Z3P->(MsUnlock())
			EndIf
		EndIf
	Next

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method SendPasswordRecovery(cEmail) class ArgusModel
	local cToken := ""
	local oFile := JsonObject():New()

	oFile := FWFileReader():New("\workflow\portal\resetarsenha.htm")
	//Local cName       := ::Name

	cToken := cValtochar(Random(111111, 999999))

	RecLock("Z3Q", .T.)
	Z3Q->Z3Q_FILIAL := xFilial("Z3Q")
	Z3Q->Z3Q_ID     := NextNumero("Z3Q", 1, "Z3Q_ID", .T.)
	Z3Q->Z3Q_DATREG := Date()
	Z3Q->Z3Q_EMASOL := cEmail
	Z3Q->Z3Q_HORREG := Left(Time(), 5)
	Z3Q->Z3Q_TOKEN  := cToken
	Z3Q->(MsUnlock())

	oFile:Open()
	cHtml := oFile:FullRead()
	cHtml := StrTran(cHtml, '%token%', cToken)
	EnviaEmail(cEmail, "Resetar Senha", cHtml, {}, .F., .T., .F.)
	oFile:Close()

return

method SendWelcomeAgentEmail(oBody) class ArgusModel
	Local cEmail      := oBody[ 'email' ]
	local oFile := JsonObject():New()

	oFile := FWFileReader():New("\workflow\portal\bemvindo.htm")

	oFile:Open()
	cHtml := oFile:FullRead()
	EnviaEmail(cEmail, "Bem Vindo a 3Corp", cHtml, {}, .F., .T., .F.)
	oFile:Close()

return

method IsCodeValid(cEmail, cToken) class ArgusModel
	local lIsCodeValid := .F.

	BeginSql Alias "SQL_Z3Q"
        SELECT
            Z3Q_ID
        FROM
            Z3Q010
        WHERE
            Z3Q_TOKEN = %Exp:cToken%
        AND
            Z3Q_EMASOL = %Exp:cEmail%
        AND
            D_E_L_E_T_ = ''
	EndSql

	If !SQL_Z3Q->(EoF())
		lIsCodeValid := .T.
	EndIf
	SQL_Z3Q->(DbCloseArea())

return lIsCodeValid

method ResetPassword(oUserData) class ArgusModel
	local cEmail := oUserData['email']
	local cNewPassword := oUserData['newPassword']

	BeginSql Alias "SQL_Z3F"
        SELECT
            Z3F_ID
        FROM
            Z3F010
        WHERE
            Z3F_EMAIL = %Exp:cEmail%
	EndSql

	If !SQL_Z3F->(EoF())
		Z3F->(DbSetOrder(1))
		If Z3F->(MsSeek(xFilial("Z3F")+SQL_Z3F->Z3F_ID) )
			RecLock("Z3F", .F.)
			Z3F->Z3F_PASS   := getFieldData(Z3F->Z3F_PASS, cNewPassword)
			Z3F->(MsUnlock())
		EndIf
		Z3F->(DbCloseArea())
	EndIf
	SQL_Z3F->(DbCloseArea())

	return

method RedefinePassword(oBody) class ArgusModel
	Local cEmail := oBody[ 'email' ]
	local oFile := JsonObject():New()

	oFile := FWFileReader():New("\workflow\portal\senharedefinida.htm")

	oFile:Open()
	cHtml := oFile:FullRead()
	EnviaEmail(cEmail, "Senha Redefinida", cHtml, {}, .F., .T., .F.)
	oFile:Close()

	return

method ImportUsers(oBody) class ArgusModel
	local nIndex := 1
	local aUsers := oBody['users']
	local oResponse := JsonObject():New()

	For nIndex := 1 to len(aUsers)
		Z3F->(DbSetOrder(1))
		If Z3F->(MsSeek(xFilial("Z3F")+aUsers[nIndex]['id']))
			::PutUser(aUsers[nIndex])
		Else
			::PostUser(aUsers[nIndex])
		EndIf
		Z3F->(DbCloseArea())
	Next

	oResponse['code'] := 200
	oResponse['message'] := "Importacao concluida"

	return oResponse

method importOrganizations(oBody) class ArgusModel
	local nIndex := 1
	local aOrganizations := oBody['organizations']
	local oResponse := JsonObject():New()

	For nIndex := 1 to len(aOrganizations)
		Z3V->(DbSetOrder(1))
		If Z3V->(MsSeek(xFilial("Z3V")+aOrganizations[nIndex]['id']))
			::PutOrganization(aOrganizations[nIndex])
		Else
			::PostOrganization(aOrganizations[nIndex])
		EndIf
		Z3V->(DbCloseArea())
	Next

	oResponse['code'] := 200
	oResponse['message'] := "Importacao concluida"

	return oResponse

static function getFieldData(cFieldData, cNewData)
	local cResponse := ""

	If cNewData == NIL
		cResponse := cFieldData
	Else
		cResponse := cNewData
	EndIf

return cResponse


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


method EvaluateTicket(oTicketData) class ArgusModel
	local oResponse := JsonObject():New()

	Z3A->(DbSetOrder(1))
	If Z3A->(MsSeek(xFilial("Z3A") + oTicketData['id']))
		RecLock("Z3A", .F.)
		Z3A->Z3A_SATISF := oTicketData['satisfaction']
		Z3A->(MsUnlock())
	EndIf
	Z3A->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "Ticket Avaliado"

return

method GetContracts(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_CONTRACTS"
        SELECT
            ZAC_ID,
            ZAC_NOME,
            COUNT(*) OVER() AS TOTAL
        FROM
            ZAC010
        WHERE
            D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR ZAC_ID = %Exp:cFilter% 
            )
        ORDER BY
            ZAC_ID
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total'] := SQL_CONTRACTS->TOTAL
	oResponse['hasNext'] := SQL_CONTRACTS->TOTAL > page * pageSize

	While !SQL_CONTRACTS->(EoF())
		oItem[ 'id' ]   := Alltrim(SQL_CONTRACTS->ZAC_ID)
		oItem[ 'name' ] := Alltrim(SQL_CONTRACTS->ZAC_NOME)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_CONTRACTS->(DbSkip())
	EndDo
	SQL_CONTRACTS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method PostContracts(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("ZAC", .T.)
	ZAC->ZAC_FILIAL := xFilial("ZAC")
	ZAC->ZAC_ID     := NextNumero("ZAC", 1, "ZAC_ID", .T.)
	ZAC->ZAC_NOME   := getFieldData(ZAC->ZAC_NOME, oUserData[ 'name' ])
	ZAC->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PutContracts(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	ZAC->(DbSetOrder(1))
	If ZAC->(MsSeek(xFilial("ZAC")+oUserData['id']) )
		RecLock("ZAC", .F.)
			ZAC->ZAC_NOME  := getFieldData(ZAC->ZAC_NOME, oUserData[ 'name' ])
		ZAC->(MsUnlock())
	EndIf
	ZAC->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse

method DeleteContracts(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	ZAC->(DbSetOrder(1))
	If ZAC->(MsSeek(xFilial("ZAC")+oUserData['id']) )
		RecLock("ZAC", .F.)
		DBDelete()
		ZAC->(MsUnlock())
	EndIf
	ZAC->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been deleted"

return oResponse

method PostLocalizations(oUserData) class ArgusModel
	local oResponse        := JsonObject():New()
	Local cErrorLog        := ""
	Local aDados           := {}
    Local aLogAuto         := {}
    Local nLinha           := 0
	Private lMSHelpAuto    := .T.
    Private lAutoErrNoFile := .T.
    Private lMsErroAuto    := .F.

	DbSelectArea("CC2")
	CC2->(DbSetOrder(1))
	aAdd(aDados, {'CC2_EST',    getFieldData(CC2->CC2_EST, oUserData[ 'state' ]),    Nil})
	aAdd(aDados, {'CC2_CODMUN', getFieldData(CC2->CC2_CODMUN, oUserData[ 'value' ])})
	aAdd(aDados, {'CC2_MUN',    getFieldData(CC2->CC2_MUN, oUserData[ 'label' ]), Nil})

	MsExecAuto({|x, y| FISA010(x, y)}, aDados, 3)

	If lMsErroAuto
        cErrorLog   := ''
		aLogAuto    := GetAutoGRLog()
		For nLinha := 5 To 6 // tratativa para retornar somente os erros principais. 
			cErrorLog += aLogAuto[nLinha] + CRLF 
		Next nLinha

        oResponse['code'] := 500
		oResponse['message'] := FwCutOff(cErrorLog,.T.)
		
	Else
		oResponse['code'] := 200
		oResponse['message'] := "item had been created"

	EndIf

return oResponse

method PutLocalizations(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	CC2->(DbSetOrder(1))
	If CC2->(MsSeek(xFilial("CC2")+oUserData['state']+oUserData['value']) )
		RecLock("CC2", .F.)
			CC2->CC2_MUN  := getFieldData(CC2->CC2_MUN, UPPER(oUserData[ 'label' ]))
		CC2->(MsUnlock())
	EndIf   
	CC2->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse

method DeleteLocalizations(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	CC2->(DbSetOrder(1))
	If CC2->(MsSeek(xFilial("CC2")+oUserData['state']+oUserData['value']) )
		RecLock("CC2", .F.)
		DBDelete()
		CC2->(MsUnlock())
	EndIf
	CC2->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been deleted"

return oResponse

method GetServiceFormats(cId, page, pageSize, cFilter) class ArgusModel
	Local offset     := 0
	local oResponse  := JsonObject():New()
	local oItem      := JsonObject():New()
	local aItems     := {}
	Default page     := 1
	Default pageSize := 10
	Default cFilter   := ''

	offset := pageSize * (page -1)

	BeginSql Alias "SQL_SERVICE_FORMATS"
        SELECT
            ZAD_ID,
            ZAD_NOME,
            COUNT(*) OVER() AS TOTAL
        FROM
            ZAD010
        WHERE
            D_E_L_E_T_ = ''
            AND (
                %Exp:cFilter% = ''
                OR ZAD_ID = %Exp:cFilter% 
            )
        ORDER BY
            ZAD_ID
        OFFSET %Exp:offset% ROWS
        FETCH NEXT %Exp:pageSize% ROWS ONLY
	EndSql

	oResponse['total']   := SQL_SERVICE_FORMATS->TOTAL
	oResponse['hasNext'] := SQL_SERVICE_FORMATS->TOTAL > page * pageSize

	While !SQL_SERVICE_FORMATS->(EoF())
		oItem[ 'id' ]     := Alltrim(SQL_SERVICE_FORMATS->ZAD_ID)
		oItem[ 'name' ]   := Alltrim(SQL_SERVICE_FORMATS->ZAD_NOME)

		aadd(aItems, oItem)
		oItem := JsonObject():New()

		SQL_SERVICE_FORMATS->(DbSkip())
	EndDo
	SQL_SERVICE_FORMATS->(DbCloseArea())

	oResponse['items'] := aItems

return oResponse

method PostServiceFormats(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	RecLock("ZAD", .T.)
		ZAD->ZAD_FILIAL := xFilial("ZAD")
		ZAD->ZAD_ID     := NextNumero("ZAD", 1, "ZAD_ID", .T.)
		ZAD->ZAD_NOME   := getFieldData(ZAD->ZAD_NOME, oUserData[ 'name' ])
	ZAD->(MsUnlock())

	oResponse['code'] := 200
	oResponse['message'] := "item had been created"

return oResponse

method PutServiceFormats(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	ZAD->(DbSetOrder(1))
	If ZAD->(MsSeek(xFilial("ZAD")+oUserData['id']) )
		RecLock("ZAD", .F.)
			ZAD->ZAD_NOME  := getFieldData(ZAC->ZAC_NOME, oUserData[ 'name' ])
		ZAD->(MsUnlock())
	EndIf
	ZAD->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been changed"

return oResponse

method DeleteServiceFormats(oUserData) class ArgusModel
	local oResponse := JsonObject():New()

	ZAD->(DbSetOrder(1))
	If ZAD->(MsSeek(xFilial("ZAD")+oUserData['id']) )
		RecLock("ZAD", .F.)
		DBDelete()
		ZAD->(MsUnlock())
	EndIf
	ZAD->(DbCloseArea())

	oResponse['code'] := 200
	oResponse['message'] := "item had been deleted"

return oResponse
