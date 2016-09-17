export class DatabasePath {
  constructor(public path: string[]) {}
  isEmpty(): boolean {
    return !this.path.length
  }
  getRawCopy(): string[] {
    return this.path.slice() // slice() copies the array
  }
  removeTop(): DatabasePath {
    let copiedPath: string[] = this.getRawCopy()
    copiedPath.shift() // CAUTION shift modifies the array in-place
    let newPath = copiedPath
    return new DatabasePath(newPath)
  }
  removeEnd(): DatabasePath {
    let copiedPath: string[] = this.getRawCopy()
    copiedPath.pop() // CAUTION shift modifies the array in-place
    let newPath = copiedPath
    return new DatabasePath(newPath)
  }
  peek(): string {
    return this.path[0]
  }
  toStringArray(): string[] {
    return this.path
  }
}
