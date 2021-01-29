import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {

        // Routes
        let userRoutes = routes.grouped("api","users")

        userRoutes.get(use: getAll)
        userRoutes.post(use: create)
        userRoutes.get("acronyms", use: getAllUserAcronyms)

        // Use :id
        userRoutes.group(":id") { user in 
            user.get(use: show)
            user.put(use: update)
            user.delete(use: delete)
            user.get("acronyms", use: getUserAcronyms)
        }

    }

    /** Methods  **/

    // Get All
    func getAll(_ req: Request) throws -> EventLoopFuture<[User]> {
        User.query(on: req.db).all()
    }

    // Create
    func create(req: Request) throws -> EventLoopFuture<User.Public> {
        let user = try req.content.decode(User.self)
        user.password = try Bcrypt.hash(user.password)
        return user.create(on: req.db).convertToPublic()
        //return user.create(on: req.db).map { user }
    }

    // Show
    func show(_ req: Request) throws -> EventLoopFuture<User> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.internalServerError)
        }
        return User.find(id, on: req.db)
                .unwrap(or: Abort(.notFound))
    }
    
    // Update
    func update(_ req: Request) throws -> EventLoopFuture<User> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.internalServerError)
        }

        let inputData = try req.content.decode(User.self)
        return User.find(id, on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { user in 
            user.name = inputData.name
            user.username = inputData.username
            return user.update(on: req.db).map { user }
        }
    }

    // Delete
    func delete(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.internalServerError)
        }

        return User.find(id, on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { $0.delete(on: req.db) }
        .map { .ok }
    }

    // Get All Acronym
    func getAllUserAcronyms(_ req: Request) throws -> EventLoopFuture<[User]> {
        User.query(on: req.db).with(\.$acronyms).all()
    }

    func getUserAcronyms(_ req: Request) throws -> EventLoopFuture<[Acronym]> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.internalServerError)
        }
        return User.find(id, on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { user in 
            user.$acronyms.get(on: req.db)
        }
    }

}