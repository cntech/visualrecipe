let riot = require('riot')
// load jQuery and bootstrap for navbar collapse
window.jQuery = require('jquery')
require('bootstrap')
<page-header>
  <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button"
            class="navbar-toggle collapsed"
            data-toggle="collapse"
            data-target="#navbar"
            aria-expanded="false"
            aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/">Visual Recipe Riot+Typescript</a>
      </div>
      <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
          <li each={ pageLinks }>
            <a data-toggle="collapse" data-target="#navbar" href={ link }>{ text }</a>
          </li>
        </ul>
      </div>
      <table>
        <tbody>
          <tr>
            <td><food-container-option identifier="pan"></food-container-option></td>
            <td><food-container-option identifier="pot"></food-container-option></td>
            <td><ingredient identifier="water"></ingredient></td>
            <td><ingredient identifier="salt-pepper"></ingredient></td>
            <td><ingredient identifier="potato"></ingredient></td>
            <td><ingredient identifier="olive-oil"></ingredient></td>
            <td><ingredient identifier="onion"></ingredient></td>
            <td><ingredient identifier="garlic"></ingredient></td>
            <td><ingredient identifier="red-pepper"></ingredient></td>
            <td><ingredient identifier="chili"></ingredient></td>
            <td><ingredient identifier="carrot"></ingredient></td>
            <td><ingredient identifier="sausage"></ingredient></td>
            <td><ingredient identifier="meat"></ingredient></td>
          </tr>
        </tbody>
      </table>
    </div>
  </nav>
  <script type="text/typescript">
    let path = require<any>('path')
    import {Config} from 'config'
    import {PageConfig, PagesConfig} from 'routing/pages-config'
    let base: string = Config.routing.base || '/'
    let pages: PagesConfig = Config.pages
    let keys: Array<string> = Object.keys(pages)
    this.pageLinks = keys
      .filter((key) => {
        let page: PageConfig = pages[key]
        return page.menuLink
      })
      .map((key) => {
        let page: PageConfig = pages[key]
        return {
          text: page.title,
          link: path.join(base, page.route)
        }
      })
  </script>
  <style type="text/less" scoped>
    nav {
      table {
        display: block;
        padding: 15px;
        padding-left: 0;
        td {
          padding-right: 4px;
        }
      }
    }
  </style>
</page-header>
