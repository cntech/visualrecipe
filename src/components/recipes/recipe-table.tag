let riot = require('riot')
<recipe-table>
  <table class="table">
    <tbody>
      <tr each={ recipes }>
        <td class="main-column"><a href={ recipeLink(id) }>{ name }</a></td>
        <td class="button-column">
          <span onclick={ remove(id) } class="glyphicon glyphicon-remove"></span>
        </td>
      </tr>
    </tbody>
  </table>
  <script type="text/typescript">
    let path = require<any>('path')
    import {Config} from 'config'
    import {BrowserDatabase} from 'browser-database'
    let db = BrowserDatabase.installFromConfig(Config.database)
    let me = this

    let databaseTable: string | undefined = Config.pages.recipeTable.databaseTable

    me.load = () => {
      if(databaseTable) {
        me.recipes = db.get(databaseTable, r => true)
      }
    }

    me.recipeLink = (recipeId: string) => {
      return path.join(Config.pages.recipe.route, recipeId)
    }

    me.remove = (recipeId: string) => {
      return (e) => {
        e.preventDefault()
        if(databaseTable) {
          console.log('destroy', recipeId)
          db.destroyById(databaseTable, recipeId)
          me.load()
        }
      }
    }

    me.load()

  </script>
  <style type="text/less" scoped>
    .main-column {
      width: 100%;
    }
    .button-column {
      .glyphicon {
        cursor: pointer;
      }
    }
  </style>
</recipe-table>
