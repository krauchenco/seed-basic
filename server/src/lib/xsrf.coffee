uid = (len) ->
  crypto.randomBytes(Math.ceil(len * 3 / 4)).toString("base64").slice(0, len).replace(/\//g, "-").replace /\+/g, "_"
crypto = require("crypto")

# The xsrf middleware provide AngularJS style XSRF-TOKEN provision and validation
# Add it to your server configuration after the session middleware:
#   app.use(xsrf);
#
module.exports = (req, res, next) ->

  # Generate XSRF token
  token = req.session._csrf or (req.session._csrf = uid(24))

  # Get the token in the current request
  requestToken = req.headers["x-xsrf-token"]

  # Add it to the cookie
  res.cookie "XSRF-TOKEN", token

  # Ignore if it is just a read-only request
  switch req.method
    when "GET", "HEAD", "OPTIONS"
    else
      # Check the token in the request against the one stored in the session
      return res.send(403)  if requestToken isnt token

  # All is OK, continue as you were.
  next()