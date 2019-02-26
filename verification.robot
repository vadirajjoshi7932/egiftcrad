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

Verify
    Check If Exists In Database	select product_id from egiftcard.product 
	@{queryResults}	Query	select product_id from egiftcard.product 
	Log Many	@{queryResults}
	

*** Test Cases ***

TC001
    Verify



