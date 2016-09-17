import {Schema} from '../../schema.interface'
export interface BrowserDatabaseConfig {
  localStorageKey: string
  schemata: Schema[]
}
