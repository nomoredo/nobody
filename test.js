// This will be injected into the page during the test
// We want this to be able to detect clicks on any element in the page,
// find the best xpath for that element, and call window.log_click(xpath)
// with the xpath as an argument.

// This function will return the xpath for the given element
function calculateXPath(element) {
    if (element) {
        //often times we cannot use id because it may change on page refresh
        //since we are trying to get path to sap gui elements, we can use the id
        //since it is static
        if (element.id) {
            return `id('${element.id}')`;
        }
        //if there is no id, we can use the class name of the element and its parent
        //to get the xpath
        if (element.className) {
            return calculateXPath(element.parentNode) + `/${element.tagName.toLowerCase()}[@class="${element.className}"]`;
        }
        //if there is no class name, we can use the tag name and parent to get the xpath
        return calculateXPath(element.parentNode) + `/${element.tagName.toLowerCase()}`;
    }
    return 'null';
}

//add event listeners to all elements to log clicks
const elements = document.querySelectorAll('*');
for (const element of elements) {
    element.addEventListener('click', (event) => {
        const xpath = calculateXPath(event.target);
        window.log_click(xpath);
    });
}
