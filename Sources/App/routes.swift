import Fluent
import Vapor

func routes(_ app: Application) throws {

    let acronymsController = AcronymsController()
    try app.register(collection: acronymsController)
    
    let userController = UserController()
    try app.register(collection: userController)
    
    let categoriesController = CategoryController()
    try app.register(collection: categoriesController)
    
    let websiteController = WebsiteController()
    try app.register(collection: websiteController)
}
