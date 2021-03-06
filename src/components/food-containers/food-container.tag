let riot = require('riot')
function requireAll(requireContext) {
  return requireContext.keys().map(requireContext)
}
requireAll(require.context('./database', true, /.tag$/))
// see https://webpack.github.io/docs/context.html
let foodSlot = require('./food-slot')
<food-container
  ondragover={ handleDragOver }
  ondrop={ handleDrop }
  ondragenter={ handleDragEnter }>
  <div class="food-container"></div>
  <food-slot each={ slots } name={ name } x={ x } y={ y }></food-slot>
  <script type="text/typescript">
    let riot = require<any>('riot')
    let $ = require<any>('jquery')
    import {FoodSlotConfig} from './food-slot-config'
    class FoodContainerTag {
      private prefix: string = 'food-container'
      constructor(public identifier: string) {}
      tagName(): string {
        return this.prefix + '-' + this.identifier
      }
    }

    // take the promise of the following deferred object to see if the tag is completely rendered
    this.readyDeferred = new $.Deferred()

    // food slots
    this.slots = [] // will be filled by this.setFoodContainerType
    function findSlotNeighbors(slots, slot): Object {
      let xNeighbors = []
      let yNeighbors = []
      slots.forEach((slotInList) => {
        if(slotInList === slot) {
          return // do not add myself as my neighbor
        }
        if(slotInList.opts.x === slot.opts.x) {
          (<any>xNeighbors).push(slotInList)
        }
        if(slotInList.opts.y === slot.opts.y) {
          (<any>yNeighbors).push(slotInList)
        }
      })
      return {
        x: xNeighbors,
        y: yNeighbors
      }
    }

    // food container type
    let me = this
    this.setFoodContainerType = (identifier: string | undefined) => {
      me.foodContainerType = identifier || 'pan'
      let foodContainerTag = new FoodContainerTag(me.foodContainerType)
      let domElement = $(me.root).find('.food-container')
      let createdTags = riot.mount(domElement, foodContainerTag.tagName())
      let createdTag = createdTags[0]
      if(createdTag && createdTag.getSlots) {
        me.slots = createdTag.getSlots()
      } else {
        me.slots = []
      }
      me.update()
      let myFoodSlots = [].concat(this.tags['food-slot'] || []) // concat to make sure we get an array
      myFoodSlots.forEach((slot) => {
        (<any>slot).setNeighbors(findSlotNeighbors(myFoodSlots, slot))
      })
      me.readyDeferred.resolve()
    }
    this.getFoodContainerType = (): string => {
      return me.foodContainerType
    }
    this.on('mount', () => {
      me.setFoodContainerType(undefined)
    })
    // exchange food container
    this.handleDragEnter = (e) => {
      e.preventDefault()
    }
    this.handleDragOver = (e) => {
      e.preventDefault() // allows us to drop
    }
    this.handleDrop = (e) => {
      e.preventDefault()
      let json: string = e.dataTransfer.getData('text/plain')
      let data = JSON.parse(json)
      if(data.foodContainer) {
        let identifier: string = data.foodContainer.identifier
        me.setFoodContainerType(identifier)
      }
    }

    // serialization support
    this.setData = (data: Object) => {
      let foodContainerType = (<any>data).foodContainerType
      let foodSlots = (<any>data).foodSlots || []
      this.readyDeferred.promise().then(() => {
        console.log('food container ready')
        me.setFoodContainerType(foodContainerType)
        let myFoodSlots = [].concat(this.tags['food-slot'] || []) // concat to make sure we get an array
        myFoodSlots.forEach((myFoodSlot, index: number) => {
          myFoodSlot.setData(foodSlots[index])
        })
      })
    }
    this.getData = (): Object => {
      let myFoodSlots = [].concat(this.tags['food-slot'] || []) // concat to make sure we get an array
      return {
        foodContainerType: me.getFoodContainerType(),
        foodSlots: myFoodSlots.map(myFoodSlot => (<any>myFoodSlot).getData())
      }
    }

  </script>
  <style type="text/less" scoped>
    :scope {
      display: inline-block;
      position: relative;
    }
    .food-container {
      img {
        opacity: 0.3;
        width: 240px;
        height: 240px;
      }
    }
  </style>
</food-container>
