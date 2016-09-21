let express = require('express')
let app = express()

let path = require('path')

app.use(express.static('public'))

// everything else --> index.html
app.get('/*', (req, res) => {
   res.sendFile(path.join(__dirname, 'public/index.html'))
})

let host = process.env.HOST
let port = process.env.PORT || 8080
app.listen(port, host, () => {
  console.log('Visual Recipe listening on ' + (host||'') + ':' + port)
})
