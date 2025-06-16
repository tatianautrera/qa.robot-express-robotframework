*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Library        FakerLibrary

Resource        ../resources/base.resource

Suite Setup       Log    Tudo aqui ocorre antes da suite
Suite Teardown    Log    Tudo aqui rodar após a suite

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Variables ***
${name}        Tatiana
${email}       tatiana@teste.co,
${password}    pwd123

*** Test Cases ***

Deve poder cadastrar um novo usuários

    #${name}         FakerLibrary.Name
   # ${email}        FakerLibrary.Free Email
    ${user}          Create Dictionary
    ...    name=Fernando papito    
    ...    email=tati@teste.com    
    ...    password=pwd123

    Remove user from database       ${user}[email]

    Go to signup Page
    Submit signup form    ${user}
    Notice Should be      Boas vindas

Não deve permitir o cadastro com email duplicado

    ${user}          Create Dictionary
    ...    name=Fernando papito    
    ...    email=tati2@teste.com    
    ...    password=pwd123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go to signup Page
    Submit signup form    ${user}
    Notice Should be      Opps! Já existe um usaurio com o email 

Não deve permitir o cadastro sem informar os campos obrigatórios

    ${user}          Create Dictionary
    ...    name=${EMPTY}    
    ...    email=${EMPTY}     
    ...    password=${EMPTY} 

    Go to signup Page
    Submit signup form    ${user}
    Alert Should be    Informe o seu nome completo
    Alert Should be    Informe o seu email
    Alert Should be    Informe uma senha de 6 digitos

Não deve permitir o cadastro ao informar um email invalido

    ${user}          Create Dictionary
    ...    name=Tatiana    
    ...    email=tata.cmo.br     
    ...    password=123456

    Go to signup Page
    Submit signup form    ${user}
    Alert Should be    Digite um email valido

Não deve permitir cadastrar com senha inferior a 6 digitos    
    @{password_list}    Create List    1    12    123    1234    1235

    FOR    ${password}    IN    @{password_list}
        ${user}          Create Dictionary
    ...    name=Tatiana    
    ...    email=tata.cmo.br     
    ...    password=${password}
    
        Go to signup Page
        Submit signup form    ${user}
        Alert Should be    Digite uma senha com no mínimo 6 digitos
        
    END

Não deve permitir o cadastro sao informar uma senha com 1 digito
    [Template]
    Short password    1

Não deve permitir o cadastro sao informar uma senha com 2 digitos
    [Template]
    Short password    12

*** Keywords ***
Short password
    [Arguments]        ${short_pass}

    ${user}          Create Dictionary
    ...    name=Tatiana    
    ...    email=tata.cmo.br     
    ...    password=${short_pass}
    
    Go to signup Page
    Submit signup form    ${user}
    Alert Should be    Digite uma senha com no mínimo 6 digitos
    