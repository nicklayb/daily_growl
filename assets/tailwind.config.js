const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/caltar_web.ex",
    "../lib/caltar_web/**/*.*ex"
  ],
  plugins: [
    require("@tailwindcss/forms"),
  ]
}
