import {expect} from 'chai'
import {DatabaseObject} from '../database-object'
import {DatabasePath} from '../database-path'

describe('DatabaseObject', () => {
  it('should touch a new sub-object (depth 1)', () => {
    let initiallyEmptyObject: Object = {}
    let databaseObject = new DatabaseObject(initiallyEmptyObject)
    let raw: Object = databaseObject.getRaw()
    expect(raw['a']).to.be.not.ok

    let path = new DatabasePath(['a'])
    let resultingObject = databaseObject.touchSubObject(path, false)

    let newRaw: Object = databaseObject.getRaw()
    expect(newRaw['a']).to.deep.equal({})
    expect(resultingObject.getRaw()).to.deep.equal({})
  })
  it('should touch a new sub-object (depth 3)', () => {
    let initiallyEmptyObject: Object = {}
    let databaseObject = new DatabaseObject(initiallyEmptyObject)
    let raw: Object = databaseObject.getRaw()
    expect(raw['a']).to.be.not.ok

    let path = new DatabasePath(['a', 'b', 'c'])
    let resultingObject = databaseObject.touchSubObject(path, false)

    let newRaw: Object = databaseObject.getRaw()
    expect(newRaw['a']).to.be.ok
    expect(newRaw['a']['b']).to.be.ok
    expect(newRaw['a']['b']['c']).to.deep.equal({})
    expect(resultingObject.getRaw()).to.deep.equal({})
  })
  it('should touch a new sub-array', () => {
    let initiallyEmptyObject: Object = {}
    let databaseObject = new DatabaseObject(initiallyEmptyObject)
    let raw: Object = databaseObject.getRaw()
    expect(raw['a']).to.be.not.ok

    let path = new DatabasePath(['a', 'b', 'c'])
    let resultingObject = databaseObject.touchSubObject(path, true)

    let newRaw: Object = databaseObject.getRaw()
    expect(newRaw['a']).to.be.ok
    expect(newRaw['a']['b']).to.be.ok
    expect(newRaw['a']['b']['c']).to.deep.equal([])
    expect(resultingObject.getRaw()).to.deep.equal([])
  })
  it('should test a non-existing sub-object (path length 1)', () => {
    let emptyObject: Object = {}
    let databaseObject = new DatabaseObject(emptyObject)

    let path = new DatabasePath(['a'])
    let result: boolean = databaseObject.existsSubObject(path)
    expect(result).to.be.false
  })
  it('should test a non-existing sub-object (object undefined, path length 1)', () => {
    let undefinedObject: Object = undefined
    let databaseObject = new DatabaseObject(undefinedObject)

    let path = new DatabasePath(['a'])
    let result: boolean = databaseObject.existsSubObject(path)
    expect(result).to.be.false
  })
  it('should test a non-existing sub-object (path length 2)', () => {
    let emptyObject: Object = {}
    let databaseObject = new DatabaseObject(emptyObject)

    let path = new DatabasePath(['a', 'b'])
    let result: boolean = databaseObject.existsSubObject(path)
    expect(result).to.be.false
  })
  it('should test an existing sub-object', () => {
    let populatedObject: Object = {'a':{'b':{'c':{}}}}
    let databaseObject = new DatabaseObject(populatedObject)

    let path = new DatabasePath(['a', 'b', 'c'])
    let result: boolean = databaseObject.existsSubObject(path)
    expect(result).to.be.true
  })
  it('should test an existing sub-object (more exists)', () => {
    let populatedObject: Object = {'a':{'b':{'c':{}}}}
    let databaseObject = new DatabaseObject(populatedObject)

    let path = new DatabasePath(['a', 'b'])
    let result: boolean = databaseObject.existsSubObject(path)
    expect(result).to.be.true
  })
  it('should test a non-existing sub-object (partially existent)', () => {
    let populatedObject: Object = {'a':{'b':{'c':{}}}}
    let databaseObject = new DatabaseObject(populatedObject)

    let path = new DatabasePath(['a', 'b', 'c', 'd'])
    let result: boolean = databaseObject.existsSubObject(path)
    expect(result).to.be.false
  })
  it('should test an existing sub-object', () => {
    let populatedObject: Object = {'a':{'b':{'c':{}}}}
    let databaseObject = new DatabaseObject(populatedObject)

    let path = new DatabasePath(['a', 'b', 'c'])
    let result: Object = databaseObject.getSubObject(path).getRaw()
    expect(result).to.be.ok
  })
  it('should test an existing sub-object (more exists)', () => {
    let populatedObject: Object = {'a':{'b':{'c':{}}}}
    let databaseObject = new DatabaseObject(populatedObject)

    let path = new DatabasePath(['a', 'b'])
    let result: Object = databaseObject.getSubObject(path).getRaw()
    expect(result).to.be.ok
  })
  it('should test a non-existing sub-object (partially existent)', () => {
    let populatedObject: Object = {'a':{'b':{'c':{}}}}
    let databaseObject = new DatabaseObject(populatedObject)

    let path = new DatabasePath(['a', 'b', 'c', 'd'])
    let result: Object = databaseObject.getSubObject(path).getRaw()
    expect(result).to.be.not.ok
  })
  it('should get the existing root object', () => {
    let populatedObject: Object = {'a':{'b':{'c':{}}}}
    let databaseObject = new DatabaseObject(populatedObject)

    let path = new DatabasePath([])
    let result: Object = databaseObject.getSubObject(path).getRaw()
    expect(result).to.deep.equal({'a':{'b':{'c':{}}}})
  })
})
