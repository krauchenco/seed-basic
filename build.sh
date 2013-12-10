#!/usr/bin/env bash
cd client
npm install
bower install
grunt build
cd ..
cd server
npm install
cd src
npm install
cd ../..
node generateExecMac.js
echo 'Execute ./execDevMac.as to run dev mode'