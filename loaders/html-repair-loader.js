module.exports = function(source, map) {
  this.cacheable()
  var result = source
    .replace(/^module.exports = "/, '')
    .replace(/";$/, '')
    .replace(/" \+ require\("([^"]+)"\) \+ "/g, function(all, value) {
      return "' + require('" + value + "') + '"
    })
    .replace(/\\"/g, '"')
    .replace(/\\n/g, '\n')
  this.callback(null, result, map)
}
