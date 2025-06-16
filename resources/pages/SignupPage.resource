*** Settings ***
Documentation            Elementos e ações da pagina de cadastro

Library         Browser
Resource        ../env.resource

*** Keywords ***
Go to signup Page
     Go To        ${BASE_URL}/signup

    #Checkpoint
    Wait For Elements State        css=h1         visible        5  
    Get Text                        xpath=//h1    equal        Faça seu cadastro 

Submit signup form
    [Arguments]      ${user}
    Fill Text        id=name          ${user}[name]
    Fill Text        id=email         ${user}[email] 
    Fill Text        css=#password    ${user}[password]

    Click        css=button[type=submit] >> text=Cadastrar   