*** Settings ***

Suite Setup      Connect To Database	psycopg2	${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect From Database	

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
${url}	https://egiftcard-dev.herokuapp.com/home
${browser}	gc
${Logout}	xpath=//*[@href='logout']
${Guestusername}	vadiraj009@gmail.com
${guestbuycard_price}    10
${guest_utilizeAmount}  2

*** Keywords ***

Guest Login validation
	
	Open Browser	${url}	${browser}
	Maximize Browser Window
	Click Link	xpath=//*[@href='login']
	Click Link	xpath=//*[@href='guestloginpage']
	Selenium2Library.Input Text	xpath=//*[@name='emailAddress']	${Guestusername}
	Click Button	id=btn-signup
	Sleep	5
	Click Element	${Logout}
	Close Browser	

verification Guestlogin_Buycard

    Check If Exists In Database	select product_id from egiftcard.product where price='${guestbuycard_price}'
	@{queryResults}	Query	select product_id from egiftcard.product where price='${guestbuycard_price}'
	Log Many	@{queryResults}
	${query}	Convert To String	@{queryResults}
	${guestbuycard}	Remove String	${query}	(	L	,	)	
	Log Many	${guestbuycard}			
	Set Global Variable	${guestbuycard}
	
Guestlogin_Buycard
	
	Open Browser	${url}	${browser}
	Maximize Browser Window
	Click Link	xpath=//*[@href='login']
	Click Link	xpath=//*[@href='guestloginpage']
	Selenium2Library.Input Text	xpath=//*[@name='emailAddress']	${Guestusername}
	Click Button	id=btn-signup
	Click Link	xpath=//*[@href='gifthome?restaurantid=KFC207815&restauname=KFC&city=bangalore&area=Hormavu']
	Click Link	xpath=//*[@href='/reviewpage1?productId=${guestbuycard}&giftcardprice=${guestbuycard_price}&restaurantid=KFC207815']
	Click Link	xpath=//*[@href='/addBuyCard?productId=${guestbuycard}&giftcardprice=10']
	
*** Test cases ***

#TC001
	Log TO console	Guest Login validation Positive Test case Start
	Guest Login validation
	Log TO console	Guest Login validation Test case End

TC002
	Log TO console	Guest Buy Card Positive Test case Start
    verification Guestlogin_Buycard
	Guestlogin_Buycard
	Log TO console	Guest Buy Card Positive Test case End