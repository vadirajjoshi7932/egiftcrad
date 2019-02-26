*** Settings ***

Suite Setup      Connect To Database	psycopg2	${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect From Database	

Library  Selenium2Library
Library  DateTime
Library  DatabaseLibrary
Library  OperatingSystem
Library  String

Resource  variablesofSA.robot


*** Variables ***



*** Keywords ***

Get List Of Products   
    [Arguments]    ${price}
    Check If Exists In Database    select product_id from egiftcard.product where price='${price}' 
    @{queryResults}    Query    select product_id from egiftcard.product    where price='${price}' 
    [Return]    @{queryResults}
    
		


Verify 25 Rupees Gift Products
	
    @{queryResults}=     Get List Of Products  100
    :FOR    ${item}    IN    @{queryResults}
       \    ${itemString}=    Convert To String    ${item}
       \     ${buycard25}=    Remove String    ${itemString}    (    L    ,    )
       \     Run Keyword If    '${buycard25}'=='18'   Log To Console    Click This Element
       \    ...  ELSE   Log To Console    Not A valid value    

#Verify 50 Rupees Gift Products
    @{queryResults}=     Get List Of Products   50 
    :FOR    ${item}    IN    @{queryResults}
        \    ${itemString}=    Convert To String    ${item}
        \     ${buycard100}=    Remove String    ${itemString}    (    L    ,    )
        \     Log    This is my item I'm searching ${buycard100}


#Verify 75 Rupees Gift Products
    @{queryResults}=     Get List Of Products   75   
    :FOR    ${item}    IN    @{queryResults}
        \    ${itemString}=    Convert To String    ${item}
        \     ${buycard100}=    Remove String    ${itemString}    (    L    ,    )
        \     Log    This is my item I'm searching ${buycard100}        
    
#Verify 100 Rupees Gift Products
    @{queryResults}=     Get List Of Products   100  
    :FOR    ${item}    IN    @{queryResults}
        \    ${itemString}=    Convert To String    ${item}
        \     ${buycard100}=    Remove String    ${itemString}    (    L    ,    )
        \     Log    This is my item I'm searching ${buycard100}        

TC001
    database