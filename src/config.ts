import {BrowserDatabaseConfig} from './lib/database/implemented/browser/browser-database-config'
import {Schema} from './lib/database/schema.interface'
export class Config {
  static readonly database = <BrowserDatabaseConfig>{
    localStorageKey: 'visualrecipe',
    schemata: [
      <Schema>{
        name: 'Recipes',
        tableName: 'recipes'
      }
    ]
  }
}
