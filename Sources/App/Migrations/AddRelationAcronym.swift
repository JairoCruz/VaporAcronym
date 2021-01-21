import Vapor
import Fluent

struct AddRelationAcronym: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronymus")
        .field("user_id", .uuid, .references("users","id"))
        .field("created_at", .date)
        .field("updated_at", .date)
        .update()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronymus").delete()
    }

}