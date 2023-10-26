*** Settings ***
Library    SeleniumLibrary
    
*** Variables ***
${BROWSER}                     chrome
${URL}                         https://www.amazon.com.br/
${MENU_ELETRONICOS}            //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}          //h1[contains(.,'Eletrônicos e Tecnologia')]
${TEXTO_HEADER_ELETRONICOS}    Eletrônicos e Tecnologia
${EXCLUIR}                     //input[contains(@value,'Excluir')]
${EXCLUIDO_DO_CARRINHO}        //h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]

    
*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}    url=https://www.google.com/ 
    Maximize Browser Window
    
    
Fechar o navegador
    Capture Page Screenshot     #no final tira a foto do resultado do teste (evidência)
    Close Browser

Acessar a home page do site amazon.com.br 
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS} 

Entrar no menu "Eletrônicos"
    Click Element                    locator=${MENU_ELETRONICOS}
       

Verificar se aparece a frase "${frase}"
    Wait Until Page Contains       text=${frase}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS} 

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//img[contains(@alt,'${NOME_CATEGORIA}')]


Clicar no botão de pesquisa
    Click Element    twotabsearchtextbox

Digitar o nome de produto "${NOME_PRODUTO}" no campo de Pesquisa
    Input Text    locator=twotabsearchtextbox    text=${NOME_PRODUTO}

Clicar no botão de pesquisar
    Click Element    locator=nav-search-submit-text
    
Verificar o resultado da pesquisa se está listando o produto "${NOME_PRODUTO}"
    Wait Until Element Is Visible     locator=(//span[contains(.,'${NOME_PRODUTO}')])[2]
    Element Should Be Visible        locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${NOME_PRODUTO}')]
    

Adicionar o produto "${NOME_PRODUTO}" no carrinho
    Click Element    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${NOME_PRODUTO}')]
    Click Element    locator=add-to-cart-button

Verificar se o produto "${NOME_PRODUTO}" foi adicionado com sucesso
    Element Should Be Visible    locator=//span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]

Remover o produto "Console Xbox Series S" do carrinho
    Click Element     locator=//a[contains(@data-csa-c-type,'button')]
    Click Button     locator=${EXCLUIR}

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=${EXCLUIDO_DO_CARRINHO}
    

# Gherkin steps BDD Caso de teste 01

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z." 
Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"
Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"
E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"
E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"



# Gherkin steps BDD Caso de teste 02

Quando pesquisar pelo produto "Xbox Series S"
    Clicar no botão de pesquisa
    Digitar o nome de produto "Xbox Series S" no campo de Pesquisa
    Clicar no botão de pesquisar
Então o título da página deve ficar 'Amazon.com.br : Xbox Series S'
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"
E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"


# Gherkin steps BDD Caso de teste 03
Quando adicionar o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Clicar no botão de pesquisar
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso


# Gherkin steps BDD Caso de teste 04

E existe o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Clicar no botão de pesquisar
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
Quando remover o produto "Console Xbox Series S" no carrinho
    Remover o produto "Console Xbox Series S" do carrinho
Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio