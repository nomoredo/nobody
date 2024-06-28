/// name: Sample Script
/// description: This is a sample script demonstrating the capabilities of Nobody.



    await nobody
    .init()
    .navigateTo('https://example.com')
    .takeScreenshot('example.png')
    .click('#some-button')
    .typeText('#input-field', 'Hello World')
    .getText('#some-element')
    .exec();
     console.log('Extracted Text:', text)
    
    
    await nobody .setTimeout(1000)
    .evaluate("console.log('Hello from Deno')")
    .fillForm('#form', JSON.stringify({ '#input1': 'value1', '#input2': 'value2' }))
    .waitForElement('#some-element')
    .selectOption('#select', 'option-value')
    .scroll(0, 500);
