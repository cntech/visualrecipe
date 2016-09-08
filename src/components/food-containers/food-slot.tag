let riot = require('riot')
<food-slot>
  <div src="./icons/pan.svg" alt="pan"
    ondragover={ handleDragOver }
    ondrop={ handleDrop }
    ondragend={ handleDragEnd }>{ opts.name }</div>
  <script type="typescript">
    let $ = require<any>('jquery')
    this.handleDragOver = (e) => {
      e.preventDefault() // allows us to drop
    }
    this.handleDrop = (e) => {
      e.preventDefault()
      console.log('drop', e)
    }
    let x: number = parseInt(this.opts.x)
    let y: number = parseInt(this.opts.y)
    this.on('mount', () => {
      $(this.root).css({ left: x, top: y })
    })
  </script>
  <style type="text/less" scoped>
    @color: gray;
    @border-width: 1px;
    @inner-size: 36px - 2 * @border-width;
    :scope {
      display: block;
      position: absolute;
      top: 0;
      left: 0;
    }
    div {
      width: @inner-size;
      height: @inner-size;

      // center text horizontally and vertically
      line-height: @inner-size;
      text-align: center;

      color: @color;
      border: @border-width solid @color;
    }
  </style>
</food-slot>
