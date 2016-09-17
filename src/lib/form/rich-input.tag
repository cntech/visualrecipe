let riot = require('riot')
<rich-input>
  <!-- the "empty" class may be used to conditionally hide an empty lable through css media queries -->
  <label for="{ opts.input_id }" class={ 'col-sm-3 control-label': true, 'empty': !opts.label }>{ opts.label }</label>
  <div if={ isInput() } class="col-sm-7">
    <input type={ opts.type || 'text' } class="form-control" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"
      id="{ opts.input_id }"
      name="{ opts.input_id }"
      placeholder="{ opts.placeholder }"
      onkeyup={ handleKeyUp }
      oninput={ handleInput }
      onchange={ handleChange }>
  </div>
  <div if={ isTextArea() } class="col-sm-7">
    <textarea class="form-control" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"
      id="{ opts.input_id }"
      name="{ opts.input_id }"
      placeholder="{ opts.placeholder }"
      onkeyup={ handleKeyUp }
      oninput={ handleInput }
      onchange={ handleChange }></textarea>
  </div>
  <script type="text/typescript">
    var jQuery = require<any>('jquery')
    var $ = jQuery
    var publisher = $({})
    var me = this
    // ...tags['rich-input'] may either be a single Tag instance or an array
    // of tags => thus [].concat(...) to make sure we always deal with an array
    var iAmTheFirstInput = [].concat(me.parent.tags['rich-input'])[0] === me
    if(iAmTheFirstInput) {
      this.on('mount', function() {
        me.getInputElement().focus()
      })
    }
    me.getTagName = () => {
      return me.opts.type === 'textarea'? 'textarea' : 'input'
    }
    me.isTextArea = () => {
      return me.getTagName() === 'textarea'
    }
    me.isInput = () => {
      return !me.isTextArea()
    }
    me.getInputElement = () => {
      var inputElement = jQuery(me.root)
        .find('[name="'+me.opts.input_id+'"]')
      return inputElement
    }
    me.getValue = () => {
      var inputElement = me.getInputElement()
      if(inputElement) {
        return inputElement.val()
      }
    }
    me.setValue = (value) => {
      var inputElement = me.getInputElement()
      if(inputElement) {
        inputElement.val(value)
      }
    }
    me.getPublisher = () => {
      return publisher
    }
    me.handleKeyUp = (e) => {
      publisher.trigger('changed')
    }
    me.handleInput = (e) => {
      publisher.trigger('changed')
    }
    me.handleChange = (e) => {
      publisher.trigger('changed')
    }
  </script>
  <style type="text/less">
    @import 'src/styles/tag-variables';
    rich-input {
      display: block;
      textarea {
        min-height: 20*@rich-input-textarea-height-unit !important;
      }
    }
  </style>
</rich-input>
