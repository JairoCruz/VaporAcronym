import Vapor

struct AcronymController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {

        // Routes
        routes.get("api","acronymus", use: getAll)



       

    }


     // Get All Acronym
        func getAll(_ req: Request) throws -> EventLoopFuture<[Acronym]> {
            Acronym.query(on: req.db).all()
        }
}