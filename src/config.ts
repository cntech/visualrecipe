import {RoutingConfig} from 'routing/routing-config'
import {PageConfig, PagesConfig} from 'routing/pages-config'
import {BrowserDatabaseConfig} from 'browser-database-config'
import {Schema} from 'database/schema.interface'
export class Config {
  static readonly routing = <RoutingConfig>{
    base: '/'
  }
  static readonly pages = <PagesConfig>{
    recipeTable: <PageConfig>{
      title: 'My Recipes',
      route: 'recipe-table',
      menuLink: true,
      databaseTable: 'recipes'
    },
    recipe: <PageConfig>{
      title: 'Recipe',
      route: 'recipe',
      menuLink: true,
      databaseTable: 'recipes'
    }
  }
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
