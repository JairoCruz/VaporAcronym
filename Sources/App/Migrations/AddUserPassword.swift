import Vapor
import Fluent

struct AddUserPassword: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
        .field("password", .string)
        .unique(on: "username", name: "no_duplicate_usernames")
        .update()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }

}