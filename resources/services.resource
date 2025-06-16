*** Settings ***
Documentation            COnsumindo a api rest do sistema

Library                  RequestsLibrary

*** Keywords ***
Post a new task
    [Arguments]    ${user}

    ${payload}     Create Dictionary
    ...    email=${user}[email]
    ...    password=${user}[password]

    ${resp}    POST    url=http://localhost:3333/session    json=${payload}    expected_status=200

    ${token}    Set Variable    ${resp.json()}[token]

    Set Test Variable    ${token}

Post user session
    [Arguments]    ${payload}

    ${headers}      Create Dictionary    Authorization=${token}
    POST    url=http://localhost:3333/tasks    json=${payload}    headers=${headers}    expected_status=201

