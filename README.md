# seed-basic - basic structure with bootstrap, angular, jade and coffee

What is included in this seed:

* **Jade** - All Jades files are compiled to HTML. Angular template most be named to pattern
*.tpl.jade and will be compiled together, generate a single JS file (You read that right: JS file! With the Grunt task
[html2js](https://github.com/karlgoldstein/grunt-html2js)). (the idea is to not have a URL for each template,
leaving the higher granularity - less urls, increases the performance of load App).

* **Coffee Script** - JS client and server code are written in Coffee Script and compile to JS.

* **Less** - The dynamic stylesheet language.

* **AngularJS and Angular-route** - Single Page Application framework.

* **Twitter Bootstrap 3** - Easy Responsive Layout

* **Bower** - Third CSS/JS/HTML packager manager

* **Grunt** - Task manager

* **NodeJS** and **ExpressJS** - Server and route engine.

Thid party packages are downloaded by Bower tool.

## How to use
Clone the repo
```
git clone https://github.com/krauchenco/seed-basic.git
```

### Development

```
cd seed-basic

#install all packages, client and server
./build

# run build-watch client and server and run nodemon with server
./execDevMac.as
```
### Production

#### Compile the client
```
cd seed-basic/client

# install grunt tasks
npm install

# install vendor libs
bower install

# release -> this will generate dist dir with compiled, compress and minify code
grunt release
```

#### Compile the server
```
cd seed-basic/server

# install grunt tasks to compile the source
npm install

# install server dependencies
cd src
npm install
cd..

# build generate dist dir
grunt

# Run server (I recommend using the [pm2](https://github.com/Unitech/pm2) monitor for this
cd dist
node server.js # bad usage in prod, will be stopped with ssh session
```

## Directory structure
```
├── client                         --> Files in client (browser) side
│   ├── bower.json                 --> bower configuration file
│   ├── gruntFile.coffee           --> Grunt tasks
│   ├── package.json               --> Npm configuration for grunt tasks
│   ├── src
│   │   ├── app
│   │   │   ├── app.coffee         --> route and app definition
│   │   │   └── views              --> All template files generate a single JS file, dist/angular.js
│   │   │       ├── view1.tpl.jade --> Angular Templates write in Jade
│   │   │       └── view2.tpl.jade
│   │   ├── assets                 --> image and static resources
│   │   │   └── favicon.ico
│   │   ├── less                   --> less styles, all files in this dir will be compiled to dist/styles.css
│   │   │   └── styles.css
│   │   ├── common                 --> AngularJS Stuff will be compiled to a single JS file, dist/angular.css
│   │   │   ├── directives
│   │   │   ├── resources
│   │   │   ├── security
│   │   │   └── services
│   │   └── index.jade             --> start point
│   └── vendor                     --> third party JS/CSS/HTML
└── server                         --> Files in server (NodeJS) side
    ├── gruntFile.coffee
    ├── package.json               --> Npm configuration to Grunt tasks
    └── src
        ├── cert                   --> https certs
        ├── config.coffee
        ├── lib                    --> NodeJS library
        │   ├── routes             --> ExpressJS routes
        ├── package.json           --> Npm configuration to server
        └── server.coffee          --> server start point
```

## Contact
### Links 
[AngularJS](http://angularjs.org/), [Twitter Bootstrap](http://getbootstrap.com/),
[Bower](https://github.com/bower/bower), [Grunt](http://gruntjs.com/), [Jade](http://jade-lang.com/), [Coffee Script](http://coffeescript.org/),
[Less](http://lesscss.org/),
[NodeJS](http://nodejs.org/), [NPM](https://github.com/bower/bower), [ExpressJS](http://expressjs.com),
[nodemon](https://github.com/remy/nodemon)

Inspired by [angular-seed](https://github.com/angular/angular-seed)

## License
[MIT License](https://github.com/krauchenco/seed-basic/blob/master/LICENSE)

