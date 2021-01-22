import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    // Register Acronym Routes
    try app.register(collection: AcronymController())
    
    // Register User Routes
    try app.register(collection: UserController())

    // Register Category Routes
    try app.register(collection: CategoriesController())

    /**

    // Read
    app.get("api","acronymus") { req in 
       Acronym.query(on: req.db).all()
    }

    // Create
    app.post("api","acronymus") { req -> EventLoopFuture<Acronym> in 
        let acronym = try req.content.decode(Acronym.self)
        return acronym.create(on: req.db)
        .map { acronym }
    }

    // Read with Id
    app.get("api","acronymus",":id") { req in 
        
        return Acronym.find(req.parameters.get("id", as: UUID.self), on: req.db)
        .unwrap(or: Abort(.notFound))
    }

    // Update
    app.put("api", "acronymus", ":id") { req -> EventLoopFuture<Acronym> in 
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let input = try req.content.decode(Acronym.self)
        return Acronym.find(id, on: req.db).unwrap(or: Abort(.notFound)).flatMap { acronym in 
            acronym.short = input.short
            acronym.long = input.long
            return acronym.update(on: req.db).map { acronym }
         }
    }


    // Delete
    app.delete("api", "acronymus", ":id") { req -> EventLoopFuture<HTTPStatus> in 
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Acronym.find(id, on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { $0.delete(on: req.db) }
        .map { .ok }
    }

    // Search
    app.get("api","acronymus","search") { req -> EventLoopFuture<[Acronym]> in 
        guard let searchTerm = req.query[String.self, at: "term"] else {
            throw Abort(.badRequest)
        }

        return Acronym.query(on: req.db).filter(\.$short == searchTerm).sort(\.$long).all()
    } 
  **/
}
