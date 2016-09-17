import {Database} from '../../database.interface'
import {Schema} from '../../schema.interface'
import {LocalStorageDatabase} from './local-storage-database'
import {DatabaseObject} from './database-object'
import {DatabasePath} from './database-path'
import {BrowserDatabaseConfig} from './browser-database-config'
export class BrowserDatabase implements Database {
  protected installed: boolean = false
  constructor(
    protected localStorageDatabase: LocalStorageDatabase,
    protected schemata: Schema[]
  ) {}
  static fromConfig(config: BrowserDatabaseConfig): BrowserDatabase {
    return new BrowserDatabase(
      new LocalStorageDatabase(config.localStorageKey),
      config.schemata
    )
  }
  static installFromConfig(config: BrowserDatabaseConfig): BrowserDatabase {
    let db = BrowserDatabase.fromConfig(config)
    db.install()
    return db
  }
  getRawObject(): Object {
    return this.localStorageDatabase.getObject()
  }
  getRootObject(): DatabaseObject {
    let databaseObject = new DatabaseObject(this.getRawObject())
    return databaseObject
  }
  save() {
    this.localStorageDatabase.persistObject()
  }
  install() {
    let databaseObject = this.getRootObject()
    this.schemata.forEach((schema) => {
      let path: string[] = [schema.tableName]
      databaseObject.touchSubObject(new DatabasePath(path), true)
    })
    this.save()
    this.installed = true
  }
  testInstallation() {
    if(!this.installed) {
      throw new Error('please call install before operating on the database')
    }
  }
  getTable(tableName: string): Object[] {
    this.testInstallation()
    let databaseObject = this.getRootObject()
    let tableDatabaseObject = databaseObject.getSubObject(new DatabasePath([tableName]))
    let table: Object = tableDatabaseObject.getRaw()
    if(Array.isArray(table)) { // make sure Object is an Array
      return <Object[]>table
    }
  }
  setTable(tableName: string, table: Object[]) {
    this.testInstallation()
    let databaseObject = this.getRootObject()
    let tableParentDatabaseObject = databaseObject.getSubObject(new DatabasePath([]))
    let tableParent: Object = tableParentDatabaseObject.getRaw()
    if(tableParent) {
      tableParent[tableName] = table
    }
  }
  create(tableName: string, data: Object) {
    let table: Object[] = this.getTable(tableName)
    if(table) {
      let newId
      let result
      do { // loop until the new id is really unique
        newId = this.localStorageDatabase.generateUid()
        result = table.filter((record: Object) => (<any>record).id == newId)
      } while (result.length)
      (<any>data).id = newId
      table.push(data)
      this.save()
    }
  }
  get(tableName: string, selector: (Object) => boolean): Object[] {
    let table: Object[] = this.getTable(tableName)
    if(table) {
      return table.filter(selector)
    }
  }
  update(tableName: string, selector: (Object) => boolean, data: Object) {
    let table: Object[] = this.getTable(tableName)
    if(table) {
      table.filter(selector).forEach((record: Object) => {
        (<any>Object).assign(
          record, // existing record
          data // new data
        )
      })
      this.save()
    }
  }
  destroy(tableName: string, selector: (Object) => boolean) {
    let table: Object[] = this.getTable(tableName)
    let inverseSelector = record => !selector(record)
    let result: Object[] = table.filter(inverseSelector)
    this.setTable(tableName, result)
    this.save()
  }
}
