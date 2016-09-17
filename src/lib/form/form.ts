export class Form {
  protected data: Object | undefined
  constructor(protected formTag: any) {}
  setData(data: Object) {
    var me = this
    me.data = data
    var keys = Object.keys(data)
    keys.forEach(function(key) {
      var input = me.getInput(key, undefined)
      var value = data[key]
      if(input && value) {
        input.setValue(value)
      }
    })
  }
  set(key: string, value: string) {
    if(this.data) {
      this.data[key] = value
    }
  }
  getUnchangedData(): Object | undefined {
    return this.data
  }
  getInput(id: string, inputTagName: string | undefined): any {
    return []
      .concat(this.formTag.tags[inputTagName || 'rich-input'])
      .filter((tag: any) => {
        return tag.opts.input_id === id
      })[0]
  }
}
