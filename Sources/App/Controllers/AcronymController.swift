import Vapor
import Fluent

struct AcronymController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {

        // Routes
       // routes.get("api","acronymus", use: getAll)
       let acronymRoutes = routes.grouped("api","acronymus")
       
       acronymRoutes.get(use: getAll)
       acronymRoutes.post(use: create)

       acronymRoutes.get("search", use: searchAcronym)

       // Use :id
       acronymRoutes.group(":id") { acronym in 
        acronym.get(use: show)
        acronym.put(use: update)
        acronym.delete(use: delete)
       }



       

    }


    // Get All Acronym
    func getAll(_ req: Request) throws -> EventLoopFuture<[Acronym]> {
        Acronym.query(on: req.db).all()
    }

    // Create
    func create(req: Request) throws -> EventLoopFuture<Acronym> {
        let acronym = try req.content.decode(Acronym.self)
        return acronym.create(on: req.db).map { acronym }
    }

    // Show
    func show(_ req: Request) throws -> EventLoopFuture<Acronym> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.internalServerError)
        }

        return Acronym.find(id, on: req.db)
                .unwrap(or: Abort(.notFound))
    }


    // Update
    func update(_ req: Request) throws -> EventLoopFuture<Acronym> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.internalServerError)
        }

        let inputData = try req.content.decode(Acronym.self)
        return Acronym.find(id, on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { acronym in 
            acronym.short = inputData.short
            acronym.long = inputData.long
            return acronym.update(on: req.db).map { acronym }
        }

    }

    // Delete
    func delete(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.internalServerError)
        }

        return Acronym.find(id, on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { $0.delete(on: req.db) }
        .map { .ok }
    }

    // Search
    func searchAcronym(_ req: Request) throws -> EventLoopFuture<[Acronym]> {
    guard let searchTerm = req.query[String.self, at: "term"] else {
        throw Abort(.internalServerError)
    }
    return Acronym.query(on: req.db).filter(\.$short == searchTerm).sort(\.$long).all()
   }
}