let riot = require('riot')
<page-content>
  <p>This page does not exist.</p>
  <script type="text/typescript">
    import {Config} from 'config'
    let riot = require<any>('riot')
    let riotRoute = require<any>('riot-route')
    let defaultPage: string = this.opts.defaultPage
    riotRoute.base(Config.routing.base || '/')
    riotRoute(function(page) {
      let pageParameters: Array<string> = Array.prototype.slice.call(arguments, 1)
      // "pageParameters" now contains all arguments after "page"
      riot.mount('page-content', page || defaultPage, {
        page: {
          parameters: pageParameters
        }
      })
    })
    riotRoute.start(true)
  </script>
</page-content>
