*** Settings ***
Documentation            Ações e elementos da pagina de login

Library        Browser
Library    OperatingSystem

*** Keywords ***
Submit login form
    [Arguments]        ${user}

    Fill Text    css=input[placeholder="E-mail"]    ${user}[email]
    Fill Text    css=input[placeholder="Senha"]     ${user}[password]
    
    Click        css=button >> txt=Entrar