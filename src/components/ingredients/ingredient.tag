let riot = require('riot')
<ingredient>
  <img src="./icons/orange.svg" alt="ingredient"
    ondragstart={ handleDragStart }>
  <script type="typescript">
    this.handleDragStart = (e) => {
      console.log('start drag', e)
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
