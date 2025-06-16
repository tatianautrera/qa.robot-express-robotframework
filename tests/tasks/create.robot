*** Settings ***
Documentation            Cenários de cadastro de tarefas

Resource                ../../resources/base.resource

Library    Collections

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastar uma nova tarefa
    ${data}        Get fixture    tasks    create

    Clean user from database     ${data}[user][email]
    Insert user from database    ${data}[user]

    Submit login form            ${data}[user]
    User should be logged in     ${data}[user][name]

    Go to task form
    Submit task form             ${data}[task] 
    Task should be registered    ${data}[task][name]       

Não deve cadastrar tarefa com nome duplicado
    ${data}    Get fixture    tasks    duplicate

    #Dado que eu tenho um novo usuário
    Clean user from database     ${data}[user][email]
    Insert user from database    ${data}[user]

    #E que esse usuário já vcadastou uma tarefa
    Post user session  ${data}[user]
    Post a new task    ${data}[task]

    #E estou logado na aplicação
    Submit login form            ${data}[user]
    User should be logged in     ${data}[user][name]

    #Quando tento cadastrar essa tarefa que já foi cadastrada
    Go to task form
    Submit task form             ${data}[task]

    #Então devo ver uma notificação de duplicidade 
    Notice should be             Opps tarefa duplicada

Não deve cadastrar uma nova tarefa quando atinge o limite de 3 tags
    ${data}    Get fixture    tasks    tags_limit

    Clean user from database     ${data}[user][email]
    Insert user from database    ${data}[user]


    Submit login form            ${data}[user]
    User should be logged in     ${data}[user][name]

    Go to task form
    Submit task form             ${data}[task]

    Notice should be             Opps limite de tags atingido

     