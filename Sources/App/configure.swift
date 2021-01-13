import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    

    if let databaseURL = Environment.get("DATABASE_URL") {
    app.databases.use(try .postgres(
        url: databaseURL
    ), as: .psql)
} else {
    app.databases.use(.postgres(hostname: "localhost", username: "alb", password: "jairo", database: "alb"), as: .psql)
}


    //app.migrations.add(CreateTodo())
    app.migrations.add(CreateAcronym())

    // register routes
    try routes(app)
}
