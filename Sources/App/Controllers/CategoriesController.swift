import Vapor
import Fluent

struct CategoriesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {

        let categoriesRoutes = routes.grouped("api", "categories")

        categoriesRoutes.get(use: getAll)
        categoriesRoutes.post(use: create)

        // Use :id
        categoriesRoutes.group(":id") { category in 
            category.get("acronyms", use: getAcronyms)
        }

    }



    func getAll(_ req: Request) throws -> EventLoopFuture<[Category]> {
        Category.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Category> {
        let category = try req.content.decode(Category.self)
        return category.create(on: req.db).map { category }
    }


    func getAcronyms(_ req: Request) throws -> EventLoopFuture<[Acronym]> {
        Category.find(req.parameters.get("id"), on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { category in 
        category.$acronyms.get(on: req.db)
        }
    }

}