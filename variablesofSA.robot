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
${price}	25
















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