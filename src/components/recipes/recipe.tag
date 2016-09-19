let riot = require('riot')
require('./recipe-step')
require('form/rich-input')
require('components/ingredients/ingredient')
require('components/food-containers/food-container-option')
<recipe>
  <form onsubmit={ submit } class="form-horizontal">
    <rich-input class="form-group" input_id="name" label="Name" placeholder="recipe name"></rich-input>
    <div class="form-group">
      <label class="col-sm-3 control-label">Number of Steps</label>
      <div class="col-sm-7">
        <div class="btn-group">
          <button type="button"
            each={ stepButtons }
            onclick={ chooseStepCount(value) }
            class={ 'btn btn-default': true, 'active': active }>{ text }</button>
        </div>
        <div class="buttons">
          <button type="submit" class="btn btn-primary">Save Recipe</button>
        </div>
      </div>
    </div>
    <div class="recipe-steps">
      <recipe-step each={ steps }></recipe-step>
    </div>
  </form>
  <script type="text/typescript">
    let path = require<any>('path')
    let $ = require<any>('jquery')
    import {Config} from 'config'
    import {Form} from 'form/form'
    import {BrowserDatabase} from 'browser-database'
    let db = BrowserDatabase.installFromConfig(Config.database)
    let me = this
    me.form = new Form(me)

    // take the promise of the following deferred object to see if the tag is completely rendered
    this.readyDeferred = new $.Deferred()

    this.one('mount', () => { // wait for mount, then access food container
      this.readyDeferred.resolve()
    })

    let myId: string = me.opts.page.parameters[0]
    let databaseTable: string | undefined = Config.pages.recipe.databaseTable

    // query database
    me.on('mount', () => {
      if(databaseTable && myId) {
        let result = db.getById(databaseTable, myId)
        if(result) {
          me.setData(result)
        }
      }
    })

    // submit to database
    me.submit = (e) => {
      e.preventDefault()
      let data: Object = me.getData()
      if(databaseTable) {
        if(myId) {
          db.updateById(databaseTable, myId, data)
        } else {
          db.create(databaseTable, data)
        }
        location.href = path.join('/', Config.pages.recipeTable.route)
      }
    }

    // step buttons
    me.stepButtons = []
    me.allSteps = []
    for(let i = 1; i < 10; i++) {
      me.stepButtons.push({
        value: i,
        text: i
      })
      me.allSteps.push({})
    }
    me.setStepCount = (n) => {
      me.steps = me.allSteps.slice(0, n)
      me.stepButtons.forEach((stepButton) => {
        stepButton.active = stepButton.value == n
      })
    }
    me.chooseStepCount = (n) => {
      return (e) => {
        e.preventDefault()
        me.setStepCount(n)
      }
    }
    me.setStepCount(1)

    // serialization support
    this.setData = (data: Object) => {
      me.form.getInput('name').setValue((<any>data).name)
      let steps = (<any>data).steps || []
      me.setStepCount(steps.length)
      me.update()
      this.readyDeferred.promise().then(() => {
        console.log('recipe ready')
        let mySteps = [].concat(this.tags['recipe-step'] || []) // concat to make sure we get an array
        mySteps.forEach((myStep, index: number) => {
          myStep.setData(steps[index])
        })
      })
    }
    this.getData = (): Object => {
      let mySteps = [].concat(this.tags['recipe-step'] || []) // concat to make sure we get an array
      return {
        name: me.form.getInput('name').getValue(),
        steps: mySteps.map(myStep => (<any>myStep).getData())
      }
    }

  </script>
  <style type="text/less" scoped>
    .recipe-steps {
      text-align: center;
    }
    form {
      .buttons {
        display: inline-block;
      }
    }
  </style>
</recipe>
