let riot = require('riot')
require('components/food-containers/food-container')
<recipe-step>
  <food-container></food-container>
  <script type="text/typescript">
    let $ = require<any>('jquery')

    // take the promise of the following deferred object to see if the tag is completely rendered
    this.readyDeferred = new $.Deferred()

    this.one('mount', () => { // wait for mount, then access food container
      this.readyDeferred.resolve()
    })

    // serialization support
    this.setData = (data: Object) => {
      let foodContainerData = (<any>data).foodContainer || {}
      this.readyDeferred.promise().then(() => {
        console.log('recipe step ready')
        let myFoodContainer = this.tags['food-container']
        myFoodContainer.setData(foodContainerData)
      })
    }
    this.getData = (): Object => {
      let myFoodContainer = this.tags['food-container']
      return {
        foodContainer: myFoodContainer.getData()
      }
    }
  </script>
  <style type="text/less" scoped>
    :scope {
      display: inline-block;
      text-align: center;
      padding: 20px;
    }
  </style>
</recipe-step>
