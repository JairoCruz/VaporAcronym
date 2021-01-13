import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    app.get("acronymus") { req in 
        Acronym.query(on: req.db).all()
    }


    app.post("acronymus") { req -> EventLoopFuture<Acronym> in 
        let acronym = try req.content.decode(Acronym.self)
        return acronym.create(on: req.db)
        .map { acronym }
    }
}
