import Vapor
import Fluent

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
        .id()
        .field("name", .string)
        .field("username", .string)
        .field("created_at", .date)
        .field("updated_at", .date)
        .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }

}