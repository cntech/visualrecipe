let riot = require('riot')
<recipe-table>
  <table>
    <tbody>
      <tr each={ recipes }>
        <td>{ name }</td>
      </tr>
    </tbody>
  </table>
  <script type="text/typescript">
    import {Config} from 'config'
    import {BrowserDatabase} from 'browser-database'
    let db = BrowserDatabase.installFromConfig(Config.database)
    this.recipes = db.get('recipes', r => true)
  </script>
</recipe-table>
