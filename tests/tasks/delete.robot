*** Settings ***
Documentation        Cenários de deleção de tarefas
Resource             ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder apagar uma tarefa indesejada
    ${data}        Get fixture    tasks    delete

    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user]

    Post user session  ${data}[user]
    Post a new task    ${data}[task]

    Submit login form            ${data}[user]
    User should be logged in     ${data}[user][name]
    Request removal              ${data}[task][name]
    Task should not exist        ${data}[task][name]



