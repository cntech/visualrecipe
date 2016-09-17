let riot = require('riot')
require('./recipe-step')
require('form/rich-input')
<recipe>
  <form onsubmit={ submit } class="form-horizontal">
    <rich-input class="form-group" input_id="name" label="name" placeholder="recipe name"></rich-input>
  </form>
  <div class="btn-group">
    <button type="button" class="btn btn-default">{ text }</button>
  </div>
  <script type="text/typescript">
    import {Config} from 'config'
    import {Form} from 'form/form'
    import {BrowserDatabase} from 'browser-database'
    let db = BrowserDatabase.installFromConfig(Config.database)
    let me = this
    me.form = new Form(me)

    // form I/O
    me.loadIntoForm = (data: Object) => {
      me.form.getInput('name').setValue((<any>data).name)
    }
    me.readFromForm = (): Object => {
      return <Object>{
        name: me.form.getInput('name').getValue()
      }
    }

    let myId: string = me.opts.page.parameters[0]
    let databaseTable: string | undefined = Config.pages.recipe.databaseTable

    // query database
    me.on('mount', () => {
      if(databaseTable && myId) {
        let result = db.getById(databaseTable, myId)
        if(result) {
          me.loadIntoForm(result)
        }
      }
    })

    // submit to database
    me.submit = (e) => {
      e.preventDefault()
      let data: Object = me.readFromForm()
      if(databaseTable) {
        if(myId) {
          db.updateById(databaseTable, myId, data)
        } else {
          db.create(databaseTable, data)
        }
      }
    }

  </script>
</recipe>
