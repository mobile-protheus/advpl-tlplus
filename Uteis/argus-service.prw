#include 'Totvs.ch'
#include 'RestFul.ch'

WSRESTFUL Argus Description "Argus"
	// Pagination, Filter
	WSDATA page as integer
	WSDATA pageSize as integer
	WSDATA filter as string
	WSDATA id as string
	WSDATA requesterId as string
	WSDATA queueId as string
	WSDATA canGetPrivateMessages as string
	WSDATA organizationId as string
	WSDATA assigned as string
	WSDATA follower as string
	WSDATA groupId as string
	WSDATA initialDate as string
	WSDATA endDate as string

	WSMETHOD POST orgAttachment Description "Returns products" WSSYNTAX "/organization-attachment" PATH "/organization-attachment"
	WSMETHOD GET PRODUCTS Description "Returns products" WSSYNTAX "/products" PATH "/products"
	WSMETHOD GET localizations Description "Returns localizations" WSSYNTAX "/localizations" PATH "/localizations"
	WSMETHOD GET tick Description "Returns ticket" WSSYNTAX "/ticket" PATH "/ticket"
	WSMETHOD GET tickets Description "Returns tickets" WSSYNTAX "/tickets" PATH "/tickets"
	WSMETHOD GET messages Description "Returns messages" WSSYNTAX "/messages" PATH "/messages"
	WSMETHOD GET queues Description "Returns queues" WSSYNTAX "/queues" PATH "/queues"
	WSMETHOD GET tags Description "Returns tags" WSSYNTAX "/tags" PATH "/tags"
	WSMETHOD GET articles Description "Returns articles" WSSYNTAX "/articles" PATH "/articles"
	WSMETHOD GET groups Description "Returns groups" WSSYNTAX "/groups" PATH "/groups"
	WSMETHOD GET user Description "Returns user" WSSYNTAX "/user" PATH "/user"
	WSMETHOD GET users Description "Returns users" WSSYNTAX "/users" PATH "/users"
	WSMETHOD GET agents Description "Returns agents" WSSYNTAX "/agents" PATH "/agents"
	WSMETHOD GET macros Description "Returns macros" WSSYNTAX "/macros" PATH "/macros"
	WSMETHOD GET organizations Description "Returns organizations" WSSYNTAX "/organizations" PATH "/organizations"
	WSMETHOD GET org Description "Returns organization" WSSYNTAX "/organization" PATH "/organization"
	WSMETHOD GET slas Description "Returns slas" WSSYNTAX "/slas" PATH "/slas"
	WSMETHOD GET history Description "Returns ticket history" WSSYNTAX "/ticket-history" PATH "/ticket-history"
	WSMETHOD GET agentInfo Description "Returns agent info" WSSYNTAX "/agent-info" PATH "/agent-info"
	WSMETHOD GET automations Description "Returns automations" WSSYNTAX "/automations" PATH "/automations"
	WSMETHOD GET triggers Description "Returns triggers" WSSYNTAX "/triggers" PATH "/triggers"
	WSMETHOD GET slaTickets Description "Returns slaTickets" WSSYNTAX "/slaTickets" PATH "/slaTickets"
	WSMETHOD GET occurrences Description "Returns occurrences" WSSYNTAX "/occurrences" PATH "/occurrences"
	WSMETHOD GET contracts Description "Returns contracts" WSSYNTAX "/contracts" PATH "/contracts" 
	WSMETHOD GET ServiceFormats Description "Returns Service Formats" WSSYNTAX "/serviceformats" PATH "/serviceformats" 
	WSMETHOD PUT user Description "update user" WSSYNTAX "/user" PATH "/user"
	WSMETHOD PUT occurrence Description "update occurrence" WSSYNTAX "/occurrence" PATH "/occurrence"
	WSMETHOD PUT sla Description "update sla" WSSYNTAX "/sla" PATH "/sla"
	WSMETHOD PUT organization Description "update organization" WSSYNTAX "/organization" PATH "/organization"
	WSMETHOD PUT agent Description "update agent" WSSYNTAX "/agent" PATH "/agent"
	WSMETHOD PUT queue Description "update user" WSSYNTAX "/queue" PATH "/queue"
	WSMETHOD PUT tag Description "update user" WSSYNTAX "/tag" PATH "/tag"
	WSMETHOD PUT article Description "update article" WSSYNTAX "/article" PATH "/article"
	WSMETHOD PUT group Description "update user" WSSYNTAX "/group" PATH "/group"
	WSMETHOD PUT ticket Description "update ticket" WSSYNTAX "/ticket" PATH "/ticket"
	WSMETHOD PUT macro Description "update macro" WSSYNTAX "/macro" PATH "/macro"
	WSMETHOD PUT automation Description "update automation" WSSYNTAX "/automation" PATH "/automation"
	WSMETHOD PUT trigger Description "update triggers" WSSYNTAX "/trigger" PATH "/trigger"
	WSMETHOD PUT evaluateTicket Description "Creates user" WSSYNTAX "/evaluate-ticket" PATH "/evaluate-ticket"
	WSMETHOD PUT contracts Description "update user" WSSYNTAX "/contracts" PATH "/contracts"
	WSMETHOD PUT localizations Description "update localizations" WSSYNTAX "/localizations" PATH "/localizations"
	WSMETHOD PUT ServiceFormats Description "update Service Formats" WSSYNTAX "/serviceformats" PATH "/serviceformats"
	WSMETHOD POST user Description "Creates user" WSSYNTAX "/user" PATH "/user"
	WSMETHOD POST organization Description "Creates organization" WSSYNTAX "/organization" PATH "/organization"
	WSMETHOD POST sla Description "Creates sla" WSSYNTAX "/sla" PATH "/sla"
	WSMETHOD POST agent Description "Creates agent" WSSYNTAX "/agent" PATH "/agent"
	WSMETHOD POST cLogin Description "customer login" WSSYNTAX "/customer-login" PATH "/customer-login"
	WSMETHOD POST aLogin Description "agent login" WSSYNTAX "/agent-login" PATH "/agent-login"
	WSMETHOD POST queue Description "do login" WSSYNTAX "/queue" PATH "/queue"
	WSMETHOD POST tag Description "do login" WSSYNTAX "/tag" PATH "/tag"
	WSMETHOD POST article Description "do login" WSSYNTAX "/article" PATH "/article"
	WSMETHOD POST group Description "do login" WSSYNTAX "/group" PATH "/group"
	WSMETHOD POST macro Description "Delete macro" WSSYNTAX "/macro" PATH "/macro"
	WSMETHOD POST recovery Description "Send password recovery" WSSYNTAX "/password-recovery" PATH "/password-recovery"
	WSMETHOD POST verifyCode Description "Verify code" WSSYNTAX "/verify-code" PATH "/verify-code"
	WSMETHOD POST veriEmail Description "Verify email" WSSYNTAX "/verify-email" PATH "/verify-email"
	WSMETHOD POST resetPassword Description "reset password" WSSYNTAX "/reset-password" PATH "/reset-password"
	WSMETHOD POST automation Description "create automation" WSSYNTAX "/automation" PATH "/automation"
	WSMETHOD POST trigger Description "create trigger" WSSYNTAX "/trigger" PATH "/trigger"
	WSMETHOD POST occurrence Description "create occurrence" WSSYNTAX "/occurrence" PATH "/occurrence"
	WSMETHOD POST contracts Description "Creates contracts" WSSYNTAX "/contracts" PATH "/contracts"
	WSMETHOD POST localizations Description "Creates localizations" WSSYNTAX "/localizations" PATH "/localizations"
	WSMETHOD POST ServiceFormats Description "Creates Service Formats" WSSYNTAX "/serviceformats" PATH "/serviceformats"
	WSMETHOD POST redefinePassword Description "redefinePassword" WSSYNTAX "/redefine-password" PATH "/redefine-password"
	WSMETHOD POST impUsers Description "importUsers" WSSYNTAX "/import-users" PATH "/import-users"
	WSMETHOD POST impOrganizations Description "import organizations" WSSYNTAX "/import-organizations" PATH "/import-organizations"
	WSMETHOD DELETE agent Description "Delete agent" WSSYNTAX "/agent" PATH "/agent"
	WSMETHOD DELETE organization Description "Delete organization" WSSYNTAX "/organization" PATH "/organization"
	WSMETHOD DELETE tag Description "Delete tag" WSSYNTAX "/tag" PATH "/tag"
	WSMETHOD DELETE article Description "Delete article" WSSYNTAX "/article" PATH "/article"
	WSMETHOD DELETE queue Description "Delete queue" WSSYNTAX "/queue" PATH "/queue"
	WSMETHOD DELETE group Description "Delete group" WSSYNTAX "/group" PATH "/group"
	WSMETHOD DELETE macro Description "Delete macro" WSSYNTAX "/macro" PATH "/macro"
	WSMETHOD DELETE user Description "Delete user" WSSYNTAX "/user" PATH "/user"
	WSMETHOD DELETE sla Description "Delete sla" WSSYNTAX "/sla" PATH "/sla"
	WSMETHOD DELETE automation Description "Delete automation" WSSYNTAX "/automation" PATH "/automation"
	WSMETHOD DELETE trigger Description "Delete trigger" WSSYNTAX "/trigger" PATH "/trigger"
	WSMETHOD DELETE occurrence Description "Delete occurrence" WSSYNTAX "/occurrence" PATH "/occurrence"
	WSMETHOD DELETE attachment Description "Delete organization-attachment" WSSYNTAX "/organization-attachment" PATH "/organization-attachment"
	WSMETHOD DELETE contracts Description "Delete contracts" WSSYNTAX "/contracts" PATH "/contracts"
	WSMETHOD DELETE localizations Description "Delete localizations" WSSYNTAX "/localizations" PATH "/localizations"
	WSMETHOD DELETE ServiceFormats Description "Delete Service Formats" WSSYNTAX "/serviceformats" PATH "/serviceformats"
END WSRESTFUL

// MÉTODO GET
WSMETHOD POST orgAttachment WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody     := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostOrgAttachment(oBody)

	Self:SetResponse(oResponse)

Return .T.

WSMETHOD DELETE attachment  WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody     := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DelOrgAttachment(oBody)

	Self:SetResponse(oResponse)

Return .T.

WSMETHOD GET automations WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetAutomations(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET PRODUCTS WSRECEIVE page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetProducts(cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET occurrences WSRECEIVE page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetOccurrences(cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.


WSMETHOD GET localizations WSRECEIVE page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetLocalizations(cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET messages WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cTicketId := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetMessages(cTicketId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.


WSMETHOD GET macros WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetMacros(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.


WSMETHOD GET tickets WSRECEIVE page, pageSize, filter, requesterId, queueId, organizationId, assigned, follower WSSERVICE Argus
	local oResponse       := JsonObject():New()
	local cPage           := self:page
	local cPageSize       := self:pageSize
	local cFilter         := self:filter
	local cRequesterId    := self:requesterId
	local cQueueId        := self:queueId
	local cOrganizationId := self:organizationId
	local cAssigned       := self:assigned
	local cFollower       := self:follower

	If cPage == Nil
		cPage := ""
	EndIf

	If cPageSize == Nil
		cPageSize := ""
	EndIf

	If cFilter == Nil
		cFilter := ""
	EndIf

	If cRequesterId == Nil
		cRequesterId := ""
	EndIf

	If cQueueId == Nil
		cQueueId := ""
	EndIf

	If cOrganizationId == Nil
		cOrganizationId := ""
	EndIf

	If cAssigned == Nil
		cAssigned := ""
	EndIf


	If cFollower == Nil
		cFollower := ""
	EndIf

	self:SetContentType('application/json')

	oResponse := ArgusController():GetTickets(cPage, cPageSize, cFilter, cRequesterId, cQueueId, cOrganizationId, cAssigned, cFollower)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET slaTickets WSRECEIVE id, initialDate, endDate WSSERVICE Argus
	local oResponse    := JsonObject():New()
	local cSlaId       := self:id
	local cInitialDate := self:initialDate
	local cEndDate     := self:endDate

	If cSlaId == Nil
		cSlaId := ""
	EndIf

	If cInitialDate == Nil
		cInitialDate := ""
	EndIf

	If cEndDate == Nil
		cEndDate := ""
	EndIf

	self:SetContentType('application/json')

	oResponse := ArgusController():GetSlaTickets(cSlaId, cInitialDate, cEndDate)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET tick WSRECEIVE id, canGetPrivateMessages WSSERVICE Argus
	local oResponse              := JsonObject():New()
	local cId                    := self:id
	local cCanGetPrivateMessages := self:canGetPrivateMessages

	self:SetContentType('application/json')

	oResponse := ArgusController():GetTicket(cId, cCanGetPrivateMessages)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET user WSRECEIVE id WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId     := self:id

	self:SetContentType('application/json')

	oResponse := ArgusController():GetUser(cId)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET users WSRECEIVE id, page, pageSize, filter, organizationId WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter
	local cOrganizationId   := self:organizationId

	self:SetContentType('application/json')

	oResponse := ArgusController():GetUsers(cId, cPage, cPageSize, cFilter, cOrganizationId)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET agents WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetAgents(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.


WSMETHOD GET organizations WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetOrganizations(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET slas WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetSLAs(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET history WSRECEIVE id WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id

	self:SetContentType('application/json')

	oResponse := ArgusController():GetHistory(cId)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET agentInfo WSRECEIVE id WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cAgentId  := self:id

	self:SetContentType('application/json')

	oResponse := ArgusController():GetAgentInfo(cAgentId)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET org WSRECEIVE id WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id

	self:SetContentType('application/json')

	oResponse := ArgusController():GetOrg(cId)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET queues WSRECEIVE id, page, pageSize, filter, groupId WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter
	local cGroupId := self:groupId

	self:SetContentType('application/json')

	oResponse := ArgusController():GetQueues(cId, cPage, cPageSize, cFilter, cGroupId)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET tags WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetTags(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET articles WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetArticles(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET triggers WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetTriggers(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET groups WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetGroups(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT organization WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutOrganization(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT user WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutUser(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT sla WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutSLA(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST OCCURRENCE WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostOccurrence(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT OCCURRENCE WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutOccurrence(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE OCCURRENCE WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteOccurrence(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST AGENT WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostAgent(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT AGENT WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutAgent(oBody)

	self:setresponse(oResponse)

return .t.


WSMETHOD DELETE ORGANIZATION WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteOrganization(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE AGENT WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteAgent(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT macro WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutMacro(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST macro WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostMacro(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST recovery WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():SendPasswordRecovery(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST verifyCode WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():VerifyCode(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST veriEmail WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():VerifyEmail(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST resetPassword WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():ResetPassword(oBody)

	self:setresponse(oResponse)

	return .t.

WSMETHOD POST redefinePassword WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():redefinePassword(oBody)

	self:setresponse(oResponse)

	return .t.

WSMETHOD POST impUsers WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():importUsers(oBody)

	self:setresponse(oResponse)

	return .t.

WSMETHOD POST impOrganizations WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():importOrganizations(oBody)

	self:setresponse(oResponse)

	return .t.


WSMETHOD DELETE macro WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteMacro(oBody)

	self:setresponse(oResponse)

return .t.


WSMETHOD DELETE sla WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteSLA(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST user WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostUser(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST sla WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostSLA(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD POST organization WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostOrganization(oBody)

	self:setresponse(oResponse)

return .t.


WSMETHOD post cLogin WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DoLogin(oBody)

	self:setresponse(oResponse)

return .t.


WSMETHOD post aLogin WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DoAgentLogin(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD post queue WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostQueue(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD post tag WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostTag(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD post article WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostArticle(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD post trigger WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostTrigger(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD post automation WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostAutomation(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE tag WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteTag(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE article WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteArticle(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE trigger WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteTrigger(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE automation WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteAutomation(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE group WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteGroup(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE queue WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteQueue(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD post group WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostGroup(oBody)

	self:setresponse(oResponse)

return .t.


WSMETHOD PUT ticket WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutTicket(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT queue WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutQueue(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT tag WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutTag(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT article WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutArticle(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT trigger WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutTrigger(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT evaluateTicket WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():EvaluateTicket(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT automations WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutAutomation(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT group WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutGroup(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET contracts WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetContracts(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD post contracts WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostContracts(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT contracts WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutContracts(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE contracts WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteContracts(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD post localizations WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostLocalizations(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT localizations WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutLocalizations(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE localizations WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteLocalizations(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD GET ServiceFormats WSRECEIVE id, page, pageSize, filter WSSERVICE Argus
	local oResponse := JsonObject():New()
	local cId       := self:id
	local cPage     := self:page
	local cPageSize := self:pageSize
	local cFilter   := self:filter

	self:SetContentType('application/json')

	oResponse := ArgusController():GetServiceFormats(cId, cPage, cPageSize, cFilter)

	self:setresponse(oResponse)

return .t.

WSMETHOD post ServiceFormats WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PostServiceFormats(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD PUT ServiceFormats WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():PutServiceFormats(oBody)

	self:setresponse(oResponse)

return .t.

WSMETHOD DELETE ServiceFormats WSSERVICE Argus
	local oResponse := JsonObject():New()
	local oBody := JsonObject():New()

	oBody:FromJson(::GetContent())

	self:SetContentType('application/json')

	oResponse := ArgusController():DeleteServiceFormats(oBody)

	self:setresponse(oResponse)

return .t.
