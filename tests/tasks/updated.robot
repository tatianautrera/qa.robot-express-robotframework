*** Settings ***
Documentation        Cenários de atualização de tarefas
Resource             ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder marcar uma tarefa como concluida
    ${data}        Get fixture    tasks    done

    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user]

    Post user session  ${data}[user]
    Post a new task    ${data}[task]

    Submit login form            ${data}[user]
    User should be logged in     ${data}[user][name]
    Mask task as completed       ${data}[task][name]
    Task should be completed     ${data}[task][name]

