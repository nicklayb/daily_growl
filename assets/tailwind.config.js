const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/daily_growl_web.ex",
    "../lib/daily_growl_web/**/*.*ex"
  ],
  plugins: [
    require("@tailwindcss/forms"),
  ]
}
