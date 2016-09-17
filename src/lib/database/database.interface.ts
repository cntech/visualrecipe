export interface Database {
  install()
  create(tableName: string, data: Object)
  get(tableName: string, selector: (Object) => boolean): Object[]
  update(tableName: string, selector: (Object) => boolean, data: Object)
  destroy(tableName: string, selector: (Object) => boolean)
}
