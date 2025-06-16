*** Settings ***
Documentation            Cenários de tentativas de cadastro com senha muito curta

Resource            ../resources/base.resource
Test Template        Short password

*** Test Cases ***
Não deve logar com senha de 1 digito     1
Não deve logar com senha de 2 digitos    12
Não deve logar com senha de 3 digitos    123



*** Keywords ***
Short password
    [Arguments]        ${short pass}
    ${user}          Create Dictionary
    ...    name=Tatiana    
    ...    email=tata.cmo.br     
    ...    password=${short_pass}
    
    Go to signup Page
    Submit signup form    ${user}
    Alert Should be    Digite uma senha com no mínimo 6 digitos