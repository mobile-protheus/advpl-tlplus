#include 'protheus.ch'
#include 'topconn.ch'
#Include "Totvs.ch"
#Include "parmtype.ch"
#Include "tbiconn.ch"

user function executeAutomations()
    local oModel := JsonObject():New()

    oModel := AutomationsModel():New()
    oModel:CheckAutomations()

    return
