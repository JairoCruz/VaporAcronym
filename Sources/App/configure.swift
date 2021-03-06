import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    

    if let databaseURL = Environment.get("DATABASE_URL") {
        
    app.databases.use(try .postgres(url: databaseURL), as: .psql)
    print("paso aqui")
} else {
    print("paso aqui2")
    app.databases.use(.postgres(hostname: "localhost", username: "jc", password: "jairo", database: "jc"), as: .psql)
}


    //app.migrations.add(CreateTodo())
    app.migrations.add(CreateAcronym())
    app.migrations.add(CreateUser())
    app.migrations.add(AddRelationAcronym())
    app.migrations.add(CreateCategory())
    app.migrations.add(CreateAcronymCategoryPivot())
    app.migrations.add(AddUserPassword())
    

    // register routes
    try routes(app)
}
