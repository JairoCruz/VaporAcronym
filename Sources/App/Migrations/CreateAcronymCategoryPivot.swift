import Vapor
import Fluent

struct CreateAcronymCategoryPivot: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronym-category-pivot")
        .id()
        .field("acronymID", .uuid, .references("acronymus", "id", onDelete: .cascade))
        .field("categoryID", .uuid, .references("categories", "id", onDelete: .cascade))
        .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronym-category-pivot").delete()
    }

}