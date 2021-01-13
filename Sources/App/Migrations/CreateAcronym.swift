import Vapor
import FluentSQLiteDriver

struct CreateAcronym: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronymus")
        .id()
        .field("short", .string)
        .field("long", .string)
        .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronymus").delete()
    }

}