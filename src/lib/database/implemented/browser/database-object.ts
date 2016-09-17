import {DatabasePath} from './database-path'
export class DatabaseObject {
  constructor(protected rawObject: Object | undefined) {}
  exists(): boolean {
    return typeof this.rawObject !== 'undefined'
  }
  getRaw(): Object {
    return this.rawObject
  }
  getChild(key: string): DatabaseObject {
    return new DatabaseObject(this.rawObject[key])
  }
  setChild(key: string, value: DatabaseObject) {
    this.rawObject[key] = value.rawObject
  }
  findSubObject(path: DatabasePath, touch: boolean, array: boolean): DatabaseObject {
    if(path.isEmpty()) {
      return this
    }
    let key: string = path.peek()
    let nextPath: DatabasePath = path.removeTop()
    if(!this.exists()) {
      if(touch) {
        this.rawObject = {}
      } else {
        return this
      }
    }
    let nextObject: DatabaseObject = this.getChild(key)
    if(!nextObject.exists()) {
      // not found
      if(touch) {
        // create it
        this.setChild(key, new DatabaseObject(array? [] : {}))
        nextObject = this.getChild(key)
      }
    }
    if(!nextPath.isEmpty()) {
      return nextObject.findSubObject(nextPath, touch, array)
    }
    // all other cases:
    return nextObject
  }
  existsSubObject(path: DatabasePath): boolean {
    return this.findSubObject(path, false, false).exists()
  }
  getSubObject(path: DatabasePath): DatabaseObject {
    return this.findSubObject(path, false, false)
  }
  touchSubObject(path: DatabasePath, array: boolean): DatabaseObject {
    return this.findSubObject(path, true, array)
  }
}
