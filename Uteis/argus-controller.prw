#include 'protheus.ch'
#include 'topconn.ch'
#Include "Totvs.ch"
#Include "parmtype.ch"
#Include "tbiconn.ch"
//

class ArgusController from longclassname
    static method getProducts()
    static method GetLocalizations()
    static method GetMessages()
    static method GetTickets()
    static method GetOccurrences()
    static method PostOccurrence()
    static method PutOccurrence()
    static method DeleteOccurrence()
    static method GetSlaTickets()
    static method DoLogin()
    static method DoAgentLogin()
    static method GetUser()
    static method GetUsers()
    static method GetAgents()
    static method GetQueues()
    static method GetTags()
    static method GetArticles()
    static method GetTriggers()
    static method GetAutomations()
    static method GetGroups()
    static method GetTicket()
    static method PutUser()
    static method PutOrganization()
    static method PostOrganization()
    static method PostSLA()
    static method PutTicket()
    static method PutQueue()
    static method PutTag()
    static method PutArticle()
    static method PutTrigger()
    static method PutAutomation()
    static method PutSla()
    static method PutGroup()
    static method PostUser()
    static method PostQueue()
    static method PostTag()
    static method PostArticle()
    static method PostTrigger()
    static method PostAutomation()
    static method PostGroup()
    static method DeleteTag()
    static method DeleteArticle()
    static method DeleteTrigger()
    static method DeleteAutomation()
    static method DeleteGroup()
    static method DeleteQueue()
    static method GetMacros()
    static method PutMacro()
    static method PostMacro()
    static method DeleteMacro()
    static method PutAgent()
    static method PostAgent()
    static method DeleteAgent()
    static method DeleteSLA()
    static method GetOrganizations()
    static method GetSLAs()
    static method GetOrg()
    static method GetHistory()
    static method GetAgentInfo()
    static method DeleteOrganization()
    static method SendPasswordRecovery()
    static method VerifyCode()
    static method VerifyEmail()
    static method ResetPassword()
    static method redefinePassword()
    static method importUsers()
    static method importOrganizations()
    static method PostOrgAttachment()
    static method DelOrgAttachment()
    static method EvaluateTicket()
    static method GetContracts()
    static method PostContracts()
    static method PutContracts()
    static method DeleteContracts()
    static method PostLocalizations()
    static method PutLocalizations()
    static method DeleteLocalizations()
    static method GetServiceFormats()
    static method PostServiceFormats()
    static method PutServiceFormats()
    static method DeleteServiceFormats()
    endclass

static method GetProducts(cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetProducts(cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetOccurrences(cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetOccurrences(cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetLocalizations(cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetLocalizations(cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetMessages(cTicketId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetMessages(cTicketId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetTickets(cPage, cPageSize, cFilter, cRequesterId, cQueueId, cOrganizationId, cAssigned, cFollower) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetTickets(cPage, cPageSize, cFilter, cRequesterId, cQueueId, cOrganizationId, cAssigned, '', '', cFollower)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult


static method GetSlaTickets(cSlaId, cInitialDate, cEndDate) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetSlaTickets(cSlaId, cInitialDate, cEndDate)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method DoLogin(oLoginCredentials) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DoLogin(oLoginCredentials)
    
    return oJsonResult

static method DoAgentLogin(oLoginCredentials) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DoAgentLogin(oLoginCredentials)
    
    return oJsonResult

static method GetUser(cId) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetUser(cId)
    
    return oJsonResult

static method GetUsers(cId, cPage, cPageSize, cFilter, cOrganizationId) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetUsers(cId, cPage, cPageSize, cFilter, cOrganizationId)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetAgents(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetAgents(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetOrganizations(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetOrganizations(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetSLAs(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetSLAs(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetHistory(cTicketId) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetHistory(cTicketId)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetAgentInfo(cAgentId) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetAgentInfo(cAgentId)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetOrg(cId) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetOrg(cId)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method PostOrgAttachment(oBody) class ArgusController
    local oResponse := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oResponse := oArgusModel:PostOrgAttachment(oBody)
    
    return oResponse

static method DelOrgAttachment(oBody) class ArgusController
    local oResponse := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oResponse := oArgusModel:DelOrgAttachment(oBody)
    
    return oResponse

static method GetQueues(cId, cPage, cPageSize, cFilter, cGroupId) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetQueues(cId, cPage, cPageSize, cFilter, cGroupId)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetMacros(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetMacros(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method PutMacro(oBody) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutMacro(oBody)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method PostMacro(oBody) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostMacro(oBody)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method PostOccurrence(oBody) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostOccurrence(oBody)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method PutOccurrence(oBody) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutOccurrence(oBody)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method DeleteOccurrence(oBody) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteOccurrence(oBody)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method DeleteMacro(oBody) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteMacro(oBody)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetTags(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetTags(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetArticles(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetArticles(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No articles found'
    endif

    return oJsonResult


static method GetTriggers(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetTriggers(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetAutomations(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetAutomations(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method GetGroups(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetGroups(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No products found'
    endif

    return oJsonResult

static method PutUser(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutUser(oUserData)
    
    return oJsonResult


static method PutOrganization(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutOrganization(oUserData)
    
    return oJsonResult

static method PutAgent(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutAgent(oUserData)
    
    return oJsonResult

static method EvaluateTicket(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:EvaluateTicket(oUserData)
    
    return oJsonResult

static method PostAgent(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()
    local oJsonResult :=  JsonObject():New()

    oArgusModel := ArgusModel():New()

    If oArgusModel:AgentEmailExist(oUserData['email'])
        oJsonResult['code'] := 401
        oJsonResult['message'] := "Email Ja cadastrado!"
    Else
        //oArgusModel:PostUser(oUserData)
        oJsonResult := oArgusModel:PostAgent(oUserData)
        oArgusModel:SendWelcomeAgentEmail(oUserData)
    EndIf
    
    return oJsonResult

static method DeleteAgent(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteAgent(oUserData)
    
    return oJsonResult

static method DeleteSLA(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteSLA(oUserData)
    
    return oJsonResult


static method DeleteOrganization(oBody) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteOrganization(oBody)
    
    return oJsonResult


static method PostUser(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostUser(oUserData)

    If oUserData['type'] == '2'
        oArgusModel:SendWelcomeAgentEmail(oUserData)
    EndIf
    
    return oJsonResult

static method PostOrganization(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostOrganization(oUserData)
    
    return oJsonResult

static method PostSLA(oUserData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostSLA(oUserData)
    
    return oJsonResult

static method PutTicket(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutTicket(oTicketData)
    
    return oJsonResult

static method PostQueue(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostQueue(oTicketData)
    
    return oJsonResult

static method PutQueue(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutQueue(oTicketData)
    
    return oJsonResult

static method PostTag(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostTag(oTicketData)
    
    return oJsonResult

static method PostArticle(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostArticle(oTicketData)
    
    return oJsonResult

static method PostTrigger(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostTrigger(oTicketData)
    
    return oJsonResult

static method PostAutomation(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostAutomation(oTicketData)
    
    return oJsonResult


static method PutTag(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutTag(oTicketData)
    
    return oJsonResult

static method PutArticle(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutArticle(oTicketData)
    
    return oJsonResult

static method PutTrigger(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutTrigger(oTicketData)
    
    return oJsonResult

static method PutAutomation(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutAutomation(oTicketData)
    
    return oJsonResult


static method DeleteTag(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteTag(oTicketData)
    
    return oJsonResult

static method DeleteArticle(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteArticle(oTicketData)
    
    return oJsonResult

static method DeleteTrigger(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteTrigger(oTicketData)
    
    return oJsonResult

static method DeleteAutomation(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteAutomation(oTicketData)
    
    return oJsonResult

static method DeleteGroup(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteGroup(oTicketData)
    
    return oJsonResult

static method DeleteQueue(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteQueue(oTicketData)
    
    return oJsonResult

static method PostGroup(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostGroup(oTicketData)
    
    return oJsonResult

static method PutGroup(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutGroup(oTicketData)
    
    return oJsonResult

static method PutSLA(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutSLA(oTicketData)
    
    return oJsonResult


static method GetTicket(cId, cCanGetPrivateMessages) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetTicket(cId, cCanGetPrivateMessages)
    
    return oJsonResult


static method SendPasswordRecovery(oBody) class ArgusController
    local oArgusModel := JsonObject():New()
    local oJsonResult := JsonObject():New()

    oArgusModel := ArgusModel():New()

    If Empty(oBody['email'])
        oJsonResult['code'] := 401
        oJsonResult['message'] := "Houve um erro no envio do email"
    Else
        If oArgusModel:EmailExist(oBody['email'])
            oArgusModel:SendPasswordRecovery(oBody['email'])

            oJsonResult['code'] := 200
            oJsonResult['message'] := "Email enviado com sucesso"
        Else
            oJsonResult['code'] := 401
            oJsonResult['message'] := EncodeUtf8("Não foi encontrado nenhum cadastro com esse email!")
        EndIf

    EndIf
    
    return oJsonResult


static method VerifyCode(oBody) class ArgusController
    local oArgusModel := JsonObject():New()
    local oJsonResult := JsonObject():New()

    oArgusModel := ArgusModel():New()

    If oArgusModel:IsCodeValid(oBody['email'], oBody['verificationCode'])
        oJsonResult['code'] := 200
        oJsonResult['message'] := "Codigo Validado com sucesso"
    Else 
        oJsonResult['code'] := 400
        oJsonResult['message'] := "Codigo Invalido!"
    EndIf

    return oJsonResult

static method VerifyEmail(oBody) class ArgusController
    local oArgusModel := JsonObject():New()
    local oJsonResult := JsonObject():New()

    oArgusModel := ArgusModel():New()

    If oArgusModel:EmailExist(oBody['email'])
        oJsonResult['code'] := 400
        oJsonResult['message'] := "Esse email ja esta cadastrado!"
    Else 
        oJsonResult['code'] := 200
        oJsonResult['message'] := "Email validado!"
        oArgusModel:SendPasswordRecovery(oBody['email'])
    EndIf

    return oJsonResult

static method ResetPassword(oBody) class ArgusController
    local oArgusModel := JsonObject():New()
    local oJsonResult := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oArgusModel:ResetPassword(oBody)

    oJsonResult['code'] := 200
    oJsonResult['message'] := "Senha alterada com sucesso!"

    return oJsonResult

static method RedefinePassword(oBody) class ArgusController
    local oArgusModel := JsonObject():New()
    local oJsonResult := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oArgusModel:RedefinePassword(oBody)

    oJsonResult['code'] := 200
    oJsonResult['message'] := "Senha redefinida com sucesso!"

    return oJsonResult

static method ImportUsers(oBody) class ArgusController
    local oArgusModel := JsonObject():New()
    local oJsonResult := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oArgusModel:ImportUsers(oBody)

    oJsonResult['code'] := 200
    oJsonResult['message'] := "Senha redefinida com sucesso!"

    return oJsonResult

static method importOrganizations(oBody) class ArgusController
    local oArgusModel := JsonObject():New()
    local oJsonResult := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oArgusModel:importOrganizations(oBody)

    oJsonResult['code'] := 200
    oJsonResult['message'] := "Senha redefinida com sucesso!"

    return oJsonResult


static method GetContracts(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetContracts(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No contracts found'
    endif

    return oJsonResult

    static method PostContracts(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostContracts(oTicketData)
    
    return oJsonResult

    
static method PutContracts(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutContracts(oTicketData)
    
    return oJsonResult

static method DeleteContracts(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteContracts(oTicketData)
    
    return oJsonResult

static method PostLocalizations(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostLocalizations(oTicketData)
    
    return oJsonResult

static method PutLocalizations(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutLocalizations(oTicketData)
    
    return oJsonResult

static method DeleteLocalizations(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteLocalizations(oTicketData)
    
    return oJsonResult

static method GetServiceFormats(cId, cPage, cPageSize, cFilter) class ArgusController
    local oJsonResult := JsonObject():New()
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:GetServiceFormats(cId, cPage, cPageSize, cFilter)
    
    if oJsonResult == nil
        oJsonResult['responseCode'] := '404'
        oJsonResult['response'] := 'No service formats found'
    endif

    return oJsonResult

static method PostServiceFormats(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PostServiceFormats(oTicketData)
    
    return oJsonResult

static method PutServiceFormats(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:PutServiceFormats(oTicketData)
    
    return oJsonResult

static method DeleteServiceFormats(oTicketData) class ArgusController
    local oArgusModel := JsonObject():New()

    oArgusModel := ArgusModel():New()

    oJsonResult := oArgusModel:DeleteServiceFormats(oTicketData)
    
    return oJsonResult
