*** Settings ***

Suite Setup      Connect To Database	psycopg2	${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}	Start Sikuli Process	 
Suite Teardown    Disconnect From Database	
	

Library	Selenium2Library
Library	DateTime
Library	DatabaseLibrary
Library	OperatingSystem
Library	String
Library	SikuliLibrary

Resource  ${EXECDIR}${/}database.robot

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
Verification

    @{queryResults}=     Get List Of Products  100
    :FOR    ${item}    IN    @{queryResults}
       \    ${itemString}=    Convert To String    ${item}
       \     ${buycard25}=    Remove String    ${itemString}    (    L    ,    )
       \     Run Keyword If    '${buycard25}'=='1'    Click Link	xpath=//*[@href='/reviewpage1?productId=${buycard25}&giftcardprice=75&restaurantid=KFC207815']
       \    ...  ELSE   Log To Console    Not A valid value 
	
	



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
	Verification
	#Click Link	xpath=//*[@href='/reviewpage1?productId=${buycard25}&giftcardprice=25&restaurantid=KFC207815']
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
	Buycard