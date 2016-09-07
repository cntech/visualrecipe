module.exports = function(source) {
  this.cacheable()
  var result = source
    .replace(/^module.exports = "/, '')
    .replace(/";$/, '')
    .replace(/" \+ require\("([^"]+)"\) \+ "/g, function(all, value) {
      return "' + require('" + value + "') + '"
    })
    .replace(/\\n/g, '\n')
  return result
}
