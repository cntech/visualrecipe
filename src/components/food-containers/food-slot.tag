let riot = require('riot')
<food-slot>
  <div>
    <div class="dropzone"
      ondragover={ handleDragOver }
      ondrop={ handleDrop }
      ondragenter={ handleDragEnter }
      ondragleave={ handleDragLeave }></div>
    <div if={ state.appearingEmpty() } class="empty">{ opts.name }</div>
    <div if={ state.receiving() } class="receiving">{ opts.name }</div>
    <ingredient if={ state.appearingDefined() } identifier={ ingredient }></ingredient>
  </div>
  <script type="text/typescript">
    let $ = require<any>('jquery')
    interface StatefulTag {
      update(): void,
      state: State
    }
    class State {
      private _defined: boolean = false
      private _receiving: boolean = false
      constructor(private owner: StatefulTag) {
        owner.state = this
      }
      defined(): boolean { return this._defined }
      setDefined(defined: boolean) {
        this._defined = defined
        this.owner.update()
        let ingredient = (<any>this.owner).tags.ingredient
        if(ingredient) {
          let me = this
          ingredient.publisher.on('remove', (e, ingredientTag) => {
            me.setDefined(false)
            delete (<any>this.owner).ingredient
          })
        }
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
      state.setReceiving(false)
      let json: string = e.dataTransfer.getData('text/plain')
      let data = JSON.parse(json)
      if(data.ingredient) {
        let identifier: string = data.ingredient.identifier
        this.setIngredient(identifier)
        if(e.altKey) {
          let neighbors = this.neighbors
          if(neighbors && neighbors.y) {
            neighbors.y.forEach((neighbor) => {
              neighbor.setIngredient(identifier)
            })
          }
        }
      }
    }
    this.setIngredient = (identifier: string) => {
      this.ingredient = identifier
      state.setDefined(true)
    }
    let x: number = parseInt(this.opts.x)
    let y: number = parseInt(this.opts.y)
    this.on('mount', () => {
      $(this.root).css({ left: x, top: y })
    })

    // take the promise of the following deferred object to see if the tag is completely rendered
    this.readyDeferred = new $.Deferred()

    this.one('mount', () => { // wait for mount, then access food container
      this.readyDeferred.resolve()
    })

    this.setNeighbors = (neighbors) => {
      this.neighbors = neighbors
    }

    // serialization support
    this.setData = (data: Object | undefined) => {
      if(data) {
        let ingredient = (<any>data).ingredient
        this.readyDeferred.promise().then(() => {
          this.ingredient = ingredient
          if(this.ingredient) {
            state.setDefined(true)
          }
        })
      }
    }
    this.getData = (): Object => {
      return {
        ingredient: this.ingredient
      }
    }

  </script>
  <style type="text/less" scoped>
    @color: #ddd;
    @border-width: 1px;
    // @inner-size: 36px - 2 * @border-width;
    // for bootstrap (border-box):
    @inner-size: 36px;
    @dropzone-size: 22px;
    :scope {
      display: block;
      position: absolute;
      left: 0;
      top: 0;
    }
    div.dropzone {
      position: absolute;
      left: (@inner-size - @dropzone-size) * 0.5;
      top: (@inner-size - @dropzone-size) * 0.5;
      width: @dropzone-size;
      height: @dropzone-size;
      z-index: 1;
    }
    div.empty, div.receiving {
      width: @inner-size;
      height: @inner-size;

      // center text horizontally and vertically
      line-height: @inner-size;
      text-align: center;

      color: @color;
      // border: @border-width solid @color;
    }
    div.receiving {
      color: green;
      border-color: green;
      background-color: #CCFB5D;
    }
  </style>
</food-slot>
