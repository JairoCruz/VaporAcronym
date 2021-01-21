import Vapor
import Fluent

final class User: Model, Content {
    // Name of the table or collection.

    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "username")
    var username: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Children(for: \.$user)
    var acronyms: [Acronym]
    

    init() { }

    init(name: String, username: String) {
        self.name = name
        self.username = username
    }

}