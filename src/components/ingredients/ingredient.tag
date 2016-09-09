let riot = require('riot')
function requireAll(requireContext) {
  return requireContext.keys().map(requireContext)
}
requireAll(require.context('./database', true, /.tag$/))
// see https://webpack.github.io/docs/context.html
<ingredient draggable="draggable" ondragstart={ handleDragStart }>
  <script type="typescript">
    class IngredientTag {
      constructor(public identifier: string) {}
      toHtml(): string {
        let prefix: string = 'ingredient'
        let id: string = this.identifier
        // return `<${prefix}-${id}></${prefix}-${id}>` // FIXME make this work
        return '<'+prefix+'-'+id+'></'+prefix+'-'+id+'>'
      }
    }
    let identifier: string = this.opts.identifier
    let html: string = new IngredientTag(identifier).toHtml()
    this.root.innerHTML = html
    this.handleDragStart = (e) => {
      e.dataTransfer.setData('text/plain', identifier)
    }
  </script>
  <style type="text/less" scoped>
    :scope {
      display: block;
    }
    img {
      width: 36px;
      height: 36px;
    }
  </style>
</ingredient>
