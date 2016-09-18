let riot = require('riot')
function requireAll(requireContext) {
  return requireContext.keys().map(requireContext)
}
requireAll(require.context('./database', true, /.tag$/))
// see https://webpack.github.io/docs/context.html
<food-container-option draggable="draggable" ondragstart={ handleDragStart }>
  <script type="text/typescript">
    let riot = require<any>('riot')
    class FoodContainerTag {
      private prefix: string = 'food-container'
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
    let foodContainerTag = new FoodContainerTag(identifier)
    let html: string = foodContainerTag.toHtml()
    this.on('mount', () => {
      this.root.innerHTML = html
      riot.mount(foodContainerTag.tagName())
    })
    this.handleDragStart = (e) => {
      let json: string = JSON.stringify({
        foodContainer: {
          identifier: identifier
        }
      })
      e.dataTransfer.setData('text/plain', json)
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
</food-container-option>
