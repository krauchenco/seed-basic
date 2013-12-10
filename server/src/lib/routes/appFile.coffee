exports.addRoutes = (app, config) ->
  app.all "/", (req, res) ->
    res.sendfile "index.html",
      root: config.server.distFolder
