/// name: Sample Script
/// description: This is a sample script demonstrating the capabilities of Nobody.



let a = 10;
let b = 20;
let c = a + b;
console.log(`The sum of ${a} and ${b} is ${c}`);

nobody.print("Hello there!");

nobody.readFile("example.ts").then((data) => {
    console.log(data);
}).catch((err) => {
    console.error(err);
});

nobody.writeFile("example.txt", "Hello there!").then(() => {
    console.log("File written successfully!");
}).catch((err) => {
    console.error(err);
});


nobody.wait(1000).then(() => {
    console.log("Hello, world!");
});
