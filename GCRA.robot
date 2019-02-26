*** Settings ***

Suite Setup      Connect To Database	psycopg2	${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect From Databascmdcmde	

Library	Selenium2Library
Library	DateTime
Library	DatabaseLibrary
Library	OperatingSystem
Library	String

*** Variables ***

${DBHost}	52.3.229.153
${DBName}	serviceportal
${DBPass}	passw0rd
${DBPort}	10899
${DBUser}	postgres
${url}	https://egiftcard-dev.herokuapp.com/login
${browser}	gc
${RAusername}	Jayanth
${RApassword}	vadi7932
${Logout}	xpath=//*[@href='logout']

*** Keywords ***

Login Validation    

	Open Browser	${url}	${browser}
	Maximize Browser Window
	Selenium2Library.Input Text	name=userName	${RAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${RAusername}
	Selenium2Library.Input Text	name=password	${RApassword}
	s${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${RApassword}
	Click Element	id=btn-login
	Sleep	10
	Click Element	${Logout}
	Close Browser	


Commission Report

	Open Browser	${url}	${browser}
	Maximize Browser Window	
	Selenium2Library.Input Text	name=userName	${RAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${RAusername}
	Selenium2Library.Input Text	name=password	${RApassword}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${RApassword}
	Click Element	id=btn-login

	Click Link	 Hello, Jayanth
	Wait Until Keyword Succeeds	1 min	3 sec	 Element Should Be Visible	xpath=//*[@href='ResCommission']
	Click Link	xpath=//*[@href='ResCommission']
	Sleep	10
	Click Element	${Logout}
	Close Browser	




Verificatoin RaiseInvoice_RA

	Check If Exists In Database	select qrtransactionid from egiftcard.inputvalidation where inputvalidation_id='7'
	@{queryResults}	Query	select qrtransactionid from egiftcard.inputvalidation where inputvalidation_id='7'
	Log	@{queryResults}
	${query}	Convert To String	@{queryResults}	
	${Raiseinvoice verification}	Remove String	${query}	(	'	'	,	)
	Log	${Raiseinvoice verification}	                             
	Set Global Variable	${Raiseinvoice verification}	
									


RaiseInvoice_RA

	Open Browser	${url}	${browser}
	Maximize Browser Window
	Selenium2Library.Input Text	name=userName	${RAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${RAusername}
	Selenium2Library.Input Text	name=password	${RApassword}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${RApassword}
	Click Element	id=btn-login

	Click Link	 Hello, Jayanth
	Wait Until Keyword Succeeds	1 min	3 sec	 Element Should Be Visible	xpath=//*[@href='InvoiceRaise']
	Click Link	xpath=//*[@href='InvoiceRaise']
	Click Element	xpath=//*[@value='${Raiseinvoice verification}']
	Click Button	xpath=//*[@type='submit']
	Click Button	xpath=//*[@type='submit']
	Click Button	OK
	Sleep	5	
	Click Element	${Logout}
	Close Browser	






ViewInvoice RA

	Open Browser	${url}	${browser}
	Maximize Browser Window
	Selenium2Library.Input Text	name=userName	${RAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${RAusername}
	Selenium2Library.Input Text	name=password	${RApassword}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${RApassword}
	Click Element	id=btn-login

	Click Link	 Hello, Jayanth
	Wait Until Keyword Succeeds	1 min	3 sec	 Element Should Be Visible	xpath=//*[@href='ViewResInvoice']
	Click Link	xpath=//*[@href='ViewResInvoice']





*** Test Cases ***

#TC001
	Log TO console	Login validation Positive Test case Start
	Login validation
	Log TO console	Add Login validation Test case End

#TC002	
	Log TO console	Commission Report Positive Test case Start
	Commission Report
	Log TO console	Commission Report Test case End	

#TC003
	Log TO console	RaiseInvoice RA Positive Test case Start
	Verificatoin RaiseInvoice_RA
	RaiseInvoice_RA
	Log TO console	RaiseInvoice RA Test case End 

 TC004
	Log TO console	ViewInvoice RA Positive Test case Start
	ViewInvoice RA
	Log TO console	ViewInvoice RAs Test case End


