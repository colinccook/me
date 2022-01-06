After experimenting with the excellent Blazor, I thought I'd try attempt to share Typescript between a server (Node) and a client (Browser).

By the end of this tutorial, we will have 
- a single Express server that hosts a Typescript compiled front end 
- Typescript back end, with
- Bonus, a socket connection that binds the two together.

The structure will look like this:

```
/dist 
    /server (transpiled server code)
    /client (transpiled client code)
/src
    /common
        /hello.ts
    /server
        /server.ts
    /client
        /index.html
    /app.ts (entry point)
/ts.config.json
``` 

## Step 0: Follow along?

This tutorial assumes you have Node installed and you've npm init'd a new project. 

You can follow along by forking Node using StackBlitz: https://stackblitz.com/fork/node

## Step 1: Creating a server using TypeScript
https://blog.logrocket.com/typescript-with-node-js-and-express/

- npm install express
- npm install --save-dev typescript
- npm install --save-dev @types/node@16 @types/express@4
- ```touch tsconfig.json```, edit to:
```
{
  "compilerOptions": {
    "module": "commonjs",
    "esModuleInterop": true,
    "target": "es6",
    "noImplicitAny": true,
    "moduleResolution": "node",
    "sourceMap": true,
    "outDir": "dist/server",
    "baseUrl": ".",
    "paths": {
      "*": ["node_modules/*"]
    }
  },
  "include": ["src/common/**/*", "src/server/**/*"]
}
```
- ```mkdir src src/common src/server src/client dist dist/client dist/server```
- ```touch src/server/index.ts```, paste:
```
import express from 'express';

const app = express();
const port = 8080; // default port to listen

// define a route handler for the default home page
app.get('/', (req: any, res: any) => {
  res.send('Hello world!');
});

// start the Express server
app.listen(port, () => {
  console.log(`server started at http://localhost:${port}`);
});
```
- edit package.json and add/replace the following entries
```
  "main": "dist/server/index.js",
```
```
  "scripts": {
    "build": "tsc",
    "prestart": "npm run build",
    "start": "node .",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
```
- Remove index.js (if you've created from StackBlitz)

Finally to verify:

- ```npm run build```, that will create dist-server/index.js
- ```npm run start```, you will see Hello world on screen

## Step 2: Building and serving the front end 

We are now going to hardcode express to return a html file at root, so that it can link to a WebPack built JS file.

- ```touch dist/client/client.js```, set to 
```
alert('JavaScript was served');
```
- ```touch src/client/client.html```, set to
```
<p>Page was served</p>
<script src="client.js"></script>
```

In src/server/index.ts:
- ```import path from 'path';``` at the top
- change contents of app.get to
```
res.sendFile(path.join(__dirname, 'client.html'));
```
- change package.json and replace
```
"build": "tsc;cp src/client/client.html dist/server/client.html",
```
- between app.get and app.listen, add:
```
app.use(express.static('dist-client'));
```

Finally to verify:

- ```npm run build```, that will update dist-server/index.js
- ```npm run start```, you will see Page was served on screen and 'JavaScript was served' alert

## Step 3: Using webpack compile client TS into JS

We are serving static JavaScript files in dist-client. We can use WebPack to turn our client TS files and replace client.js with our own code.

- npm install webpack webpack-cli --save-dev
- npm install --save-dev ts-loader
- ```touch src/client/index.ts```, set to
```
alert('Transpiled JavaScript (from TypeScript) is served!');
```
- ```touch webpack.config.js```, set to
```
const path = require('path');

module.exports = {
  entry: './src/client/index.ts',
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  output: {
    filename: 'client.js',
    path: path.resolve(__dirname, 'dist/client'),
  },
}; 
```
- call ```webpack```, this should update your dist/client/client.js to alert typescript
- change your package.json scripts/build entry to:
```
"build": "tsc;webpack",
```

Finally to verify:

- ```npm run build```, that will build your typescript client and server code
- ```npm run start```, you will see Page was served on screen and 'TypeScript was served' alert

## Step 4: The Magic: Creating a common class

Lets see if we can define a common logical class that both server and client can use.

- touch src/common/car.js, and set to
```
export class Car {
  constructor(public name: string, private speed: number) {}
  getSpeed(): number {
    return this.speed;
  }
  increaseSpeed() {
    this.speed += 100;
  }
  getSummary(): string {
    return `${this.name} is going ${this.speed} mph!`;
  }
}
```
- set src/client/index.ts to
```
import { Car } from '../common/car';

const car = new Car('A car from the client', 0);

car.increaseSpeed();
car.increaseSpeed();

alert(car.getSummary());
```
- set src/server/index.js to
```
app.listen(port, () => {
  const car = new Car('A car from the server', 33);
  car.increaseSpeed();

  console.log(`server started at http://localhost:${port}`);
  console.log(car.getSummary());
});
```
Q) Could I have done this better to avoid having to change these two references?
- update sendFile line to
```
res.sendFile(path.join(__dirname, '../../src/client/client.html'));
```
- update package.json main to:
```
"main": "dist-server/server/index.js",
``` 

Finally to verify:

- ```npm run build```, that will build your typescript client and server code
- ```npm run start```, you will see an alert on the browser and a log message from the server using two different car instances, but the same class/logic!

## Step 5a: Using Socket.IO to send a message back to the server

- ```npm install socket.io @types/socket.io socket.io-client```
- replace client.html with
```
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Document</title>
  </head>
  <body>
    <button id="hitMe">Hit Me</button>
    <script src="client.js"></script>
  </body>
</html>
```
- replace src/client/index.ts with
```
import { io } from 'socket.io-client';

class Index {
  socket: any;
  constructor() {
    this.socket = io('http://localhost:4004');
    let hitMe = document.getElementById('hitMe');
    hitMe.addEventListener('click', (e: Event) => this.sendMsg());
  }

  sendMsg() {
    this.socket.emit('message', 'HELLO WORLD');
  }
}

// start the app
new Index();
```
- replace src/server/index.ts with
```
import * as express from 'express';
import * as http from 'http';
import * as socketio from 'socket.io';
import * as path from 'path';

const app = express.default();

app.get('/', (_req, res) => {
  res.sendFile(path.join(__dirname, '../../src/client/client.html'));
});

app.use(express.static('dist-client'));

const server = http.createServer(app);
const io = new socketio.Server(server);

io.on('connection', function (socket: any) {
  console.log('a user connected');
  // whenever we receive a 'message' we log it out
  socket.on('message', function (message: any) {
    console.log(message);
  });
});

server.listen(4004, () => {
  console.log('Running at localhost:4004');
});
```