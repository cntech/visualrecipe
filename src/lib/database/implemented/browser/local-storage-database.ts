export class LocalStorageDatabase {
  protected cache: Object | undefined
  constructor(protected key: string) {}
  getObject(): Object {
    let jsonString: string = localStorage[this.key] || '{}'
    this.cache = JSON.parse(jsonString)
    return this.cache
  }
  persistObject() {
    let jsonString: string = JSON.stringify(this.cache)
    localStorage.setItem(this.key, jsonString)
  }
  generateUid(): string {
    let randomValue: number = Math.random()
    let mask: number = 0x100000000
    let result: number = randomValue * mask
    let hexResult: string = result.toString(16)
    return hexResult
  }
}
