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
${browser}	gc
${SAusername}	vadi
${SApassword}	vadi7932
${Logout}	xpath=//*[@href='logout']
${productname}	Gift Card 100
${productprice}	100
${subcategory}	EGiftcard
${description}	Its Electronic Gift Cards
${Mandatoryproductname}	Mandatory
${Mandatoryprice}	1000


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
		Check If Exists In Database	select * from egiftcard.product where name='Gift Card 100';


Addproduct without subcategory 


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

	Selenium2Library.Input Text	name=name	${Mandatoryproductname}	
	${Boxtext}	Get Value	name=name
	Should Be Equal	${Boxtext}	${Mandatoryproductname}

	Selenium2Library.Input Text	name=price	${productprice}	
	${Boxtext}	Get Value	name=price
	Should Be Equal	${Boxtext}	${productprice}	
	
	
	Selenium2Library.Input Text	xpath=//*[@id="command"]/div/div/div/div/div/div/div[2]/div/div/div/div[5]/input	${description}	
	${Boxtext}	Get Value	xpath=//*[@id="command"]/div/div/div/div/div/div/div[2]/div/div/div/div[5]/input
	Should Be Equal	${Boxtext}	${description}	

	Choose File	name=files	E:\\Vadiraj joshi\\Sikuliimages\\giftcard.jpg


	Click Button	Submit
	#Click Button	OK
	Sleep	3
	Click Element	${Logout}
	Close Browser

Database verification Addproduct without subcategory 
		Check If Exists In Database	select * from egiftcard.product where name='${Mandatoryproductname}';


Addproduct without productname

	
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


	Selenium2Library.Input Text	name=price	${Mandatoryprice}	
	${Boxtext}	Get Value	name=price
	Should Be Equal	${Boxtext}	${Mandatoryprice}
	
	
	Selenium2Library.Input Text	xpath=//*[@id="command"]/div/div/div/div/div/div/div[2]/div/div/div/div[5]/input	${description}	
	${Boxtext}	Get Value	xpath=//*[@id="command"]/div/div/div/div/div/div/div[2]/div/div/div/div[5]/input
	Should Be Equal	${Boxtext}	${description}	

	Choose File	name=files	E:\\Vadiraj joshi\\Sikuliimages\\giftcard.jpg

	Click Button	Submit
	#Click Button	OK
	Sleep	3
	Click Element	${Logout}
	Close Browser

Database verification Addproduct without productname
		Check If Exists In Database	select * from egiftcard.product where price='${Mandatoryproductname}';


Addproduct without productprice


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

	Selenium2Library.Input Text	name=name	${Mandatoryproductname}
	${Boxtext}	Get Value	name=name
	Should Be Equal	${Boxtext}	${Mandatoryproductname}
	
	Selenium2Library.Input Text	xpath=//*[@id="command"]/div/div/div/div/div/div/div[2]/div/div/div/div[5]/input	${description}	
	${Boxtext}	Get Value	xpath=//*[@id="command"]/div/div/div/div/div/div/div[2]/div/div/div/div[5]/input
	Should Be Equal	${Boxtext}	${description}	

	Choose File	name=files	E:\\Vadiraj joshi\\Sikuliimages\\giftcard.jpg


	Click Button	Submit
	#Click Button	OK
	Sleep	3
	Click Element	${Logout}
	Close Browser

Database verification Addproduct without productprice
	Check If Exists In Database	select * from egiftcard.product where price='${Mandatoryproductname}';


Addproduct without description

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
		

	Choose File	name=files	E:\\Vadiraj joshi\\Sikuliimages\\giftcard.jpg


	Click Button	Submit
	#Click Button	OK
	Sleep	3
	Click Element	${Logout}
	Close Browser

Database verification Addproduct without description
	Check If Exists In Database	select * from egiftcard.product where price='${Mandatoryproductname}';



Addproduct without image

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

	Click Button	Submit
	#Click Button	OK
	Sleep	3
	Click Element	${Logout}
	Close Browser
	

Database verification Addproduct without image
	Check If Exists In Database	select * from egiftcard.product where price='${Mandatoryproductname}';

Verification Viewproducts

	Check If Exists In Database	select product_id from egiftcard.product where price='100'
	@{queryResults}	Query	select product_id from egiftcard.product where price='100'
	Log	@{queryResults}
	${query}	Convert To String	@{queryResults}	
	${Viewproducts}	Remove String	${query}	(	L	,	)		
	Log	${Viewproducts}				          	
	Set Global Variable	${Viewproducts}

Viewproducts

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
	Wait Until Keyword Succeeds	1 min	3 sec	 Element Should Be Visible	xpath=//*[@href='viewproducts']
	Click Link	xpath=//*[@href='viewproducts']
	Sleep	5
	Click Element	${Logout}
	Close Browser

Deleteproduct
	
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
	Wait Until Keyword Succeeds	1 min	3 sec	 Element Should Be Visible	xpath=//*[@href='viewproducts']
	Click Link	xpath=//*[@href='viewproducts']
	Wait Until Element Is Visible	xpath=//*[@href='/deleteProduct?productId=${Viewproducts}']
	Click Link	xpath=//*[@href='/deleteProduct?productId=${Viewproducts}']
	Sleep	10
	Click Element	${Logout}
	Close Browser

Databaseverification Deleteproduct

	Check if not exists in database	select product_id from egiftcard.product where price='75'

Commission Report

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
	Wait Until Keyword Succeeds	1 min	3 sec	 Element Should Be Visible	xpath=//*[@href='PayCommission']
	Click Link	xpath=//*[@href='PayCommission']
	Sleep	10
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
	Press Key	id=paystatus_date	02/25/2019
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

#TC004
	Log TO console	Add Product negative Test case Start
	Addproduct without subcategory 
    Database verification Addproduct without subcategory 
	Log TO console	Add Product negative Test case End

#TC005
	Log TO console	Add Product negative Test case Start 
    Addproduct without productname
    Database verification Addproduct without productname
	Log TO console	Add Product negative Test case End

#TC006
	Log TO console	Add Product negative Test case Start
    Addproduct without productprice
    Database verification Addproduct without productprice
	Log TO console	Add Product negative Test case End

#TC007
	Log TO console	Add Product negative Test case Start
    Addproduct without description
    Database verification Addproduct without description
	Log TO console	Add Product negative Test case End

	
#TC008
	Log TO console	Add Product negative Test case Start
    Addproduct without image
    Database verification Addproduct without image
	Log TO console	Add Product negative Test case End

#TC009
    Log TO console	Viewproducts Positive Test case Start
	Verification Viewproducts
    Viewproducts
    Deleteproduct
    Databaseverification Deleteproduct
	Log TO console	Viewproducts Positive Test case End

#TC010
	Log TO console	Commission Report Positive Test case Start
	Commission Report
	Log TO console	Commission Report Positive Test case End

TC011
	Log TO console	ViewInvoice SA Positive Test case Start
	verification ViewInvoice_SA
	ViewInvoice SA
	Log TO console	ViewInvoice SA Positive Test case End	





	