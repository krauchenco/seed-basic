fs = require("fs")
http = require("http")
https = require("https")
privateKey = fs.readFileSync(__dirname + "/cert/privatekey.pem").toString()
certificate = fs.readFileSync(__dirname + "/cert/certificate.pem").toString()
credentials =
  key: privateKey
  cert: certificate

express = require("express")

config = require("./config.js")
xsrf = require("./lib/xsrf")
protectJSON = require("./lib/protectJSON")
require "express-namespace"
app = express()
secureServer = https.createServer(credentials, app)
server = http.createServer(app)
require("./lib/routes/static").addRoutes app, config
app.use protectJSON
app.use express.logger() # Log requests to the console
app.use express.bodyParser() # Extract the data from the body of the request - this is needed by the LocalStrategy authenticate method
app.use express.cookieParser(config.server.cookieSecret) # Hash cookies with this secret
app.use express.cookieSession() # Store the session in the (secret) cookie
app.use xsrf # Add XSRF checks to the request
app.use (req, res, next) ->
  if req.user
    console.log "Current User:", req.user.firstName, req.user.lastName
  else
    console.log "Unauthenticated"
  next()
require("./lib/routes/appFile").addRoutes app, config

# A standard error handler - it picks up any left over errors and returns a nicely formatted server 500 error
app.use express.errorHandler(
  dumpExceptions: true
  showStack: true
)

# Start up the server on the port specified in the config
server.listen config.server.listenPort, "0.0.0.0", 511, ->
  # // Once the server is listening we automatically open up a browser
  open = require("open")
  open "http://localhost:" + config.server.listenPort + "/"

console.log "Angular App Server - listening on port: " + config.server.listenPort
secureServer.listen config.server.securePort
console.log "Angular App Server - listening on secure port: " + config.server.securePort
console.log "final "