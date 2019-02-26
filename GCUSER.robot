*** Settings ***

Suite Setup      Connect To Database	psycopg2	${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect From Database	

Library	Selenium2Library
Library	DateTime
Library	DatabaseLibrary
Library	OperatingSystem
Library	String
Library	SikuliLibrary

*** Variables ***

${DBHost}	52.3.229.153 
${DBName}	serviceportal 
${DBPass}	passw0rd
${DBPort}	10899
${DBUser}	postgres
${url}	https://egiftcard-dev.herokuapp.com/login
${charegscreenURL}	https://egiftcard-dev.herokuapp.com/ViewReport?key='${utilize crad}'
${browser}	gc
${username}	mohan	
${password}	vadi7932
${Logout}	xpath=//*[@href='logout']
${utilizeItem}	Dosa
${utilizeAmount}	5
${KfcPasscode}	va08256

*** Keywords ***

Login validation
	
	Open Browser	${url}	${browser}
	Maximize Browser Window
	Selenium2Library.Input Text	name=userName	${username}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${username}
	Selenium2Library.Input Text	name=password	${password}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${password}
	Click Element	id=btn-login
	Sleep	10
	Click Element	${Logout}
	Close Browser

verification buycard
	
	Check If Exists In Database	select product_id from egiftcard.product where price='125'
	@{queryResults}	Query	select product_id from egiftcard.product where price='125'
	Log Many	@{queryResults}
	${query}	Convert To String	@{queryResults}
	${buycard25}	Remove String	${query}	(	L	,	)	
	Log Many	${buycard25}			
	Set Global Variable	${buycard25}

	
	Check If Exists In Database	select product_id from egiftcard.product where price='50'
	@{queryResults1}	Query	select product_id from egiftcard.product where price='50'
	Log Many	@{queryResults1}
	${query1}	Convert To String	@{queryResults1}
	${buycard50}	Remove String	${query1}	(	L	,	)			
	Set Global Variable	${buycard50}
	
	Check If Exists In Database	select product_id from egiftcard.product where price='75'
	@{queryResults2}	Query	select product_id from egiftcard.product where price='75'
	Log Many	@{queryResults2}
	${query2}	Convert To String	@{queryResults2}
	${buycard75}	Remove String	${query2}	(	L	,	)	
	Set Global Variable	${buycard75}


Buycard

	Open Browser	${url}	${browser}
	Maximize Browser Window

	Selenium2Library.Input Text	name=userName	${username}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${username}

	Selenium2Library.Input Text	name=password	${password}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${password}
    Click Element	id=btn-login

    Click Link	xpath=//*[@href='gifthome?restaurantid=KFC207815&restauname=KFC&city=bangalore&area=Hormavu']
	Click Link	xpath=//*[@href='/reviewpage1?productId=${buycard25}&giftcardprice=25&restaurantid=KFC207815']
	Click Link	xpath=//*[@href='/addBuyCard?productId=25&giftcardprice=25']

	Add Image Path	E://payment
	Sleep	10
	Click	cardnum.png
	SikuliLibrary.Input Text	cardnum.png	4532759734545858
	Sleep	5
	Click	cvvnum.png
	Sleep	5
	SikuliLibrary.Input Text	cvvnum.png	123
	Sleep	5
	Click	expdate.png
	Sleep	5
	SikuliLibrary.Input Text	expdate.png	07/22
	Sleep	5
	Click	posatlcode.png
	SikuliLibrary.Input Text	posatlcode.png	94106
	Sleep	5
	Click	pay.png	
	Sleep	5
	Close Browser 

verification Utilization of card

	Check If Exists In Database  select qrcode from egiftcard.inputvalidation where inputvalidation_id='2';
    @{queryResults}	Query   select qrcode from egiftcard.inputvalidation where inputvalidation_id='2';
    Log Many    @{queryResults}
    ${query}	Convert To String	@{queryResults}
	${utilizecrad}	Remove String	${query}	(   '   '   ,   )
	Log Many	${utilizecrad}			
	Set Global Variable	${utilizecrad} 

Utilization of card

	Open Browser		https://egiftcard-dev.herokuapp.com/ViewReport?key=${utilizecrad}	${browser}	
	Maximize Browser Window
	Selenium2Library.Input Text	name=itempurchase	${utilizeItem}
	Selenium2Library.Input Text	name=moneytocharge	${utilizeAmount}
	Selenium2Library.Input Text	name=Passcode	${KfcPasscode}
	Click Button	Pay
	Sleep	5
	Close Browser 

verification Purchase_Details

	Check If Exists In Database  select transactionid from egiftcard.purchasedata where id='1'
	@{queryResults}	Query   select transactionid from egiftcard.purchasedata where id='1'
    Log Many    @{queryResults}
	${query}	Convert To String	@{queryResults}	
	${purchase_details}	Remove String	${query}	(	'	'	,	)
	Log Many	${purchase_details}
	Set Global Variable	${purchase_details}

Purchase_Details

	Open Browser	${url}	${browser}
	Maximize Browser Window
	Selenium2Library.Input Text	name=userName	${username}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${username}
	Selenium2Library.Input Text	name=password	${password}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${password}
	Click Element	id=btn-login
	Click Link	xpath=//*[@href='Purchasedetails']
	Click Link	xpath=//*[@href='TransactionDetails?type=${purchase_details}&&userlogin=userlogin']
	Sleep	5
	Close Browser


	
	

	

*** Test Cases ***


TC001
	Log TO console	Login validation Positive Test case Start
	Login validation
	Log TO console	Add Login validation Test case End


TC002
	Log TO console	Buycard Positive Test case Start
    verification buycard
	Buycard
	Log TO console	Buycard Positive Test case Start
TC003
    Log TO console	Utilization of card Test case Start
    verification Utilization of card
	Utilization of card
	Log TO console	Utilization of card Test case Start

TC004
	Log TO console	Purchase Details Test case Start
    verification Purchase_Details
	Purchase_Details
	Log TO console	Purchase Details Test case Start

