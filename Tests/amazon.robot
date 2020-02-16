*** Settings ***
Documentation       This will contain some information about the whole test suit
Library             SeleniumLibrary
Test Setup          Begin Web Test
Test Teardown       End Web Test

*** Variables ***
${BROWSER}          chrome
${URL}              http://www.amazon.com

*** Keywords ***
Begin Web Test
    Open Browser                about:blank     ${BROWSER}
    Maximize Browser Window

Go to Web Page
    Load Page
    Verify Page Loaded

Load Page
    Go To                       ${URL}

Verify Page Loaded
    ${link_text}                Get Text         id:nav-your-amazon
    Should Be Equal             ${link_text}     Your Amazon.com

Search for Product
    [Arguments]                 ${search_term}      ${search_result}
    Enter Search Term           ${search_term}
    Submit Search
    Verify Search Completed     ${search_term}      ${search_result}

Enter Search Term
    [Arguments]                 ${search_term}
    Input Text                  id:twotabsearchtextbox    ${search_term}

Submit Search
    Click Button                xpath://*[@id="nav-search"]/form/div[2]/div/input

Verify Search Completed
    [Arguments]                 ${search_term}      ${search_result}
    ${result_text}              Set Variable        results for "${search_term}"
    Should Be Equal             ${result_text}      ${search_result}

End Web Test
    Close Browser

*** Test Cases ***
User can access amazon.com
    [Documentation]             This is some basic info about the test
    [Tags]                      Test 1
    Go to Web Page

User can conduct a search
    [Documentation]             This is come basic info about the test
    [Tags]                      Test 2
    Go to Web Page
    Search for Product          ferrari 458         results for "ferrari 458"

User can conduct another search
    [Documentation]             This is some basic info about the test
    [Tags]                      Test 3
    Go to Web Page
    Search for Product          tesla model x         results for "tesla model x"
