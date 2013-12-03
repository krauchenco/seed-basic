# JSON vulnerability protection
# we prepend the data with ")]},\n", which will be stripped by $http in AngularJS
module.exports = (req, res, next) ->
  _send = res.send
  res.send = (body) ->
    contentType = res.getHeader("Content-Type")
    if contentType and contentType.indexOf("application/json") isnt -1
      if 2 is arguments_.length

        # res.send(body, status) backwards compat
        if "number" isnt typeof body and "number" is typeof arguments_[1]
          @statusCode = arguments_[1]
        else
          @statusCode = body
          body = arguments_[1]
      body = ")]}',\n" + body
      return _send.call(res, body)
    _send.apply res, arguments_

  next()