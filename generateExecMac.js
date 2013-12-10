#! /usr/bin/env node
var exec = require('child_process').exec,
  fs = require('fs');

exec('pwd', function (err, dir){
  if (err) throw err;
  dir = dir.replace(/\n/g, '');
  var scr = (
    '#!/usr/bin/env osascript\n\ntell application "iTerm"\n' +
      '  make new terminal\n' +
      '  tell the current terminal\n' +
      '    activate current session\n' +
      '    launch session "Default Session"\n' +
      '    tell the last session to write text "cd DIRECTORY/client; grunt build-watch"\n' +
      '    tell i term application "System Events" to keystroke "D" using command down\n' +
      '    tell the last session to write text "cd DIRECTORY/server; grunt build-watch"\n' +
      '    tell i term application "System Events" to keystroke "D" using command down\n' +
      '    delay 3\n'+
      '    tell the last session to write text "cd DIRECTORY/server/dist; nodemon server.js"\n' +
      '  end tell\n' +
      'end tell').replace(/DIRECTORY/g, dir);
  var nameExec = 'execDevMac.as';
  fs.writeFileSync(nameExec, scr);
  exec('chmod +x '+nameExec, function (err, out){
    if (err) throw err;
  });
});