export interface PageConfig {
  title: string
  route: string
  menuLink?: boolean
  databaseTable?: string
}

export interface PagesConfig {
  recipeTable: PageConfig
  recipe: PageConfig
}
