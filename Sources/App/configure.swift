import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.postgres(hostname: "localhost", username: "alb", password: "jairo", database: "alb"), as: .psql)
    //app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    

    if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
    postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
    app.databases.use(.postgres(
        configuration: postgresConfig
    ), as: .psql)
    } else {
    
    }


    //app.migrations.add(CreateTodo())
    app.migrations.add(CreateAcronym())

    // register routes
    try routes(app)
}
