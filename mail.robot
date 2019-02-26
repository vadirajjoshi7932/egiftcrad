*** Settings ***

Suite Setup      Connect To Database	psycopg2	${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}	Start Sikuli Process	 
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
${browser}	gc
${SAusername}	mohan	
${SApassword}	vadi7932
${Logout}	xpath=//*[@href='logout']
${SAusername}	mohan	
${SApassword}	vadi7932
${Logout}	xpath=//*[@href='logout']


*** Keywords ***

verification buycard
	
	Check If Exists In Database	select product_id from egiftcard.product where price='25'
	@{queryResults}	Query	select product_id from egiftcard.product where price='25'
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

	Selenium2Library.Input Text	name=userName	${SAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${SAusername}

	Selenium2Library.Input Text	name=password	${SApassword}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${SApassword}

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
	
	
		
	

*** Test Cases ***

TC001
	verification buycard
	Buycard