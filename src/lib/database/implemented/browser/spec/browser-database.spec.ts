import {expect} from 'chai'
import {BrowserDatabase} from '../browser-database'
import {Schema} from '../../../schema.interface'
import {LocalStorageDatabase} from '../local-storage-database'
describe('BrowserDatabase', () => {
  let uidCounter: number = 0
  function dummyLocalStorageDatabase() {
    return <LocalStorageDatabase>{
      getObject() {
        if(!this.cache) {
          this.cache = {}
        }
        return this.cache
      },
      persistObject() {},
      generateUid(): string {
        uidCounter++
        return uidCounter.toString()
      }
    }
  }
  function dummyDatabase(localStorageDatabase: LocalStorageDatabase | undefined) {
    return new BrowserDatabase(
      localStorageDatabase || dummyLocalStorageDatabase(),
      [
        <Schema>{
          name: 'Fruits Table',
          tableName: 'fruits'
        },
        <Schema>{
          name: 'Cups Table',
          tableName: 'cups'
        },
        <Schema>{
          name: 'Pans Table',
          tableName: 'pans'
        }
      ]
    )
  }
  function dummyFruitRecords(): Object[] {
    return [
      {
        'id': '2',
        'name': 'apple',
        'colorKnown': false
      },
      {
        'id': '1',
        'name': 'banana',
        'color': 'yellow',
        'colorKnown': true
      }, {
        'id': '3',
        'name': 'orange',
        'color': 'orange',
        'colorKnown': true
      }
    ]
  }
  function installedDummyFruitDatabase(): BrowserDatabase {
    let localStorageDatabase = dummyLocalStorageDatabase()
    let db = dummyDatabase(localStorageDatabase)
    db.install()
    let dbObject: any = localStorageDatabase.getObject()
    dbObject.fruits = dummyFruitRecords()
    return db
  }
  it('should complain if the database is uninitialized', () => {
    let db = dummyDatabase(undefined)
    expect(() => db.getTable('abc')).to.throw(Error, 'please call install before operating on the database')
  })
  it('should initialize the database with 3 tables', () => {
    let localStorageDatabase = dummyLocalStorageDatabase()
    let db = dummyDatabase(localStorageDatabase)
    expect(localStorageDatabase.getObject()).to.deep.equal({})
    db.install()
    expect(localStorageDatabase.getObject()).to.deep.equal({
      'fruits': [],
      'cups': [],
      'pans': []
    })
  })
  it('should store some fruits', () => {
    uidCounter = 0
    let localStorageDatabase = dummyLocalStorageDatabase()
    let db = dummyDatabase(localStorageDatabase)
    db.install()
    db.create('fruits', {
      'name': 'apple',
      'color': 'yellow'
    })
    expect(localStorageDatabase.getObject()).to.deep.equal({
      'fruits': [{
        'id': '1',
        'name': 'apple',
        'color': 'yellow'
      }],
      'cups': [],
      'pans': []
    })
  })
  it('should get a fruit', () => {
    let db: BrowserDatabase = installedDummyFruitDatabase()
    expect(db.get('fruits', r => r.color == 'orange')).to.deep.equal([{
      'id': '3',
      'name': 'orange',
      'color': 'orange',
      'colorKnown': true
    }])
  })
  it('should update a fruit', () => {
    let db: BrowserDatabase = installedDummyFruitDatabase()
    db.update('fruits', r => (r.name == 'apple' || r.name == 'orange'), {
      'color': 'green',
      'colorKnown': true
    })
    expect(db.get('fruits', r => true)).to.deep.equal([
      {
        'id': '2',
        'name': 'apple',
        'color': 'green',
        'colorKnown': true
      },
      {
        'id': '1',
        'name': 'banana',
        'color': 'yellow',
        'colorKnown': true
      }, {
        'id': '3',
        'name': 'orange',
        'color': 'green',
        'colorKnown': true
      }
    ])
  })
  it('should delete a fruit', () => {
    let db: BrowserDatabase = installedDummyFruitDatabase()
    db.destroy('fruits', r => r.id == 1) // delete fruit with id 1: the banana
    // apple and orange should have survived:
    expect((db.get('fruits', r => true)||[]).map(r => (<any>r).name)).to.deep.equal(['apple', 'orange'])
  })
})
