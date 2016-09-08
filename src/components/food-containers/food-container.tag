let riot = require('riot')
let foodSlot = require('./food-slot')
<food-container>
  <img src="./icons/pan.svg" alt="pan">
  <food-slot each={ slots } name={ name } x={ x } y={ y }></food-slot>
  <script type="typescript">
    class FoodSlotConfig {
      constructor(public name: string, public x: number, public y: number) {}
    }
    this.slots = []
    let size = 36 // slot size
    let base = {
      x: size,
      y: size * 2
    }
    let i = 1
    for(let y = 0; y < 2; y++) {
      for(let x = 0; x < 3; x++) {
        let name: string = String(i)
        this.slots.push(new FoodSlotConfig(name, base.x+x*size, base.y+y*size))
        i++
      }
    }
  </script>
  <style type="text/less" scoped>
    :scope {
      display: block;
      position: relative;
    }
    img {
      width: 180px;
      height: 180px;
    }
  </style>
</food-container>
