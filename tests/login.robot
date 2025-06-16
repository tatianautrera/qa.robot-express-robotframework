*** Settings ***
Documentation        Cenários de autenticação do usuários

Library             Collections
Resource            ../resources/base.resource

Test Setup          Start Session
Test Teardown       Take Screenshot

*** Test Cases ***
Deve poder logar com um usuario pré-cadastrado
    ${user}    Create Dictionary    name=Tatiana    email=teste@teste.com    password=123456

    Remove user from database    ${user}[email]        
    Insert user from database    ${user}
    
    Submit login form            ${user}
    User should be logged in     ${user}[name]

Não deve permitir logar com senha incorreta
    ${user}    Create Dictionary    name=Tatiana    email=teste@teste.com    password=123456

    Remove user from database    ${user}[email]        
    Insert user from database    ${user}

    Set To Dictionary            ${user}        password=acb123
    
    Submit login form            ${user}
    Notice should be            Ocorreu um erro ao fazer login, verifique suas credenciais

