let riot = require('riot')
<food-slot>
  <div
    ondragover={ handleDragOver }
    ondrop={ handleDrop }
    ondragenter={ handleDragEnter }
    ondragleave={ handleDragLeave }>
    <div if={ state.appearingEmpty() } class="empty">{ opts.name }</div>
    <div if={ state.receiving() } class="receiving">{ opts.name }</div>
    <ingredient if={ state.appearingDefined() } identifier={ ingredient }></ingredient>
  </div>
  <script type="typescript">
    let $ = require<any>('jquery')
    interface IStatefulTag {
      update(): void,
      state: State
    }
    class State {
      private _defined: boolean = false
      private _receiving: boolean = false
      constructor(private owner: IStatefulTag) {
        owner.state = this
      }
      defined(): boolean { return this._defined }
      setDefined(defined: boolean) {
        this._defined = defined
        this.owner.update()
      }
      receiving(): boolean { return this._receiving }
      setReceiving(receiving: boolean) {
        this._receiving = receiving
        this.owner.update()
      }
      appearingEmpty(): boolean { return (!this.defined()) && (!this.receiving()) }
      appearingDefined(): boolean { return this.defined() && (!this.receiving()) }
    }
    let state = new State(this)
    this.handleDragEnter = (e) => {
      e.preventDefault()
      state.setReceiving(true)
    }
    this.handleDragLeave = (e) => {
      setTimeout(() => {
        state.setReceiving(false)
      }, 100) // for chromium: make sure dragleave is processed AFTER dragenter
    }
    this.handleDragOver = (e) => {
      e.preventDefault() // allows us to drop
      state.setReceiving(true)
    }
    this.handleDrop = (e) => {
      e.preventDefault()
      let ingredient: string = e.dataTransfer.getData('text/plain')
      this.ingredient = ingredient
      state.setDefined(true)
      state.setReceiving(false)
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
    div.empty, div.receiving {
      width: @inner-size;
      height: @inner-size;

      // center text horizontally and vertically
      line-height: @inner-size;
      text-align: center;

      color: @color;
      border: @border-width solid @color;
    }
    div.receiving {
      color: green;
      border-color: green;
      background-color: #CCFB5D;
    }
  </style>
</food-slot>
