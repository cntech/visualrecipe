let riot = require('riot')
function requireAll(requireContext) {
  return requireContext.keys().map(requireContext)
}
requireAll(require.context('./database', true, /.tag$/))
// see https://webpack.github.io/docs/context.html
<ingredient draggable="draggable" ondragstart={ handleDragStart }>
  <script type="text/typescript">
    let riot = require<any>('riot')
    class IngredientTag {
      private prefix: string = 'ingredient'
      constructor(public identifier: string) {}
      toHtml(): string {
        let prefix: string = this.prefix
        let id: string = this.identifier
        // return `<${prefix}-${id}></${prefix}-${id}>` // FIXME make this work
        return '<'+prefix+'-'+id+'></'+prefix+'-'+id+'>'
      }
      tagName(): string {
        return this.prefix + '-' + this.identifier
      }
    }
    let identifier: string = this.opts.identifier
    let ingredientTag = new IngredientTag(identifier)
    let html: string = ingredientTag.toHtml()
    let me = this
    this.on('mount', () => {
      me.root.innerHTML = html
      riot.mount(ingredientTag.tagName())
    })
    this.handleDragStart = (e) => {
      let json: string = JSON.stringify({
        ingredient: {
          identifier: identifier
        }
      })
      e.dataTransfer.setData('text/plain', json)
    }
  </script>
  <style type="text/less" scoped>
    :scope {
      display: block;
      position: relative;
      z-index: 2;
    }
    img {
      width: 36px;
      height: 36px;
    }
  </style>
</ingredient>
