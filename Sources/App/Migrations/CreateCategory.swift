import Vapor
import Fluent

struct CreateCategory: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("categories")
        .id()
        .field("name", .string)
        .field("created_at", .date)
        .field("updated_at", .date)
        .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("categories").delete()
    }
}