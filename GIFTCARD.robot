*** Settings ***

Suite Setup      Connect To Database	psycopg2	${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect From Database	

Library	Selenium2Library
Library	DateTime
Library	DatabaseLibrary
Library	OperatingSystem
Library	String
Library	SikuliLibrary
Library   BuiltIn

*** Variables ***

${DBHost}	52.3.229.153
${DBName}	serviceportal
${DBPass}	passw0rd
${DBPort}	10899
${DBUser}	postgres
${url}	https://egiftcard-dev.herokuapp.com/login
${browser}	gc
${SAusername}	vadi
${SApassword}	vadi7932
${productname}	Gift Card 100
${productprice}	100
${subcategory}	EGiftcard
${description}	Its Electronic Gift Cards
${username}	mohan	
${password}	vadi7932
${Logout}	xpath=//*[@href='logout']
${utilizeItem}	Dosa
${utilizeAmount}	5
${KfcPasscode}	va08256
${Logout}	xpath=//*[@href='logout']
${buycard_price}    75
${RAusername}	Jayanth
${RApassword}	vadi7932
${Invoice_date}  02/26/2019

*** Keywords ***

Login validation	

	Open Browser	${url}	${browser}
	Maximize Browser Window
	Selenium2Library.Input Text	name=userName	${SAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${SAusername}
	Selenium2Library.Input Text	name=password	${SApassword}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${SApassword}
	Click Element	id=btn-login
	Sleep	10
	Click Element	${Logout}
	Close Browser	

Registered Restaurants

	Open Browser	${url}	${browser}
	Maximize Browser Window
	Selenium2Library.Input Text	name=userName	${SAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${SAusername}
	Selenium2Library.Input Text	name=password	${SApassword}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${SApassword}
	Click Element	id=btn-login
	Click Link	 Hello, vadi
	Click Link	xpath=//*[@href='RestaurantDetails']
	Sleep	10
	Close Browser   	
    
Add Product

	Open Browser	${url}	${browser}
	Maximize Browser Window	
	Selenium2Library.Input Text	name=userName	${SAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${SAusername}
	Selenium2Library.Input Text	name=password	${SApassword}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${SApassword}
	Click Element	id=btn-login

	Click Link	 Hello, vadi 
	Wait Until Keyword Succeeds	1 min	3 sec	 Element Should Be Visible	xpath=//*[@href='manageProduct?type=NA']
	Click Link	xpath=//*[@href='manageProduct?type=NA']

	Click Element	id=categoryName

	Select From List By Value	id=subCategoryName	${subcategory}		
	${Boxtext}=	Get Value	id=subCategoryName
	Should Be Equal	${Boxtext}	${subcategory}

	Selenium2Library.Input Text	name=name	${productname}	
	${Boxtext}	Get Value	name=name
	Should Be Equal	${Boxtext}	${productname}

	Selenium2Library.Input Text	name=price	${productprice}	
	${Boxtext}	Get Value	name=price
	Should Be Equal	${Boxtext}	${productprice}	
	
	
	Selenium2Library.Input Text	xpath=//*[@id="command"]/div/div/div/div/div/div/div[2]/div/div/div/div[5]/input	${description}	
	${Boxtext}	Get Value	xpath=//*[@id="command"]/div/div/div/div/div/div/div[2]/div/div/div/div[5]/input
	Should Be Equal	${Boxtext}	${description}	

	Choose File	name=files	E:\\Vadiraj joshi\\Sikuliimages\\giftcard.jpg



	Click Button	Submit
	Click Button	OK
	Sleep	10
	Click Element	${Logout}
	Close Browser

Database verification Add product
		Check If Exists In Database	select * from egiftcard.product where name='Gift Card 100';+
		



verification buycard
	
	Check If Exists In Database	select product_id from egiftcard.product where price='${buycard_price}'
	@{queryResults}	Query	select product_id from egiftcard.product where price='${buycard_price}'
	Log Many	@{queryResults}
	${query}    Convert To String   @{queryResults}
	${buycard25}	Remove String	${query}	(	L	,	)	
	Log Many	${buycard25}			
	Set Global Variable	${buycard25}

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
	Click Link	xpath=//*[@href='']

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


Login Validation_RA  

	Open Browser	${url}	${browser}
	Maximize Browser Window
	Selenium2Library.Input Text	name=userName	${RAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${RAusername}
	Selenium2Library.Input Text	name=password	${RApassword}
	${Boxtext}=	Get Value	name=password
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

	Check If Exists In Database	select qrtransactionid from egiftcard.inputvalidation where inputvalidation_id='3'
	@{queryResults}	Query	select qrtransactionid from egiftcard.inputvalidation where inputvalidation_id='3'
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

verification ViewInvoice_SA

	Check If Exists In Database	select autogenerate from egiftcard.invoicegeneration where invoicenumber='Invoice0001'
	@{queryResults}	Query	select autogenerate from egiftcard.invoicegeneration where invoicenumber='Invoice0001'
	Log Many	@{queryResults}	
	${query}	Convert To String	@{queryResults}	
	${verificationviewinvoice_SA}	Remove String	${query}	(	,	)	
	Log	${verificationviewinvoice_SA}
	Set Global Variable	${verificationviewinvoice_SA}	

	
ViewInvoice SA
	
	Open Browser	${url}	${browser}
	Maximize Browser Window	
	Selenium2Library.Input Text	name=userName	${SAusername}
	${Boxtext}=	Get Value	name=userName
	Should Be Equal	${Boxtext}	${SAusername}
	Selenium2Library.Input Text	name=password	${SApassword}
	${Boxtext}=	Get Value	name=password
	Should Be Equal	${Boxtext}	${SApassword}
	Click Element	id=btn-login	

	Click Link	 Hello, vadi
	Wait Until Keyword Succeeds	1 min	3 sec	 Element Should Be Visible	xpath=//*[@href='ViewInvoice']
	Click Link	xpath=//*[@href='ViewInvoice']	
	Click Link	xpath=//*[@href='#basic${verificationviewinvoice_SA}']
	Wait Until Element Is Visible	xpath=//*[@name='status']
	Sleep	5
	Select From List By Value	xpath=//*[@name='status']	Payment Processed
	Press Key	id=paystatus_date	${Invoice_date}
	Click Button	Update
	Click Button	OK
	Sleep	3
	Close Browser  

verification ViewInvoice_RA

	Check If Exists In Database	select autogenerate from egiftcard.invoicegeneration where invoicenumber='Invoice0001'
	@{queryResults}	Query	select autogenerate from egiftcard.invoicegeneration where invoicenumber='Invoice0001'
	Log Many	@{queryResults}	
	${query}	Convert To String	@{queryResults}	
	${verificationviewinvoice_RA}	Remove String	${query}	(	,	)	
	Log	${verificationviewinvoice_RA}
	Set Global Variable	${verificationviewinvoice_RA}

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
    Click Link  xpath=//*[@href='#basic${verificationviewinvoice_RA}']
    Wait Until Element Is Visible	xpath=//*[@name='status']
	Sleep	5
	Select From List By Value	xpath=//*[@name='status']	Payment Received
	Press Key	id=paystatus_date	${Invoice_date}
	Click Button	Update
	Click Button	OK
	Sleep	3
	Close Browser 

*** Test Cases ***    

#TC001
    Log TO console	Login validation Positive Test case Start
	Login validation
	Log TO console	Login validation Positive Test case End

#TC002
    Log TO console	Registered Restaurants Positive Test case Start
	Registered Restaurants
	Log TO console	Registered Restaurants Positive Test case End

#TC003
    Log TO console	Add Product Positive Test case Start
	Add Product
	Database verification Add product
	Log TO console	Add Product Positive Test case End



#TC005
    Log TO console	Utilization of card Test case Start
    verification Utilization of card
	Utilization of card
	Log TO console	Utilization of card Test case Start

#TC006
	Log TO console	Purchase Details Test case Start
    verification Purchase_Details
	Purchase_Details
	Log TO console	Purchase Details Test case Start 

#TC007
	Log TO console	Login validation Positive Test case Start
	Login Validation_RA
	Log TO console	Add Login validation Test case End

#TC008	
	Log TO console	Commission Report Positive Test case Start
	Commission Report
	Log TO console	Commission Report Test case End	

#TC009
	Log TO console	RaiseInvoice RA Positive Test case Start
	Verificatoin RaiseInvoice_RA
	RaiseInvoice_RA
	Log TO console	RaiseInvoice RA Test case End 

#TC010
	Log TO console	ViewInvoice SA Positive Test case Start
	verification ViewInvoice_SA
	ViewInvoice SA
	Log TO console	ViewInvoice SA Positive Test case End


#TC011
	Log TO console	ViewInvoice RA Positive Test case Start
    verification ViewInvoice_RA
	ViewInvoice RA
	Log TO console	ViewInvoice RAs Test case End

TC004
	Log TO console	Buycard Positive Test case Start
    verification buycard
	Buycard
	Log TO console	Buycard Positive Test case Start	