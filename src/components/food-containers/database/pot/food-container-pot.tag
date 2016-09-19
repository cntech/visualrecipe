let riot = require('riot')
<food-container-pot>
  <img src="./pan.svg" title="Pot" alt="pot">
  <script type="text/typescript">
    import {FoodSlotConfig} from 'components/food-containers/food-slot-config'
    this.getSlots = (): FoodSlotConfig[] => {
      let slots: FoodSlotConfig[] = []
      let size = 24 // slot size
      let base = {
        x: size * 2 /* fine tuning: */ + 5,
        y: size * 3.5
      }
      let i = 1
      for(let y = 0; y < 4; y++) {
        for(let x = 0; x < 5; x++) {
          let name: string = String(i)
          slots.push(new FoodSlotConfig(name, base.x+x*size, base.y+y*size))
          i++
        }
      }
      return slots
    }
  </script>
</food-container-pot>
