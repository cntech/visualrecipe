var loaderUtils = require('loader-utils')
var fs = require('fs')
module.exports = function(source, map) {
  this.cacheable()
  var query = loaderUtils.parseQuery(this.query)
  var result = source
    .replace(/<script[^>]+>/g, function(all) {
      return all + '\n' + fs.readFileSync(query.src)
    })
  this.callback(null, result, map)
}
