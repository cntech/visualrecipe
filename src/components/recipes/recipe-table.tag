let riot = require('riot')
<recipe-table>
  <table>
    <tbody>
      <tr each={ recipes }>
        <td><a href={ recipeLink(id) }>{ name }</a></td>
      </tr>
    </tbody>
  </table>
  <script type="text/typescript">
    let path = require<any>('path')
    import {Config} from 'config'
    import {BrowserDatabase} from 'browser-database'
    let db = BrowserDatabase.installFromConfig(Config.database)
    let me = this
    me.recipes = db.get('recipes', r => true)
    me.recipeLink = (recipeId: string) => {
      return path.join(Config.pages.recipe.route, recipeId)
    }
  </script>
</recipe-table>
