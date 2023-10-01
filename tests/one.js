const puppeteer = require('puppeteer'); // v20.7.4 or later

(async () => {
    const browser = await puppeteer.launch({headless: false});
    const page = await browser.newPage();
    const timeout = 20000;
    page.setDefaultTimeout(timeout);

    {
        const targetPage = page;
        await targetPage.setViewport({
            width: 1566,
            height: 1429
        })
    }
    {
        const targetPage = page;
        const promises = [];
        const startWaitingForEvents = () => {
            promises.push(targetPage.waitForNavigation());
        }
        startWaitingForEvents();
        await targetPage.goto('https://cbs.almansoori.biz/sap/bc/ui5_ui5/ui2/ushell/shells/abap/FioriLaunchpad.html?sap-client=800&sap-language=EN%23Shell-home#ZTRV_FORM_REQ-display');
        await Promise.all(promises);
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--RB3-4 > div'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--RB3-4\\"]/div)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 24.5113525390625,
                y: 10,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Employee No.[role=\\"textbox\\"])'),
            targetPage.locator('#__xmlview0--idEmpNo-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--idEmpNo-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 428.43182373046875,
                y: 9.909088134765625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Search[role=\\"searchbox\\"])'),
            targetPage.locator('#empfragment-searchField-I'),
            targetPage.locator('::-p-xpath(//*[@id=\\"empfragment-searchField-I\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 317.54544830322266,
                y: 9.545448303222656,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Search[role=\\"searchbox\\"])'),
            targetPage.locator('#empfragment-searchField-I'),
            targetPage.locator('::-p-xpath(//*[@id=\\"empfragment-searchField-I\\"])')
        ])
            .setTimeout(timeout)
            .fill('9711068');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.down('Enter');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.up('Enter');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(9711068)'),
            targetPage.locator('#__item51-__clone0_cell0'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item51-__clone0_cell0\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 325.2727279663086,
                y: 4.5454559326171875,
              },
            });
    }
    {
        const targetPage = page;
        await waitForElement({
            type: 'waitForElement',
            target: 'main',
            selectors: [
                'xpath///*[@id="empfragment-searchField-I"]'
            ],
            visible: false
        }, targetPage, timeout);
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--GO-BDI-content'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--GO-BDI-content\\"])'),
            targetPage.locator('::-p-text(Go)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 7.2386474609375,
                y: 11.545440673828125,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--RB32 circle.sapMRbBInn'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--RB32\\"]/div/svg/circle[2])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 0.34954833984375,
                y: 2.1563720703125,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--idFocal-vhi'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--idFocal-vhi\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 12.193115234375,
                y: 12.272705078125,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(9711068 AGHIL KUTTIKATTIL MOHAN)'),
            targetPage.locator('#__item51-__clone41'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item51-__clone41\\"])'),
            targetPage.locator(':scope >>> #__item51-__clone41')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 140.272705078125,
                y: 62.27272033691406,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Ref No. [role=\\"textbox\\"])'),
            targetPage.locator('#__xmlview0--idRefNo-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--idRefNo-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 43.852264404296875,
                y: 0.545440673828125,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Ref No. [role=\\"textbox\\"])'),
            targetPage.locator('#__xmlview0--idRefNo-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--idRefNo-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('mws/ar/ooo5');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Contact No. [role=\\"spinbutton\\"])'),
            targetPage.locator('#__xmlview0--idContact-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--idContact-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 55.5794677734375,
                y: 9.272705078125,
              },
            });
    }
    {
        const targetPage = page;
        await targetPage.keyboard.down('0');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.up('0');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__select1-__xmlview0--idTravelInfo-0-label'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__select1-__xmlview0--idTravelInfo-0-label\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 56.272705078125,
                y: 15.09088134765625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Rotation Leave)'),
            targetPage.locator('#__item14-__xmlview0--idTravelInfo-0'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item14-__xmlview0--idTravelInfo-0\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 57,
                y: 16.81817626953125,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--travellerfield7-__xmlview0--idTravelInfo-0-vhi'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--travellerfield7-__xmlview0--idTravelInfo-0-vhi\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 9.727294921875,
                y: 12.09088134765625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--travellerfield8-__xmlview0--idTravelInfo-0-vhi'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--travellerfield8-__xmlview0--idTravelInfo-0-vhi\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 20.727294921875,
                y: 14.09088134765625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#sap-ui-blocklayer-popup'),
            targetPage.locator('::-p-xpath(//*[@id=\\"sap-ui-blocklayer-popup\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 1209,
                y: 659,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Search[role=\\"searchbox\\"])'),
            targetPage.locator('#countryidfragment1-searchField-I'),
            targetPage.locator('::-p-xpath(//*[@id=\\"countryidfragment1-searchField-I\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 83.54541015625,
                y: 9.545448303222656,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Search[role=\\"searchbox\\"])'),
            targetPage.locator('#countryidfragment1-searchField-I'),
            targetPage.locator('::-p-xpath(//*[@id=\\"countryidfragment1-searchField-I\\"])')
        ])
            .setTimeout(timeout)
            .fill('wbs');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.down('Enter');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.up('Enter');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#countryidfragment-list-listUl div.sapMSLIDescription'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item53-__clone66-content\\"]/div/div[2])'),
            targetPage.locator(':scope >>> #countryidfragment-list-listUl div.sapMSLIDescription'),
            targetPage.locator('::-p-text(Work Breakdown)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 178.272705078125,
                y: 22.6363525390625,
              },
            });
    }
    {
        const targetPage = page;
        await waitForElement({
            type: 'waitForElement',
            selectors: [
                '#countryidfragment-list-listUl div.sapMSLIDescription'
            ],
            visible: false
        }, targetPage, timeout);
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Show Value Help[role=\\"gridcell\\"]) >>>> ::-p-aria([role=\\"button\\"])'),
            targetPage.locator('#__xmlview0--travellerfield9-__xmlview0--idTravelInfo-0-vhi'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--travellerfield9-__xmlview0--idTravelInfo-0-vhi\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 13.7271728515625,
                y: 12.09088134765625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Project Code[role=\\"textbox\\"])'),
            targetPage.locator('#__xmlview0--travellerfield8-__xmlview0--idTravelInfo-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--travellerfield8-__xmlview0--idTravelInfo-0-inner\\"])'),
            targetPage.locator(':scope >>> #__xmlview0--travellerfield8-__xmlview0--idTravelInfo-0-inner')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 64.272705078125,
                y: 15.09088134765625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Search[role=\\"searchbox\\"])'),
            targetPage.locator('#plantidfragment-searchField-I'),
            targetPage.locator('::-p-xpath(//*[@id=\\"plantidfragment-searchField-I\\"])')
        ])
            .setTimeout(timeout)
            .fill('2200');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.down('Enter');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.up('Enter');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(2200 AMPS_MWS - UAE)'),
            targetPage.locator('#__item55-__clone185'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item55-__clone185\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 116.272705078125,
                y: 63.27272033691406,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Designation[role=\\"textbox\\"])'),
            targetPage.locator('#__input5-__xmlview0--idTravelInfo-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__input5-__xmlview0--idTravelInfo-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 38.272705078125,
                y: 14.09088134765625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Designation[role=\\"textbox\\"])'),
            targetPage.locator('#__input5-__xmlview0--idTravelInfo-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__input5-__xmlview0--idTravelInfo-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('sdf');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Types of Travel[role=\\"combobox\\"])'),
            targetPage.locator('#__xmlview0--travelType-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--travelType-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 79.522705078125,
                y: 3.9090576171875,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Types of Travel Select Options)'),
            targetPage.locator('#__xmlview0--travelType-arrow'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--travelType-arrow\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 11.159088134765625,
                y: 8.9090576171875,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Return)'),
            targetPage.locator('#__item56'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item56\\"])'),
            targetPage.locator(':scope >>> #__item56')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 49,
                y: 4.6363525390625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Class Select Options)'),
            targetPage.locator('#__xmlview0--classType-arrow'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--classType-arrow\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 16.8863525390625,
                y: 15.9090576171875,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__item59-content > div > div'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item59-content\\"]/div/div)'),
            targetPage.locator('::-p-text(Economy)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 17,
                y: 4,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--btnAddIti-img'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--btnAddIti-img\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 3.4544677734375,
                y: 18.272705078125,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Departure Date[role=\\"combobox\\"])'),
            targetPage.locator('#__picker1-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__picker1-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 13.965904235839844,
                y: 9.45452880859375,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Departure Date[role=\\"combobox\\"])'),
            targetPage.locator('#__picker1-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__picker1-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('01.10.2023');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__input7-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__input7-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 85.60226440429688,
                y: 9.45452880859375,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__input7-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__input7-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('AUH-CCJ');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__select2-__xmlview0--idTravelIti-0-label'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__select2-__xmlview0--idTravelIti-0-label\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 84.2386474609375,
                y: 6.45452880859375,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Morning)'),
            targetPage.locator('#__item31-__xmlview0--idTravelIti-0'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item31-__xmlview0--idTravelIti-0\\"])'),
            targetPage.locator('::-p-text(Morning)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 64,
                y: 12,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Return Date[role=\\"combobox\\"])'),
            targetPage.locator('#__picker2-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__picker2-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 103.875,
                y: 17.45452880859375,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Return Date[role=\\"combobox\\"])'),
            targetPage.locator('#__picker2-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__picker2-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('10.10.2023');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__input8-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__input8-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 71.5113525390625,
                y: 18.45452880859375,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__input8-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__input8-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('CCJ');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.up('j');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__input8-__xmlview0--idTravelIti-0-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__input8-__xmlview0--idTravelIti-0-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('CCJ-AUH');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__select3-__xmlview0--idTravelIti-0-label'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__select3-__xmlview0--idTravelIti-0-label\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 136.147705078125,
                y: 15.45452880859375,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Morning)'),
            targetPage.locator('#__item36-__xmlview0--idTravelIti-0'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item36-__xmlview0--idTravelIti-0\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 72,
                y: 18,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__select3-__xmlview0--idTravelIti-0-label'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__select3-__xmlview0--idTravelIti-0-label\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 108.147705078125,
                y: 15.45452880859375,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Afternoon)'),
            targetPage.locator('#__item37-__xmlview0--idTravelIti-0'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item37-__xmlview0--idTravelIti-0\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 59,
                y: 19,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Local Mobile No. [role=\\"spinbutton\\"])'),
            targetPage.locator('#__xmlview0--localNo-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--localNo-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 83.522705078125,
                y: 3.6363525390625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Local Mobile No. [role=\\"spinbutton\\"])'),
            targetPage.locator('#__xmlview0--localNo-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--localNo-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('971555225800');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--ocode-vhi'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--ocode-vhi\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 28.477294921875,
                y: 8.6363525390625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Search[role=\\"searchbox\\"])'),
            targetPage.locator('#codeidfragment-searchField-I'),
            targetPage.locator('::-p-xpath(//*[@id=\\"codeidfragment-searchField-I\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 61.54541015625,
                y: 20.545448303222656,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Search[role=\\"searchbox\\"])'),
            targetPage.locator('#codeidfragment-searchField-I'),
            targetPage.locator('::-p-xpath(//*[@id=\\"codeidfragment-searchField-I\\"])')
        ])
            .setTimeout(timeout)
            .fill('971');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#codeidfragment-list-listUl div.sapMSLIDescription'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__item59-__clone158-content\\"]/div/div[2])'),
            targetPage.locator(':scope >>> #codeidfragment-list-listUl div.sapMSLIDescription'),
            targetPage.locator('::-p-text(AEUtd.Arab Emir.)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 125.272705078125,
                y: 4.6363525390625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Overseas Mob. No. [role=\\"spinbutton\\"])'),
            targetPage.locator('#__xmlview0--overseasNo-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--overseasNo-inner\\"])')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 30.25,
                y: 13.6363525390625,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('::-p-aria(Overseas Mob. No. [role=\\"spinbutton\\"])'),
            targetPage.locator('#__xmlview0--overseasNo-inner'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--overseasNo-inner\\"])')
        ])
            .setTimeout(timeout)
            .fill('971555225800');
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__bar0-BarRight'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__bar0-BarRight\\"])'),
            targetPage.locator('::-p-text(ReviewValidate)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 1471,
                y: 0.9090576171875,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__xmlview0--validatebtn-BDI-content'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__xmlview0--validatebtn-BDI-content\\"])'),
            targetPage.locator('::-p-text(Validate)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 14.7386474609375,
                y: 4.818115234375,
              },
            });
    }
    {
        const targetPage = page;
        await puppeteer.Locator.race([
            targetPage.locator('#__mbox-btn-0-BDI-content'),
            targetPage.locator('::-p-xpath(//*[@id=\\"__mbox-btn-0-BDI-content\\"])'),
            targetPage.locator('::-p-text(Ok)')
        ])
            .setTimeout(timeout)
            .click({
              offset: {
                x: 5.897705078125,
                y: 5.07952880859375,
              },
            });
    }

    await browser.close();

    async function waitForElement(step, frame, timeout) {
      const {
        count = 1,
        operator = '>=',
        visible = true,
        properties,
        attributes,
      } = step;
      const compFn = {
        '==': (a, b) => a === b,
        '>=': (a, b) => a >= b,
        '<=': (a, b) => a <= b,
      }[operator];
      await waitForFunction(async () => {
        const elements = await querySelectorsAll(step.selectors, frame);
        let result = compFn(elements.length, count);
        const elementsHandle = await frame.evaluateHandle((...elements) => {
          return elements;
        }, ...elements);
        await Promise.all(elements.map((element) => element.dispose()));
        if (result && (properties || attributes)) {
          result = await elementsHandle.evaluate(
            (elements, properties, attributes) => {
              for (const element of elements) {
                if (attributes) {
                  for (const [name, value] of Object.entries(attributes)) {
                    if (element.getAttribute(name) !== value) {
                      return false;
                    }
                  }
                }
                if (properties) {
                  if (!isDeepMatch(properties, element)) {
                    return false;
                  }
                }
              }
              return true;

              function isDeepMatch(a, b) {
                if (a === b) {
                  return true;
                }
                if ((a && !b) || (!a && b)) {
                  return false;
                }
                if (!(a instanceof Object) || !(b instanceof Object)) {
                  return false;
                }
                for (const [key, value] of Object.entries(a)) {
                  if (!isDeepMatch(value, b[key])) {
                    return false;
                  }
                }
                return true;
              }
            },
            properties,
            attributes
          );
        }
        await elementsHandle.dispose();
        return result === visible;
      }, timeout);
    }

    async function querySelectorsAll(selectors, frame) {
      for (const selector of selectors) {
        const result = await querySelectorAll(selector, frame);
        if (result.length) {
          return result;
        }
      }
      return [];
    }

    async function querySelectorAll(selector, frame) {
      if (!Array.isArray(selector)) {
        selector = [selector];
      }
      if (!selector.length) {
        throw new Error('Empty selector provided to querySelectorAll');
      }
      let elements = [];
      for (let i = 0; i < selector.length; i++) {
        const part = selector[i];
        if (i === 0) {
          elements = await frame.$$(part);
        } else {
          const tmpElements = elements;
          elements = [];
          for (const el of tmpElements) {
            elements.push(...(await el.$$(part)));
          }
        }
        if (elements.length === 0) {
          return [];
        }
        if (i < selector.length - 1) {
          const tmpElements = [];
          for (const el of elements) {
            const newEl = (await el.evaluateHandle(el => el.shadowRoot ? el.shadowRoot : el)).asElement();
            if (newEl) {
              tmpElements.push(newEl);
            }
          }
          elements = tmpElements;
        }
      }
      return elements;
    }

    async function waitForFunction(fn, timeout) {
      let isActive = true;
      const timeoutId = setTimeout(() => {
        isActive = false;
      }, timeout);
      while (isActive) {
        const result = await fn();
        if (result) {
          clearTimeout(timeoutId);
          return;
        }
        await new Promise(resolve => setTimeout(resolve, 100));
      }
      throw new Error('Timed out');
    }
})().catch(err => {
    console.error(err);
    process.exit(1);
});
