
import puppeteer from "puppeteer";

const Nobody = {
    open : async () => {
        const browser = await puppeteer.launch();
        const page = await browser.newPage();
        return page;
    }

}

export default Nobody;

export { Nobody };