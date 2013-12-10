path = require("path")

module.exports = server:
  listenPort: 3000
  securePort: 8433
  distFolder: path.resolve(__dirname, "../../client/dist")
  staticUrl: "/"
  cookieSecret: "seed-basic"